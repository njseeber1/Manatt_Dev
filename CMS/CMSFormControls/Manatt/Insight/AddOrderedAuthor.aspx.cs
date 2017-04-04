using CMS.CustomTables;
using CMS.Helpers;
using CMS.UIControls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSFormControls_Manatt_Insight_AddOrderedAuthor : CMSModalPage
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
        this.lblAuthor.Text = "Select Author: ";
        lblOrder.Text = "Order Number: ";

    }


    private void btnSave_Click(object sender, EventArgs e)
    {
        var selectedAuthor = ValidationHelper.GetString(UserSelector.Value, null);
        if (selectedAuthor == UserSelector.NoneRecordValue)
        {
            ShowInformation("Please choose an author.");
        }
        else
        {
            var authors = CustomTableItemProvider.GetItems("Manatt.InsightAuthors").WhereEquals("InsightsID", this.DocumentID).ToList();

            if (authors != null)
            {
                foreach (var item in authors)
                {
                    if ((int)item.GetValue("PeopleDocumentID") == Convert.ToInt32(selectedAuthor))
                    {
                        ShowInformation("The selected author already exists.");
                        return;
                    }
                }
            }
            try
            {
                CustomTableItem author = CustomTableItem.New("Manatt.InsightAuthors");
                author.ItemCreatedBy = this.CurrentUser.UserID;
                author.ItemCreatedWhen = DateTime.Now;
                author.ItemModifiedBy = this.CurrentUser.UserID;
                author.ItemModifiedWhen = DateTime.Now;
                author.ItemGUID = Guid.NewGuid();
                author.SetValue("InsightsID", this.DocumentID);
                author.SetValue("PeopleDocumentID", Convert.ToInt32(selectedAuthor));
                if (!string.IsNullOrEmpty(txtOrderNumber.Text))
                    author.ItemOrder = int.Parse(txtOrderNumber.Text);

                author.Insert();

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