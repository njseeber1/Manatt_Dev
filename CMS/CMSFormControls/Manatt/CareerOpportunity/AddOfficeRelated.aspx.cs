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

public partial class CMSFormControls_Manatt_CareerOpportunity_AddOfficeRelated : CMSModalPage
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

        Page.Title = "Add Office";
        PageTitle.TitleText = "Add Office";
        Save += btnSave_Click;
        this.lblOffice.Text = "Select Office: ";

        if (!IsPostBack)
        {
            var offices = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Corporate/Offices-Landing", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.Offices" && d.NodeLinkedNodeID == 0).ToList();                        

            ddlOffice.Items.Add(new ListItem { Text = "-- Select Office --", Value = "0" });
            foreach (var office in offices.OrderBy(p => p.DocumentName))
            {
                ddlOffice.Items.Add(new ListItem { Text = office.DocumentName, Value = office.DocumentID.ToString() });
            }            
        }
    }

    private void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlOffice.SelectedValue == "0")
        {
            ShowInformation("Please select an Office");
        }
        else
        {
            var relationships = CustomTableItemProvider.GetItems("Manatt.CareerOpportunityOfficeRelationship").WhereEquals("CareerOpportunityId", this.DocumentID).ToList();

            if (relationships != null)
            {
                foreach (var relationship in relationships)
                {
                    if ((int)relationship.GetValue("OfficeId") == Convert.ToInt32(ddlOffice.SelectedValue))
                    {
                        ShowInformation("The selected office already exists.");
                        return;
                    }
                }
            }
            try
            {
                CustomTableItem relationship = CustomTableItem.New("Manatt.CareerOpportunityOfficeRelationship");
                relationship.ItemCreatedBy = this.CurrentUser.UserID;
                relationship.ItemCreatedWhen = DateTime.Now;
                relationship.ItemModifiedBy = this.CurrentUser.UserID;
                relationship.ItemModifiedWhen = DateTime.Now;
                relationship.ItemGUID = Guid.NewGuid();
                relationship.SetValue("CareerOpportunityId", this.DocumentID);
                relationship.SetValue("OfficeId", ddlOffice.SelectedValue);                
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
}