using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.DataEngine;
using CMS.Helpers;
using CMS.DocumentEngine;
using CMS.Membership;
using CMS.UIControls;
using CMS.CustomTables;
using CMS.ExtendedControls;

public partial class CMSFormControls_Manatt_Practice_AddPracticeRelatedClient : CMSModalPage
{

    #region "Variables"
    
    private string externalControlID;

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        // Initialize modal page
        RegisterEscScript();
        ScriptHelper.RegisterWOpenerScript(Page);

        externalControlID = QueryHelper.GetString("externalControlID", string.Empty);

        Page.Title = "Add Practice Client";
        PageTitle.TitleText = "Add Practice Client"; ;
        Save += btnSave_Click;
        this.lblClientName.Text = "Client Name: ";
        this.lblClientLogo.Text = "Select Logo: ";

        //if (!IsPostBack)
        //{
        //    var careers = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Corporate/CareersPage", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.CareerType").ToList();
        //    var offices = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Corporate/Offices", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.Offices").ToList();

        //    ddlCareer.Items.Add(new ListItem { Text = "-- Select Career --", Value = "0" });
        //    foreach (var career in careers)
        //    {
        //        ddlCareer.Items.Add(new ListItem { Text = career.DocumentName, Value = career.DocumentID.ToString() });
        //    }

        //    ddlOffice.Items.Add(new ListItem { Text = "-- Select Office --", Value = "0" });
        //    foreach (var office in offices)
        //    {
        //        ddlOffice.Items.Add(new ListItem { Text = office.DocumentName, Value = office.DocumentID.ToString() });
        //    }
        //}
    }

    private void btnSave_Click(object sender, EventArgs e)
    {

        string clientName = txtClientName.Text;
        if (string.IsNullOrEmpty(clientName))
        {
            ShowInformation("The Client Name is required.");
            return;
        }

        try
        {
            CustomTableItem relationship = CustomTableItem.New("Manatt.PracticeRelatedClient");
            relationship.ItemCreatedBy = this.CurrentUser.UserID;
            relationship.ItemCreatedWhen = DateTime.Now;
            relationship.ItemModifiedBy = this.CurrentUser.UserID;
            relationship.ItemModifiedWhen = DateTime.Now;
            relationship.ItemGUID = Guid.NewGuid();
            relationship.SetValue("PracticeDocumentID", this.DocumentID);
            relationship.SetValue("ClientName", txtClientName.Text);           
            relationship.SetValue("ClientLogo", mediaSelector.Value);
            relationship.Insert();

            string url = string.Format("{0}://{1}/CMSModules/Content/CMSDesk/Edit/edit.aspx?nodeid={2}&culture=en-US", HttpContext.Current.Request.Url.Scheme, HttpContext.Current.Request.Url.Authority, this.DocumentID);
            string script = "CloseDialog();";
            string script2 = "if (wopener.RefreshUpdatePanel_" + externalControlID + ") { wopener.RefreshUpdatePanel_" + externalControlID + "(); CloseDialog(); } ";
            ltlScript.Text = ScriptHelper.GetScript(script2);
        }
        catch (Exception ex)
        {
            ShowError(ex.Message);
        }

    }
}