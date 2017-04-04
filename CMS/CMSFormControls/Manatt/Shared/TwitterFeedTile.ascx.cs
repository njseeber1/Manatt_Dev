using CMS.EventLog;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSFormControls_Manatt_Shared_TwitterFeedTile : System.Web.UI.UserControl
{
    public string TwitterUserName { get; set; }
    private string TWITTER_API_URI = "https://api.twitter.com/1.1/statuses/user_timeline.json?count=20&exclude_replies=true&include_rts=false&trim_user=1&screen_name={0}";
    private string s_TwitterOAuthConsumerID = null;
    private string s_TwitterOAuthConsumerSecret = null;
    private string s_TwitterOAuthAccessToken = null;
    private string s_TwitterOAuthAccessSecret = null;
    private int i_num_tweets = 0;
    //store oauth version here
    private static string version = "1.0";
    //store signature method here
    private static string signaturemethod = "HMAC-SHA1";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(TwitterUserName))
                TwitterUserName = ConfigurationManager.AppSettings["TwitterUserName"];
            s_TwitterOAuthConsumerID = ConfigurationManager.AppSettings["TwitterOAuthConsumerID"];
            s_TwitterOAuthConsumerSecret = ConfigurationManager.AppSettings["TwitterOAuthConsumerSecret"];
            s_TwitterOAuthAccessToken = ConfigurationManager.AppSettings["TwitterOAuthAccessToken"];
            s_TwitterOAuthAccessSecret = ConfigurationManager.AppSettings["TwitterOAuthAccessSecret"];
            int.TryParse(ConfigurationManager.AppSettings["TweetCount"], out i_num_tweets);

            List<TwitterFeed> tweets = GetRandomTweet().ToList();

            rptTwitterFeed.DataSource = tweets;
            rptTwitterFeed.DataBind();
        }
        catch (Exception ex)
        {
            lblError.Visible = true;
            lblError.Text = "Error encountered while loading twitter feeds.";
            EventLogProvider.LogException("Twitter Feed Tile", "Loading Twitter: " + TwitterUserName, ex);
        }
    }

    public List<TwitterFeed> GetRandomTweet()
    {
        List<TwitterFeed> tw_list = new List<TwitterFeed>();
        string resourceurl = string.Format(TWITTER_API_URI, TwitterUserName);
        string tw_response = GetTwitterData(resourceurl);
        JavaScriptSerializer ser = new JavaScriptSerializer();
        dynamic tweets = ser.Deserialize<dynamic>(tw_response);

        foreach (var t in tweets)
        {
            try
            {
                var feed = new TwitterFeed();

                DateTime ddate = DateTime.ParseExact((string)t["created_at"],
                                                  "ddd MMM dd HH:mm:ss zzz yyyy",
                                                  CultureInfo.InvariantCulture,
                                                  DateTimeStyles.AdjustToUniversal);

                feed.Link = "https://twitter.com/" + TwitterUserName + "/status/" + t["id"];
                feed.Text = t["text"];
                feed.DateText = ddate.ToString("MM/dd/yyyy");
                feed.Date = ddate;
                tw_list.Add(feed);

            }
            catch
            {
            }
        }

        if (tw_list.Count > 0)
        {
            return tw_list.OrderByDescending(x => x.Date).Take(i_num_tweets).ToList();
        }
        else
        {
            return null;
        }
    }

    public string GetTwitterData(string resourceurl)
    {
        //create parameter list
        List<string> parameterlist;
        //check for query string
        if (resourceurl.Contains("?"))
        {
            parameterlist = getparameterlistfromurl(resourceurl);
            resourceurl = resourceurl.Substring(0, resourceurl.IndexOf('?'));
        }

        else
        {
            parameterlist = null;
        }
        //build the oauth header
        string authheader = buildheader(resourceurl, parameterlist);

        //make the request to the twitter api and get the JSON response
        string jsonresponse = TwitterWebRequest(resourceurl, authheader, parameterlist);

        return jsonresponse;


    }


    private string TwitterWebRequest(string resourceurl, string authheader, List<string> parameterlist)
    {

        //build  the http web request to the twitter api
        ServicePointManager.Expect100Continue = false;

        string postBody;

        if (parameterlist != null)
        {
            postBody = GetPostBody(parameterlist);
        }
        else
        {
            postBody = "";
        }
        resourceurl += "?" + postBody;

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(resourceurl);
        request.Headers.Add("Authorization", authheader);
        request.Method = "GET";
        request.ContentType = "application/x-www-form-urlencoded";

        // Retrieve the response json data
        WebResponse response = request.GetResponse();

        //json reponse data
        string responseData = new System.IO.StreamReader(response.GetResponseStream()).ReadToEnd();

        return responseData;

    }

    private string GetPostBody(List<string> parameterlist)
    {
        string stringtoreturn = "";

        foreach (string item in parameterlist)
        {
            stringtoreturn += item + "&";

        }
        stringtoreturn = stringtoreturn.TrimEnd('&');
        return stringtoreturn;

    }

    //retreive a list if parameters from the resource url. This will be used when making the request to the twitter api and in generating the signature
    private List<string> getparameterlistfromurl(string resourceurl)
    {

        //Uri MyUrl = new Uri(resourceurl);
        string querystring = resourceurl.Substring(resourceurl.IndexOf('?') + 1);



        List<string> listtoreturn = new List<string>();


        NameValueCollection nv = HttpUtility.ParseQueryString(querystring);

        foreach (string parameter in nv)
        {
            listtoreturn.Add(parameter + "=" + Uri.EscapeDataString(nv[parameter].ToString()));

        }
        return listtoreturn;
    }



    //this gets the timeline data from twitter api
    private string buildheader(string resourceurl, List<string> parameterlist)
    {

        string nonce = Convert.ToBase64String(new ASCIIEncoding().GetBytes(DateTime.Now.Ticks.ToString()));
        TimeSpan timespan = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
        string timestamp = Convert.ToInt64(timespan.TotalSeconds).ToString();

        string signature = getSignature(nonce, timestamp, resourceurl, parameterlist);

        // build the authentication header with all information collected

        var HeaderFormat = "OAuth " +
        "oauth_consumer_key=\"{0}\", " +
        "oauth_nonce=\"{1}\", " +
        "oauth_signature=\"{2}\", " +
        "oauth_signature_method=\"{3}\", " +
        "oauth_timestamp=\"{4}\", " +
        "oauth_token=\"{5}\", " +
        "oauth_version=\"{6}\"";

        string authHeader = string.Format(HeaderFormat,
        Uri.EscapeDataString(s_TwitterOAuthConsumerID),
        Uri.EscapeDataString(nonce),
        Uri.EscapeDataString(signature),
        Uri.EscapeDataString(signaturemethod),
        Uri.EscapeDataString(timestamp),
        Uri.EscapeDataString(s_TwitterOAuthAccessToken),
        Uri.EscapeDataString(version)
        );

        return authHeader;

    }



    private string getSignature(string nonce, string timestamp, string resourceurl, List<string> parameterlist)
    {
        // generate the base string for the signature

        string baseString = generatebasestring(nonce, timestamp, resourceurl, parameterlist);

        baseString = string.Concat("GET&", Uri.EscapeDataString(resourceurl), "&", Uri.EscapeDataString(baseString));


        // generate the signature using the base string, consumer secret and access secret from the application api. Using the HMAC-SHA1 signature method

        var signingKey = string.Concat(Uri.EscapeDataString(s_TwitterOAuthConsumerSecret), "&", Uri.EscapeDataString(s_TwitterOAuthAccessSecret));
        string signature;

        //generate hash using signing key
        HMACSHA1 hasher = new HMACSHA1(ASCIIEncoding.ASCII.GetBytes(signingKey));

        signature = Convert.ToBase64String(hasher.ComputeHash(ASCIIEncoding.ASCII.GetBytes(baseString)));
        //get signature signature using the hash

        return signature;

    }

    private string generatebasestring(string nonce, string timestamp, string resourceurl, List<string> parameterlist)
    {

        string basestring = "";
        //create list with all the security parameters
        List<string> baseformat = new List<string>();
        baseformat.Add("oauth_consumer_key=" + s_TwitterOAuthConsumerID);
        baseformat.Add("oauth_nonce=" + nonce);
        baseformat.Add("oauth_signature_method=" + signaturemethod);
        baseformat.Add("oauth_timestamp=" + timestamp);
        baseformat.Add("oauth_token=" + s_TwitterOAuthAccessToken);
        baseformat.Add("oauth_version=" + version);


        //append parameter list as twitter requires the parameters to be in alphabetical order
        if (parameterlist != null)
        {
            baseformat.AddRange(parameterlist);

        }
        //sort list alphabetically
        baseformat.Sort();


        //loop through list and generate base string

        foreach (string value in baseformat)
        {
            basestring += value + "&";
        }

        basestring = basestring.TrimEnd('&');

        return basestring;


    }

    public class TwitterFeed
    {
        public DateTime Date { get; set; }
        public string Link { get; set; }
        public string Text { get; set; }
        public string DateText { get; set; }
    }
}