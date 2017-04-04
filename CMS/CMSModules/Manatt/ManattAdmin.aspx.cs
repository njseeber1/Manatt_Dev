using CMS.DataEngine;
using CMS.ExtendedControls;
using CMS.Helpers;
using CMS.Membership;
using CMS.SiteProvider;
using CMS.UIControls;
using CMS.ExtendedControls.ActionsConfig;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

[UIElement("NewManattAdminUsers", "ManualManattAdminList")]
public partial class CMSModules_ManattAdmin_ManattAdmin : CMSDeskPage
{
    private static string NewAccountPage = SettingsKeyInfoProvider.GetValue(SiteContext.CurrentSite + ".EditAdminUser");
    private static string AdminListPage = SettingsKeyInfoProvider.GetValue(SiteContext.CurrentSite + ".AdminUserList");
    protected void Page_Load(object sender, EventArgs e)
    {
        // Registers the default CSS and JavaScript files onto the page (used to style the UniGrid)
        CSSHelper.RegisterBootstrap(Page);
        ScriptHelper.RegisterBootstrapScripts(Page);

        // Assigns a handler for the OnAction event
        UserGrid.OnAction += userGrid_OnAction;

        //Grid Data source
        var query = new DataQuery("cms.user.manattadminusers");
        UserGrid.DataSource = query.Result;

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
                URLHelper.Redirect(NewAccountPage + "?Type=U&UserGuid=" + user.UserGUID);
            }
        }
        else if (actionName == "delete")
        {
            int userId = ValidationHelper.GetInteger(actionArgument, 0);
            if (MembershipContext.AuthenticatedUser.UserID == userId)
            {
                this.error.Visible = true;
                this.lblError.Text = "You can't delete your own account.";
            }
            else
            {
                UserInfo user = UserInfoProvider.GetUserInfo(userId);
                if (user != null)
                {
                    UserInfoProvider.DeleteUser(user);
                    URLHelper.Redirect(AdminListPage);
                }
            }
        }
    }

    protected void btnNew_Click(object sender, EventArgs e)
    {
        URLHelper.Redirect(NewAccountPage + "?Type=I");
    }
}