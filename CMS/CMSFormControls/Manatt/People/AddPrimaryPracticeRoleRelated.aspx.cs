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

public partial class CMSFormControls_Manatt_People_AddPrimaryPracticeRoleRelated : CMSModalPage
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

        Page.Title = "Add Primary Practice/Role";
        PageTitle.TitleText = "Add Primary Practice/Role";
        Save += btnSave_Click;
        this.lblPrimaryPractice.Text = "Select Primary Practice: ";
        this.lblRole.Text = "Select Role: ";
        lblOrder.Text = "Order Number: ";

        if (!IsPostBack)
        {
            List<CMS.DocumentEngine.TreeNode> practices = new List<CMS.DocumentEngine.TreeNode>();
            var services = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Services", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.Practice" && d.NodeLinkedNodeID == 0).ToList();
            var industries = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Industries", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.Practice" && d.NodeLinkedNodeID == 0).ToList();
            var roles = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Data-And-Lists/Roles", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.Role").ToList();

            practices.AddRange(services);
            practices.AddRange(industries);

            ddlPractice.Items.Add(new ListItem { Text = "-- Select Primary Practice --", Value = "0" });
            foreach (var practice in practices.OrderBy(p => p.DocumentName))
            {
                ddlPractice.Items.Add(new ListItem { Text = practice.DocumentName, Value = practice.DocumentID.ToString() });
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
        if (ddlPractice.SelectedValue == "0")
        {
            ShowInformation("Please select a Primary Practice");
        }
        else
        {
            var relationships = CustomTableItemProvider.GetItems("Manatt.PeoplePrimaryPracticeRelationship").WhereEquals("PeopleId", this.DocumentID).ToList();

            if (relationships.Count > 0)
            {
                ShowInformation("The Primary Practice already exists.");
                return;
            }
            try
            {
                CustomTableItem relationship = CustomTableItem.New("Manatt.PeoplePrimaryPracticeRelationship");
                relationship.ItemCreatedBy = this.CurrentUser.UserID;
                relationship.ItemCreatedWhen = DateTime.Now;
                relationship.ItemModifiedBy = this.CurrentUser.UserID;
                relationship.ItemModifiedWhen = DateTime.Now;
                relationship.ItemGUID = Guid.NewGuid();
                relationship.SetValue("PeopleId", this.DocumentID);
                relationship.SetValue("PracticeId", ddlPractice.SelectedValue);
                relationship.SetValue("RoleId", Convert.ToInt32(ddlRole.SelectedValue) == 0 ? null : ddlRole.SelectedValue);
                if(!string.IsNullOrEmpty(txtOrderNumber.Text))
                    relationship.SetValue("OrderNumber", txtOrderNumber.Text);
                relationship.Insert();
                               
                string script = "if (wopener.RefreshUpdatePanel_" + externalControlID + ") { wopener.RefreshUpdatePanel_" + externalControlID + "(); CloseDialog(); } ";
                ltlScript.Text = ScriptHelper.GetScript(script);
            }
            catch(Exception ex)
            {
                ShowError(ex.Message);
            }
        }
    }
}