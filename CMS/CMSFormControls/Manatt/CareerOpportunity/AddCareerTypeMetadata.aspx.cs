using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.DataEngine;
using CMS.Helpers;
using CMS.DocumentEngine;
using CMS.UIControls;
using CMS.CustomTables;
using CMS.ExtendedControls;

public partial class CMSFormControls_Manatt_CareerOpportunity_AddCareerTypeMetadata : CMSModalPage
{
    #region "Variables"

    private string externalControlID;
    private string itemID;

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        // Initialize modal page
        RegisterEscScript();
        ScriptHelper.RegisterWOpenerScript(Page);

        externalControlID = QueryHelper.GetString("externalControlID", string.Empty);
        itemID = QueryHelper.GetString("itemID", string.Empty);

        Page.Title = "Add Career Type Content";
        PageTitle.TitleText = "Add Career Type Content";
        Save += btnSave_Click;

        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(itemID))
            {
                var customItem = CustomTableItemProvider.GetItem(int.Parse(itemID), "Manatt.CareerTypeBenefits");
                if (customItem != null)
                {
                    txtName.Text = customItem.GetValue("Name").ToString();
                    txtContent.Text = customItem.GetValue("Content").ToString();
                }
            }
        }
    }

    private void btnSave_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtName.Text))
        {
            ShowInformation("Please enter name.");
        }
        else
        {
            try
            {
                if (!string.IsNullOrEmpty(itemID))
                {
                    var customItem = CustomTableItemProvider.GetItem(int.Parse(itemID), "Manatt.CareerTypeBenefits");
                    if (customItem != null)
                    {
                        customItem.SetValue("Name", txtName.Text);
                        customItem.SetValue("Content", txtContent.Text);
                        customItem.Update();
                    }
                }
                else {
                    CustomTableItem customItem = CustomTableItem.New("Manatt.CareerTypeBenefits");
                    customItem.ItemCreatedBy = this.CurrentUser.UserID;
                    customItem.ItemCreatedWhen = DateTime.Now;
                    customItem.ItemModifiedBy = this.CurrentUser.UserID;
                    customItem.ItemModifiedWhen = DateTime.Now;
                    customItem.ItemGUID = Guid.NewGuid();
                    customItem.SetValue("CareerTypeID", this.DocumentID);
                    customItem.SetValue("Name", txtName.Text);
                    customItem.SetValue("Content", txtContent.Text);
                    customItem.Insert();
                }

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