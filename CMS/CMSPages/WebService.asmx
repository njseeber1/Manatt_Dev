<%@ WebService Language="C#" Class="WebService" %>

using System;
using System.Data;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;
using System.Collections.Generic;
using CMS.DataEngine;
using CMS.CustomTables;
using CMS.Helpers;
using CMS.DocumentEngine;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using SelectPdf;
/// <summary>
/// Empty web service template.
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[ScriptService]
public class WebService : System.Web.Services.WebService
{
    /// <summary>
    /// Constructor.
    /// </summary>
    public WebService()
    {
        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }


    /// <summary>
    /// Returns the data from DB.
    /// </summary>
    /// <param name="parameter">String parameter for sql command</param>
    [WebMethod]
    public DataSet GetDataSet(string parameter)
    {
        // INSERT YOUR WEB SERVICE CODE AND RETURN THE RESULTING DATASET

        return null;
    }


    /// <summary>
    /// The web service method to be called by AJAXControlToolkit. The signature of this method must match this method.
    /// Note that you can replace "GetCompletionList" with a name of your choice, but the return type and parameter name and type must exactly match, including case.
    /// </summary>
    /// <param name="prefixText">Prefix to be searched</param>
    /// <param name="count">Number of suggestions to be retrieved from the web service</param>
    /// <returns>Array of suggestions</returns>
    [WebMethod(MessageName = "GetCompletionList")]
    [ScriptMethod]
    public string[] GetCompletionList(string prefixText, int count)
    {
        // INSERT YOUR WEB SERVICE CODE AND RETURN THE RESULTING STRING ARRAY

        return null;
    }

    [WebMethod]
    [ScriptMethod]
    public List<ChairPerson> GetChairPersons(int documentId)
    {
        //ConfigurationManager.ConnectionStrings["CMSConnectionString"].ConnectionString
        var chairs = new List<ChairPerson>();
        using (SqlConnection con = new SqlConnection(ConnectionHelper.GetSqlConnectionString()))
        {
            using (SqlCommand cmd = new SqlCommand("PROC_Manatt_Practice_Chairs", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DocumentId", documentId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    chairs.Add(new ChairPerson
                    {
                        Email = dr["Email"].ToString(),
                        FullName = dr["FullName"].ToString()
                    });
                };
            }
        }

        return chairs;
    }


    [WebMethod]
    [ScriptMethod]
    public string GetPracticeNameByDocumentId(int documentId)
    {
        GeneralConnection cn = ConnectionHelper.GetConnection();
        QueryDataParameters parameters = new QueryDataParameters();
        parameters.Add("@documentId", documentId);
        var query = new QueryParameters("select DocumentName as PracticeName from view_cms_tree_joined where ClassName = 'Manatt.Practice' and NodeLinkedNodeSiteId is null and DocumentId = @documentId", parameters, QueryTypeEnum.SQLQuery);
        var ds = cn.ExecuteQuery(query);
        string result = "";
        foreach (DataTable tbl in ds.Tables)
            foreach (DataRow dr in tbl.Rows)
                result = dr["PracticeName"].ToString();

        return result;
    }

    [WebMethod]
    [ScriptMethod]
    public List<NewsletterNode> GetNewsletterNodes(int practiceId)
    {
        var currentNewsletterDocumentIds = new List<int>();
        var nodes = new List<NewsletterNode>();

        using (SqlConnection con = new SqlConnection(ConnectionHelper.GetSqlConnectionString()))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT DocumentId FROM View_CMS_Tree_Joined " +
                                                   "WHERE NodeId IN " +
                                                   " (SELECT DISTINCT VN.NodeParentId " +
                                                   "FROM Manatt_NewsletterRelatedPracticeRelationship N " +
                                                   "INNER JOIN View_CMS_Tree_Joined VN WITH (NOLOCK, NOEXPAND) ON N.NewsletterId = VN.DocumentId AND VN.DocumentCanBePublished = 1 " +
                                                   "WHERE N.PracticeId = @PracticeId) AND Nodelevel = 3", con))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@PracticeId", practiceId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    currentNewsletterDocumentIds.Add(Convert.ToInt32(dr["DocumentId"]));
                };

                dr.Close();
            }

            using (SqlCommand cmd = new SqlCommand("SELECT DocumentId, DocumentName FROM View_CMS_Tree_Joined WHERE nodealiaspath like '%/newsletters/%' and nodelevel = 3 ORDER BY DocumentName", con))
            {
                cmd.CommandType = CommandType.Text;
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    nodes.Add(new NewsletterNode
                    {
                        Id = Convert.ToInt32(dr["DocumentId"]),
                        Name = dr["DocumentName"].ToString(),
                        IsSelected = currentNewsletterDocumentIds.Contains(Convert.ToInt32(dr["DocumentId"]))
                    });
                };
                dr.Close();
            }
        }

        return nodes;
    }

    [WebMethod]
    [ScriptMethod]
    public void SubscribeToNewsletters(string firstname, string lastname, string email, string country, string title, string company, string[] newsletters)
    {
        string body =
                       "<table border='1' cellpadding='10' cellspacing='1'>" +
                       " <tr valign='top'>                    " +
                       "     <td>First Name :</td>" +
                       "     <td>{0}</td>        " +
                       " </tr>                   " +
                       " <tr>                    " +
                       "     <td>Last Name :</td>" +
                       "     <td>{1}</td>        " +
                       " </tr>                   " +
                       " <tr>                    " +
                       "     <td>Title :</td>    " +
                       "     <td>{2}</td>        " +
                       " </tr>                   " +
                       " <tr>                    " +
                       "     <td>Email :</td>    " +
                       "     <td>{3}</td>        " +
                       " </tr>                   " +
                       " <tr>                    " +
                       "     <td>Company :</td>    " +
                       "     <td>{4}</td>        " +
                       " </tr>                   " +
                       " <tr>                    " +
                       "     <td>Country :</td>  " +
                       "     <td>{5}</td>        " +
                       " </tr>                   " +
                       " <tr>                    " +
                       "     <td>Newsletter(s) :</td>" +
                       "     <td><p>{6}</p></td>        " +
                       " </tr>                   " +
                       "</table>";


        CMS.EmailEngine.EmailMessage em = new CMS.EmailEngine.EmailMessage();
        em.EmailFormat = CMS.EmailEngine.EmailFormatEnum.Html;
        em.From = ConfigurationManager.AppSettings["contactFormEmailSender"];
        //em.Recipients = "jroque@thinklogic.net";
        em.Recipients = ConfigurationManager.AppSettings["NewsletterSubscriptionRecipients"];
        em.Subject = "Newsletter Subscription Request";
        em.Body = string.Format(body, firstname, lastname, title, email, company, country, string.Join("<br />", newsletters));
        CMS.EmailEngine.EmailSender.SendEmail("Manatt", em);

        CustomTableItem customItem = CustomTableItem.New("Manatt.NewsletterSubscriptions");
        customItem.ItemCreatedWhen = DateTime.UtcNow;
        customItem.ItemGUID = Guid.NewGuid();
        customItem.SetValue("FirstName", SqlHelper.EscapeQuotes(firstname));
        customItem.SetValue("LastName", SqlHelper.EscapeQuotes(lastname));
        customItem.SetValue("Title", SqlHelper.EscapeQuotes(title));
        customItem.SetValue("EmailAddress", SqlHelper.EscapeQuotes(email));
        customItem.SetValue("Company", SqlHelper.EscapeQuotes(company));
        customItem.SetValue("Country", SqlHelper.EscapeQuotes(country));
        customItem.SetValue("Newsletters", string.Join("|", newsletters));
        customItem.Insert();
    }

    [WebMethod]
    [ScriptMethod]
    public void SendContactForm(string emailTo, string emailFrom, string name, string title, string phone, string message, string practice)
    {
        string body = "<table>                  " +
                      " <tr>                    " +
                      "     <td>Name :</td>     " +
                      "     <td>{0}</td>        " +
                      " </tr>                   " +
                      " <tr>                    " +
                      "     <td>Title :</td>    " +
                      "     <td>{1}</td>        " +
                      " </tr>                   " +
                      " <tr>                    " +
                      "     <td>Email :</td>    " +
                      "     <td>{2}</td>        " +
                      " </tr>                   " +
                      " <tr>                    " +
                      "     <td>Phone :</td>    " +
                      "     <td>{3}</td>        " +
                      " </tr>                   " +
                      " <tr>                    " +
                      "     <td>Message :</td>  " +
                      "     <td>{4}</td>        " +
                      " </tr>                   " +
                      "</table>";

        CMS.EmailEngine.EmailMessage em = new CMS.EmailEngine.EmailMessage();
        em.EmailFormat = CMS.EmailEngine.EmailFormatEnum.Html;
        em.From = ConfigurationManager.AppSettings["contactFormEmailSender"];
        em.Recipients = emailTo; //uncomment when we go live
        //em.Recipients = "jroque@thinklogic.net";

        if (string.IsNullOrEmpty(practice))
            em.Subject = "Customer Contact Form";
        else
            em.Subject = string.Format("Customer Contact Form {0} Practice", practice);

        em.Body = string.Format(body, name, title, emailFrom, phone, message);

        em.Body += " <br><br>Original recepient : " + emailTo;

        CMS.EmailEngine.EmailSender.SendEmail("Manatt", em);

    }

    [WebMethod]
    [ScriptMethod]
    public void SendShareThisPageEmail(string senderName, string recipientName, string senderEmail, string recipientEmail, string url)
    {
        string body = "<table>                  " +
                      " <tr>                    " +
                      "     <td>Dear {0},</td>     " +
                      " </tr>                   " +
                      " <tr>                    " +
                      @"<td>Manatt is sending this e-mail message to you in behalf of {2} request. He/she thought you 
                        would find the content referenced on the Manatt web page below of interest: </td> " +
                      " </tr>                   " +
                      " <tr>                    " +
                      "     <td>{1}</td>    " +
                      " </tr>                   " +
                      " <tr>                    " +
                      "     <td>&nbsp;</td>    " +
                      " </tr>                   " +
                      " <tr>                    " +
                      "     <td>Thank You</td>    " +
                      " </tr>                   " +
                      " <tr>                    " +
                      "     <td>http://www.manatt.com</td>  " +
                      " </tr>                   " +
                      "</table>";

        CMS.EmailEngine.EmailMessage em = new CMS.EmailEngine.EmailMessage();
        em.EmailFormat = CMS.EmailEngine.EmailFormatEnum.Html;
        em.From = ConfigurationManager.AppSettings["contactFormEmailSender"];
        em.Recipients = recipientEmail;
        //em.Recipients = "rsato@thinklogic.net;jmcintyre@thinklogic.net";
        em.Subject = "Manatt - Shared This Page";

        string mailFrom = string.Format("<a href='mailto:{0}'>{1}</a>", senderEmail, senderName);
        em.Body = string.Format(body, recipientName, url, mailFrom);
        //comment the code below before going live
        //em.Body += " <br><br>Original recepient : " + recipientEmail;

        CMS.EmailEngine.EmailSender.SendEmail("Manatt", em);
    }



    public class ChairPerson
    {
        public string FullName { get; set; }
        public string Email { get; set; }
    }

    [Serializable]
    public struct KeyValuePair<K, V>
    {
        public K Key { get; set; }
        public V Value { get; set; }
    }

    public class NewsletterNode
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public bool IsSelected { get; set; }
    }
}

    