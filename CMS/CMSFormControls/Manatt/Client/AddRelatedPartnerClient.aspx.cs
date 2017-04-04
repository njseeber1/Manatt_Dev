using System;
using System.Web.UI;
using CMS.Helpers;
using CMS.UIControls;
using CMS.CustomTables;


public partial class CMSFormControls_Manatt_Client_AddRelatedPartnerClient : CMSModalPage
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

        Page.Title = "Add Partnert Client";
        PageTitle.TitleText = "Add Partner Client"; ;
        Save += btnSave_Click;
        this.lblClientName.Text = "Client Name: ";
        this.lblClientLogo.Text = "Select Logo: ";
        this.lblClientURL.Text = "Select URL: ";
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
            CustomTableItem relationship = CustomTableItem.New("Manatt.ClientPartnerClientRelationship");
            relationship.ItemCreatedBy = this.CurrentUser.UserID;
            relationship.ItemCreatedWhen = DateTime.Now;
            relationship.ItemModifiedBy = this.CurrentUser.UserID;
            relationship.ItemModifiedWhen = DateTime.Now;
            relationship.ItemGUID = Guid.NewGuid();
            relationship.SetValue("ClientId", this.DocumentID);
            relationship.SetValue("PartnerClientName", txtClientName.Text);
            relationship.SetValue("PartnerClientLogo", mediaSelector.Value);
            relationship.SetValue("PartnerClientURL", urlSelector.Value);
            relationship.Insert();

            string script = "if (wopener.RefreshUpdatePanel_" + externalControlID + ") { wopener.RefreshUpdatePanel_" + externalControlID + "(); CloseDialog(); } ";
            ltlScript.Text = ScriptHelper.GetScript(script);
        }
        catch (Exception ex)
        {
            ShowError(ex.Message);
        }

    }
}