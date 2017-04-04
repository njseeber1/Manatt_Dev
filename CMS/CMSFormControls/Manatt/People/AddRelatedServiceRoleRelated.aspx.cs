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

public partial class CMSFormControls_Manatt_People_AddRelatedServiceRoleRelated : CMSModalPage
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

        Page.Title = "Add Related Service/Role";
        PageTitle.TitleText = "Add Related Service/Role";
        Save += btnSave_Click;
        this.lblRelatedService.Text = "Select Related Service: ";
        this.lblRole.Text = "Select Role: ";
        lblOrder.Text = "Order Number: ";

        if (!IsPostBack)
        {            
            var services = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Services", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.Practice" && d.NodeLinkedNodeID == 0).ToList();            
            var roles = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Data-And-Lists/Roles", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.Role").ToList();
            
            ddlRelatedService.Items.Add(new ListItem { Text = "-- Select Related Service --", Value = "0" });
            foreach (var service in services.OrderBy(p => p.DocumentName))
            {
                ddlRelatedService.Items.Add(new ListItem { Text = service.DocumentName, Value = service.DocumentID.ToString() });
            }

            ddlRole.Items.Add(new ListItem { Text = "-- Select Role --", Value = "0" });
            foreach (var role in roles)
            {
                ddlRole.Items.Add(new ListItem { Text = role.DocumentName, Value = role.DocumentID.ToString() });
            }
        }
    }

    private void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlRelatedService.SelectedValue == "0")
        {
            ShowInformation("Please select a Related Service");
        }
        else
        {
            var relationships = CustomTableItemProvider.GetItems("Manatt.PeopleOtherRelatedServicesRelationship").WhereEquals("PeopleId", this.DocumentID).ToList();
            
            if (relationships != null)
            {
                foreach (var relationship in relationships)
                {
                    if ((int)relationship.GetValue("RelatedServiceId") == Convert.ToInt32(ddlRelatedService.SelectedValue))
                    {
                        ShowInformation("The selected service already exists.");
                        return;
                    }
                }
            }
            try
            {
                CustomTableItem relationship = CustomTableItem.New("Manatt.PeopleOtherRelatedServicesRelationship");
                relationship.ItemCreatedBy = this.CurrentUser.UserID;
                relationship.ItemCreatedWhen = DateTime.Now;
                relationship.ItemModifiedBy = this.CurrentUser.UserID;
                relationship.ItemModifiedWhen = DateTime.Now;
                relationship.ItemGUID = Guid.NewGuid();
                relationship.SetValue("PeopleId", this.DocumentID);
                relationship.SetValue("RelatedServiceId", ddlRelatedService.SelectedValue);
                relationship.SetValue("RoleId", Convert.ToInt32(ddlRole.SelectedValue) == 0 ? null : ddlRole.SelectedValue);
                if (!string.IsNullOrEmpty(txtOrderNumber.Text))
                    relationship.SetValue("OrderNumber", txtOrderNumber.Text);
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