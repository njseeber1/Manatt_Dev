using CMS.DataEngine;
using CMS.Helpers;
using CMS.Membership;
using CMS.SiteProvider;
using CMS.UIControls;
using ManattClientAdmin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSModules_ManattAdmin_EditClientAdmin : CMSDeskPage
{
    private static string ClientAdminListPage = SettingsKeyInfoProvider.GetValue(SiteContext.CurrentSite + ".ClientAdminUserList");
    private static string smtpUser = SettingsKeyInfoProvider.GetValue(SiteContext.CurrentSite + ".CMSSMTPServerUser");
    protected void Page_Load(object sender, EventArgs e)
    {
        // Registers the default CSS and JavaScript files onto the page (used to style the UniGrid)
        CSSHelper.RegisterBootstrap(Page);
        ScriptHelper.RegisterBootstrapScripts(Page);

        if (!IsPostBack)
        {
            this.hiddenType.Value = Request.QueryString["Type"];
            if (Type() == "I")
            {
                this.lblTitle.Text = "Create new Manatt Client Admin";
                this.btnResetPassword.Visible = false;
            }
            else
            {
                this.lblTitle.Text = "Edit Manatt Client Admin";
                Session["UserGuid"] = Request.QueryString["UserGuid"];
                this.FillUserInformation();
            }
        }
        Session["CompanyId"] = Request.QueryString["CompanyId"];
    }

    protected void btnNewAdmin_Click(object sender, EventArgs e)
    {
        if (!(string.IsNullOrWhiteSpace(txtUserName.Text) || string.IsNullOrWhiteSpace(txtFirstName.Text) || string.IsNullOrWhiteSpace(txtLastName.Text) || string.IsNullOrWhiteSpace(txtEmail.Text)))
        {
            this.error.Visible = false;
            this.success.Visible = true;
            ManattClientCompanyInfo company = ManattClientCompanyInfoProvider.GetManattClientCompanyInfo(this.CompanyId());
            UserInfo user = new UserInfo();

            if (Type() == "I")
            {
                user = new UserInfo();

                //Set Properties
                user.UserName = txtUserName.Text;
                user.FirstName = txtFirstName.Text;
                user.LastName = txtLastName.Text;
                user.MiddleName = string.Empty;
                user.FullName = txtFirstName.Text + " " + txtLastName.Text;
                user.Email = txtEmail.Text;
                user.PreferredCultureCode = "en-us";
                user.PreferredUICultureCode = "en-US";
                user.Enabled = cbEnabled.Checked;
                user.IsExternal = false;
                user.UserStartingAliasPath = string.Empty;
                user.UserIsHidden = false;
                user.UserVisibility = string.Empty;
                user.UserIsDomain = false;
                user.UserMFRequired = false;
                user.SetValue("IsFirstTimeLogin", true);
                user.SetValue("CompanyId", company.ManattClientCompanyID);
                if(user.Enabled)
                {
                    company.ManattClientCompanySeatsAssigned += 1;
                    company.ManattClientCompanySeatsAvailable = company.ManattClientCompanySeats - company.ManattClientCompanySeatsAssigned;
                }                
            }
            else
            {
                user = UserInfoProvider.GetUserInfoByGUID(UserGuid());
                user.UserName = txtUserName.Text;
                user.FirstName = txtFirstName.Text;
                user.LastName = txtLastName.Text;
                user.FullName = txtFirstName.Text + " " + txtLastName.Text;
                user.Email = txtEmail.Text;
                if(user.Enabled != cbEnabled.Checked)
                {
                    user.Enabled = cbEnabled.Checked;
                    if(cbEnabled.Checked)
                    {
                        company.ManattClientCompanySeatsAssigned += 1;
                        company.ManattClientCompanySeatsAvailable = company.ManattClientCompanySeats - company.ManattClientCompanySeatsAssigned;
                    }
                    else
                    {
                        company.ManattClientCompanySeatsAssigned -= 1;
                        company.ManattClientCompanySeatsAvailable = company.ManattClientCompanySeats - company.ManattClientCompanySeatsAssigned;
                    }
                }
                this.lblSuccess.Text = "User updated successfully";
            }

            try
            {
                UserInfoProvider.SetUserInfo(user);
                ManattClientCompanyInfoProvider.SetManattClientCompanyInfo(company);
            }
            catch (Exception ex)
            {
                this.success.Visible = false;
                this.error.Visible = true;
                this.lblError.Text = ex.Message;
            }            

            if (user.UserID > 0 && Type() == "I")
            {
                UserInfoProvider.AddUserToSite(user.UserName, SiteContext.CurrentSiteName);
                string userPassword = UserInfoProvider.GenerateNewPassword(SiteContext.CurrentSiteName);
                UserInfoProvider.SetPassword(user, userPassword);
                RoleInfo role = RoleInfoProvider.GetRoleInfo("ClientAdmin", SiteContext.CurrentSiteID);
                if (role != null)
                {
                    UserRoleInfo userRole = new UserRoleInfo();
                    userRole.UserID = user.UserID;
                    userRole.RoleID = role.RoleID;
                    UserRoleInfoProvider.SetUserRoleInfo(userRole);
                    CMS.EmailEngine.EmailMessage email = new CMS.EmailEngine.EmailMessage();
                    email.EmailFormat = CMS.EmailEngine.EmailFormatEnum.Html;
                    email.From = "rsato@thinklogic.net";
                    email.Recipients = user.Email;
                    email.Subject = "Welcome!";
                    StringBuilder mailBody = new StringBuilder();
                    mailBody.AppendFormat("<h1>Welcome to Manatt - Healthcare Portal</h1>");
                    mailBody.AppendFormat("Dear {0},", user.FullName);
                    mailBody.AppendFormat("<br />");
                    mailBody.AppendFormat("<p>User Name: {0}</p>", user.UserName);
                    mailBody.AppendFormat("<p>Password: {0}</p>", userPassword);
                    mailBody.AppendFormat("<p><a href='{0}://{1}'>{2}</a></p>", Request.Url.Scheme, Request.Url.Authority, "Log In");
                    email.Body = mailBody.ToString();
                    CMS.EmailEngine.EmailSender.SendEmail(SiteContext.CurrentSiteName, email, false);
                }
                this.ResetForm();
                this.lblSuccess.Text = "User created successfully";
            }
        }
        else
        {
            this.success.Visible = false;
            this.error.Visible = true;
            this.lblError.Text = "Please enter all the required fields.";
        }
    }

    protected void btnResetPassword_Click(object sender, EventArgs e)
    {
        UserInfo user = new UserInfo();
        user = UserInfoProvider.GetUserInfoByGUID(UserGuid());
        string userPassword = UserInfoProvider.GenerateNewPassword(SiteContext.CurrentSiteName);
        UserInfoProvider.SetPassword(user, userPassword);

        CMS.EmailEngine.EmailMessage email = new CMS.EmailEngine.EmailMessage();
        email.EmailFormat = CMS.EmailEngine.EmailFormatEnum.Html;
        email.From = smtpUser;
        email.Recipients = user.Email;
        email.Subject = "Password Reset";
        StringBuilder mailBody = new StringBuilder();
        mailBody.AppendFormat("<h1>Healthcare Portal - Password Reset</h1>");
        mailBody.AppendFormat("Dear {0},", user.FullName);
        mailBody.AppendFormat("<br />");
        mailBody.AppendFormat("<p>Your password has been reset:</p>");
        mailBody.AppendFormat("<p>User Name: {0}</p>", user.UserName);
        mailBody.AppendFormat("<p>New Password: {0}</p>", userPassword);
        mailBody.AppendFormat("<p><a href='{0}://{1}'>{2}</a></p>", Request.Url.Scheme, Request.Url.Authority, "Log In");
        email.Body = mailBody.ToString();
        CMS.EmailEngine.EmailSender.SendEmail(SiteContext.CurrentSiteName, email, false);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Session.Remove("UserGuid");
        URLHelper.Redirect(ClientAdminListPage + "?objectid=" + this.CompanyId());
    }

    private void FillUserInformation()
    {
        UserInfo user = UserInfoProvider.GetUserInfoByGUID(UserGuid());
        if (user != null)
        {
            txtUserName.Text = user.UserName;
            txtFirstName.Text = user.FirstName;
            txtLastName.Text = user.LastName;
            txtEmail.Text = user.Email;
            cbEnabled.Checked = user.Enabled;
        }
    }

    private void ResetForm()
    {
        txtUserName.Text = string.Empty;
        txtFirstName.Text = string.Empty;
        txtLastName.Text = string.Empty;
        txtEmail.Text = string.Empty;
    }

    private string Type()
    {
        return this.hiddenType.Value;
    }

    private Guid UserGuid()
    {
        return ValidationHelper.GetGuid(Session["UserGuid"].ToString(), Guid.NewGuid());
    }

    private int CompanyId()
    {
        return ValidationHelper.GetInteger(Session["CompanyId"], 0);
    }
}