using CMS.DataEngine;
using CMS.Helpers;
using CMS.Membership;
using CMS.SiteProvider;
using CMS.UIControls;
using ManattClientAdmin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

[UIElement("ManattClientAdmin", "AdminUsersEditManattClientCompany")]
public partial class CMSModules_ManattAdmin_CompanyAdminUsers : CMSDeskPage
{
    private static string EditClientAdminPage = SettingsKeyInfoProvider.GetValue(SiteContext.CurrentSite + ".EditClientAdminUser");
    private static string ClientAdminListPage = SettingsKeyInfoProvider.GetValue(SiteContext.CurrentSite + ".ClientAdminUserList");
    protected void Page_Load(object sender, EventArgs e)
    {
        // Registers the default CSS and JavaScript files onto the page (used to style the UniGrid)
        CSSHelper.RegisterBootstrap(Page);
        ScriptHelper.RegisterBootstrapScripts(Page);
        Session["ObjectId"] = Request.QueryString["objectid"];
        // Assigns a handler for the OnAction event
        UserGrid.OnAction += userGrid_OnAction;

        //Grid Data source
        var query = new DataQuery("cms.user.manattclientadminusers");
        QueryDataParameters parameters = new QueryDataParameters();
        parameters.Add("@CompanyId", Session["ObjectId"]);
        query.Parameters = parameters;
        UserGrid.DataSource = query.Result;

        //this.lblId.Text = Request.QueryString["objectId"];
    }

    /// <summary>
    // Handles the UniGrid's OnAction event.
    /// </summary>
    protected void userGrid_OnAction(string actionName, object actionArgument)
    {
        if (actionName == "edit")
        {
            int userId = ValidationHelper.GetInteger(actionArgument, 0);
            UserInfo user = UserInfoProvider.GetUserInfo(userId);
            if (user != null)
            {
                URLHelper.Redirect(EditClientAdminPage + "?Type=U&UserGuid=" + user.UserGUID + "&CompanyId=" + this.ObjectId());
            }
        }
        else if (actionName == "delete")
        {
            int userId = ValidationHelper.GetInteger(actionArgument, 0);
            UserInfo user = UserInfoProvider.GetUserInfo(userId);
            if (user != null)
            {
                if(user.Enabled)
                {
                    ManattClientCompanyInfo company = ManattClientCompanyInfoProvider.GetManattClientCompanyInfo(this.ObjectId());
                    company.ManattClientCompanySeatsAssigned -= 1;
                    company.ManattClientCompanySeatsAvailable = company.ManattClientCompanySeats - company.ManattClientCompanySeatsAssigned;
                    ManattClientCompanyInfoProvider.SetManattClientCompanyInfo(company);
                }
                UserInfoProvider.DeleteUser(user);
                URLHelper.Redirect(ClientAdminListPage + "?objectid=" + this.ObjectId());
                
            }
        }

    }

    protected void btnNew_Click(object sender, EventArgs e)
    {
        URLHelper.Redirect(EditClientAdminPage + "?Type=I&CompanyId=" + this.ObjectId());
    }

    private int ObjectId()
    {
        return ValidationHelper.GetInteger(Session["ObjectId"], 0);
    }
}