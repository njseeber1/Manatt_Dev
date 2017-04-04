using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CMS.DocumentEngine;
using CMS.Membership;
using System.Text.RegularExpressions;

public partial class UpdSearchFriendlyText : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Server.ScriptTimeout = 3200;
        Response.Buffer = false;

        // Creates an instance of the Tree provider
        TreeProvider tree = new TreeProvider(MembershipContext.AuthenticatedUser);

        // Gets the published version of pages stored under the "/Articles/" path
        // The pages are retrieved from the Dancing Goat site and in the "en-us" culture
        var pages = tree.SelectNodes()
            .Path("/Insights/", PathTypeEnum.Children)
            //.WhereLike("DocumentName", "Coffee%")
            //.OnSite("DancingGoat")
            //.WhereLike("ClassName", "Manatt.DocumentEvent")
            .Culture("en-us");

        // Updates the "DocumentName" and "ArticleTitle" fields of each retrieved page
        var cnt = 0;
        foreach (CMS.DocumentEngine.TreeNode page in pages)
        {
            cnt++;
            var str = page.DocumentName;
            //Response.Write(str + "<br />");
            Regex rgx = new Regex("[^a-zA-Z0-9 -]");
            var str2 = rgx.Replace(str, "");
            str2 = str2.Replace("-", " ");
            //var sftString = "";
            //var sft = page.GetValue("SearchFriendlyText");
            //if (sft != null)
            //    sftString = sft.ToString();

            if (str != str2)
            {
                try
                {
                    var checkedOutPage = DocumentHelper.GetDocument(page, tree);
                    VersionManager vm = VersionManager.GetInstance(tree);
                    vm.CheckOut(checkedOutPage);

                    Response.Write("<p>" + cnt + "<br />");
                    Response.Write(str + "<br />" + str2 + "<br />");
                    Response.Write("</p>");

                    checkedOutPage.SetValue("SearchFriendlyText", str2);
                    checkedOutPage.Update();
                    vm.CheckIn(checkedOutPage, null, "Programmatically Update SearchFriendlyText field.");
                    checkedOutPage.Publish();
                } catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }

            //page.DocumentName = "Updated article name";
            //page.SetValue("ArticleTitle", "Updated article title");

            // Updates the page in the database
            //page.Update();
        }
        Response.Write("<p>" + cnt + "</p>");
    }
}