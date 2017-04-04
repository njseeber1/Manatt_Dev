using CMS.Helpers;
using CMS.PortalControls;
using CMS.PortalEngine;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSWebParts_Manatt_TwitterLiveFeedTile : CMSAbstractWebPart
{
    //Referenced from SocialApp
    //Developed by Laura Frese (lfrese@imediainc.com)
    //iMedia Inc http://www.imediainc.com/
    private string TWITTER_API_URI = "https://api.twitter.com/1.1/statuses/user_timeline.json?count=20&exclude_replies=true&include_rts=false&trim_user=1&screen_name={0}";
    private string s_twitter_user = null;
    private string s_TwitterOAuthConsumerID = null;
    private string s_TwitterOAuthConsumerSecret = null;
    private string s_TwitterOAuthAccessToken = null;
    private string s_TwitterOAuthAccessSecret = null;
    private string s_CustomHtml = null;
    private int i_num_tweets = 0;
    //store oauth version here
    private static string version = "1.0";
    //store signature method here
    private static string signaturemethod = "HMAC-SHA1";

    /// <summary>
    /// Gets or sets the name of the Twitter User
    /// </summary>
    public string TwitterUser
    {
        get
        {
            return ValidationHelper.GetString(GetValue("TwitterUserName"), s_twitter_user);
        }
        set
        {
            SetValue("TwitterUserName", value);
            s_twitter_user = value;
        }
    }

    public string TwitterOAuthConsumerID
    {
        get
        {
            return ValidationHelper.GetString(GetValue("TwitterOAuthConsumerID"), s_TwitterOAuthConsumerID);
        }
        set
        {
            SetValue("TwitterOAuthConsumerID", value);
            s_TwitterOAuthConsumerID = value;
        }
    }

    public string TwitterOAuthConsumerSecret
    {
        get
        {
            return ValidationHelper.GetString(GetValue("TwitterOAuthConsumerSecret"), s_TwitterOAuthConsumerSecret);
        }
        set
        {
            SetValue("TwitterOAuthConsumerSecret", value);
            s_TwitterOAuthConsumerSecret = value;
        }
    }

    public string TwitterOAuthAccessToken
    {
        get
        {
            return ValidationHelper.GetString(GetValue("TwitterOAuthAccessToken"), s_TwitterOAuthAccessToken);
        }
        set
        {
            SetValue("TwitterOAuthAccessToken", value);
            s_TwitterOAuthAccessToken = value;
        }
    }

    public string TwitterOAuthAccessSecret
    {
        get
        {
            return ValidationHelper.GetString(GetValue("TwitterOAuthAccessSecret"), s_TwitterOAuthAccessSecret);
        }
        set
        {
            SetValue("TwitterOAuthAccessSecret", value);
            s_TwitterOAuthAccessSecret = value;
        }
    }

    public int TweetCount
    {
        get
        {
            return ValidationHelper.GetInteger(GetValue("TweetCount"), i_num_tweets);
        }
        set
        {
            SetValue("TweetCount", value);
            i_num_tweets = value;
        }
    }

    public string CustomHTML
    {
        get
        {
            return ValidationHelper.GetString(GetValue("CustomHTML"), s_CustomHtml);
        }
        set
        {
            SetValue("CustomHTML", value);
            s_CustomHtml = value;
        }
    }

    /// <summary>
    /// Content loaded event handler.
    /// </summary>
    public override void OnContentLoaded()
    {
        base.OnContentLoaded();
        SetupControl();
    }


    /// <summary>
    /// Initializes the control properties.
    /// </summary>
    protected void SetupControl()
    {
        // In design mode is processing of control stopped
        if (StopProcessing)
        {
            // Do nothing
        }
        else
        {
            LoadTweets();
        }
    }


    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        // Due to new design mode (with preview) we need to move map down for the user to be able to drag and drop the control
        if (PortalContext.IsDesignMode(PortalContext.ViewMode))
        {
            LoadTweets();
        }
        //LoadTweets();
    }

    private void LoadTweets()
    {
        List<String> tweets = GetRandomTweet().ToList();
        StringBuilder sb = new StringBuilder();
        foreach (String s in tweets)
        {
            sb.Append(s);
        }
        ltlPlaceholder.Text = sb.ToString();
    }

    public List<String> GetRandomTweet()
    {
        List<string> tw_list = new List<string>();
        string resourceurl = string.Format(TWITTER_API_URI, TwitterUser);
        string tw_response = GetTwitterData(resourceurl);
        JavaScriptSerializer ser = new JavaScriptSerializer();
        dynamic tweets = ser.Deserialize<dynamic>(tw_response);

        foreach (var t in tweets)
        {
            try
            {
                string tw_str = CustomHTML;
                //DateTime date = Convert.ToDateTime((string)t["created_at"]);
                DateTime dt = DateTime.ParseExact((string)t["created_at"],
                                                  "ddd MMM dd HH:mm:ss zzz yyyy",
                                                  CultureInfo.InvariantCulture,
                                                  DateTimeStyles.AdjustToUniversal);

                string date = (string)t["created_at"];
                string s = string.Format(tw_str, "https://twitter.com/" + TwitterUser + "/status/" + t["id"], t["text"], dt.ToString("ddd, MMM dd, yyyy"));
                tw_list.Add(s);
            }
            catch
            {
                string dsd = "";
            }
        }

        if (tw_list.Count > 0)
        {
            return tw_list.OrderBy(x => Guid.NewGuid()).Take(TweetCount).ToList();
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
        Uri.EscapeDataString(TwitterOAuthConsumerID),
        Uri.EscapeDataString(nonce),
        Uri.EscapeDataString(signature),
        Uri.EscapeDataString(signaturemethod),
        Uri.EscapeDataString(timestamp),
        Uri.EscapeDataString(TwitterOAuthAccessToken),
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

        var signingKey = string.Concat(Uri.EscapeDataString(TwitterOAuthConsumerSecret), "&", Uri.EscapeDataString(TwitterOAuthAccessSecret));
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
        baseformat.Add("oauth_consumer_key=" + TwitterOAuthConsumerID);
        baseformat.Add("oauth_nonce=" + nonce);
        baseformat.Add("oauth_signature_method=" + signaturemethod);
        baseformat.Add("oauth_timestamp=" + timestamp);
        baseformat.Add("oauth_token=" + TwitterOAuthAccessToken);
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

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}