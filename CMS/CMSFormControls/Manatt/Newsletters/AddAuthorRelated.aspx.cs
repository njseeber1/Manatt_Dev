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

public partial class CMSFormControls_Manatt_Newsletters_AddAuthorRelated : CMSModalPage
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

        Page.Title = "Add Author";
        PageTitle.TitleText = "Add Author";
        Save += btnSave_Click;
        this.lblAuthor.Text = "Author: ";

        if (!IsPostBack)
        {
            var authors = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/People", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.People").ToList();
            ddlAuthor.Items.Add(new ListItem { Text = "-- Select Author --", Value = "0" });
            foreach (var author in authors.OrderBy(a => a.DocumentName))
            {
                ddlAuthor.Items.Add(new ListItem { Text = author.DocumentName, Value = author.DocumentID.ToString() });
            }
        }
    }

    private void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlAuthor.SelectedValue == "0")
        {
            ShowInformation("Please select an author.");
        }
        else
        {
            var relationships = CustomTableItemProvider.GetItems("Manatt.NewsletterAuthorRelationship").WhereEquals("NewsletterId", this.DocumentID).ToList();
            if (relationships != null)
            {
                foreach (var relationship in relationships)
                {
                    if ((int)relationship.GetValue("PeopleId") == Convert.ToInt32(ddlAuthor.SelectedValue))
                    {
                        ShowInformation("The selected author already exists.");
                        return;
                    }
                }
            }
            try
            {
                CustomTableItem relationship = CustomTableItem.New("Manatt.NewsletterAuthorRelationship");
                relationship.ItemCreatedBy = this.CurrentUser.UserID;
                relationship.ItemCreatedWhen = DateTime.Now;
                relationship.ItemModifiedBy = this.CurrentUser.UserID;
                relationship.ItemModifiedWhen = DateTime.Now;
                relationship.ItemGUID = Guid.NewGuid();
                relationship.SetValue("NewsletterId", this.DocumentID);
                relationship.SetValue("PeopleId", ddlAuthor.SelectedValue);
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