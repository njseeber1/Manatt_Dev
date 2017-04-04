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

public partial class CMSFormControls_Manatt_People_AddStoryRelated : CMSModalPage
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

        Page.Title = "Add Story";
        PageTitle.TitleText = "Add Story";
        Save += btnSave_Click;
        this.lblStory.Text = "Story: ";

        if (!IsPostBack)
        {
            var stories = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Story", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.PeopleStory").ToList();
            ddlStory.Items.Add(new ListItem { Text = "-- Select Story --", Value = "0" });
            foreach (var story in stories.OrderBy(a => a.DocumentName))
            {
                ddlStory.Items.Add(new ListItem { Text = story.DocumentName, Value = story.DocumentID.ToString() });
            }
        }
    }

    private void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlStory.SelectedValue == "0")
        {
            ShowInformation("Please select a story.");
        }
        else
        {
            var relationships = CustomTableItemProvider.GetItems("Manatt.PeopleStoryRelationship").WhereEquals("PeopleId", this.DocumentID).ToList();
            if (relationships != null)
            {
                foreach (var relationship in relationships)
                {
                    if ((int)relationship.GetValue("StoryId") == Convert.ToInt32(ddlStory.SelectedValue))
                    {
                        ShowInformation("The selected story already exists.");
                        return;
                    }
                }
            }
            try
            {
                CustomTableItem relationship = CustomTableItem.New("Manatt.PeopleStoryRelationship");
                relationship.ItemCreatedBy = this.CurrentUser.UserID;
                relationship.ItemCreatedWhen = DateTime.Now;
                relationship.ItemModifiedBy = this.CurrentUser.UserID;
                relationship.ItemModifiedWhen = DateTime.Now;
                relationship.ItemGUID = Guid.NewGuid();
                relationship.SetValue("PeopleId", this.DocumentID);
                relationship.SetValue("StoryId", ddlStory.SelectedValue);
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