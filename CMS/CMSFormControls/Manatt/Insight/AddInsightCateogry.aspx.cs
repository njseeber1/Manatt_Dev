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

public partial class CMSFormControls_Manatt_Insight_AddInsightCateogry : CMSModalPage
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

        Page.Title = "Add Category";
        PageTitle.TitleText = "Add Category";
        Save += btnSave_Click;
        this.lblCategory.Text = "Category: ";

        if (!IsPostBack)
        {
            var categories = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Insights/Categories", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.InsightCategory").ToList();
            ddlCategory.Items.Add(new ListItem { Text = "-- Select Category --", Value = "0" });
            foreach (var category in categories.OrderBy(a => a.DocumentName))
            {
                ddlCategory.Items.Add(new ListItem { Text = category.DocumentName, Value = category.DocumentID.ToString() });
            }
        }
    }

    private void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlCategory.SelectedValue == "0")
        {
            ShowInformation("Please select a category.");
        }
        else
        {
            var relationships = CustomTableItemProvider.GetItems("Manatt.InsightCategoryRelationship").WhereEquals("InsightId", this.DocumentID).ToList();
            if (relationships != null)
            {
                foreach (var relationship in relationships)
                {
                    if ((int)relationship.GetValue("InsightCategoryId") == Convert.ToInt32(ddlCategory.SelectedValue))
                    {
                        ShowInformation("The selected category already exists.");
                        return;
                    }
                }
            }
            try
            {
                CustomTableItem relationship = CustomTableItem.New("Manatt.InsightCategoryRelationship");
                relationship.ItemCreatedBy = this.CurrentUser.UserID;
                relationship.ItemCreatedWhen = DateTime.Now;
                relationship.ItemModifiedBy = this.CurrentUser.UserID;
                relationship.ItemModifiedWhen = DateTime.Now;
                relationship.ItemGUID = Guid.NewGuid();
                relationship.SetValue("InsightId", this.DocumentID);
                relationship.SetValue("InsightCategoryId", ddlCategory.SelectedValue);
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