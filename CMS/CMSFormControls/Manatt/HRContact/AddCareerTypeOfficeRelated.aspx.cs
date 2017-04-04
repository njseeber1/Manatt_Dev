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

public partial class CMSFormControls_Manatt_HRContact_AddCareerTypeOfficeRelated : CMSModalPage
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

        Page.Title = "Add Carrer/Offices";
        PageTitle.TitleText = "Add Carrer/Offices";
        Save += btnSave_Click;
        this.lblCareer.Text = "Select Career: ";
        this.lblOffice.Text = "Select Office: ";

        if (!IsPostBack)
        {
            var careers = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Corporate/Careers", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.CareerType").ToList();
            var offices = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Corporate/Offices", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.Offices").ToList();

            ddlCareer.Items.Add(new ListItem { Text = "-- Select Career --", Value = "0" });
            foreach (var career in careers)
            {
                ddlCareer.Items.Add(new ListItem { Text = career.DocumentName, Value = career.DocumentID.ToString() });
            }

            ddlOffice.Items.Add(new ListItem { Text = "-- Select Office --", Value = "0" });
            foreach (var office in offices)
            {
                ddlOffice.Items.Add(new ListItem { Text = office.DocumentName, Value = office.DocumentID.ToString() });
            }
        }
    }

    private void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlCareer.SelectedValue == "0" || ddlOffice.SelectedValue == "0")
        {
            ShowInformation("Please select a carrer and an office.");
        }
        else
        {
            var relationships = CustomTableItemProvider.GetItems("Manatt.HRCareerTypeOfficeRelationship").WhereEquals("HRContactId", this.DocumentID).ToList();
            if (relationships != null)
            {
                foreach (var relationship in relationships)
                {
                    if ((int)relationship.GetValue("CareerTypeId") == Convert.ToInt32(ddlCareer.SelectedValue) && (int)relationship.GetValue("OfficeId") == Convert.ToInt32(ddlOffice.SelectedValue))
                    {
                        ShowInformation("The selected relationship already exists.");
                        return;
                    }
                }
            }
            try
            {
                CustomTableItem relationship = CustomTableItem.New("Manatt.HRCareerTypeOfficeRelationship");
                relationship.ItemCreatedBy = this.CurrentUser.UserID;
                relationship.ItemCreatedWhen = DateTime.Now;
                relationship.ItemModifiedBy = this.CurrentUser.UserID;
                relationship.ItemModifiedWhen = DateTime.Now;
                relationship.ItemGUID = Guid.NewGuid();
                relationship.SetValue("HRContactId", this.DocumentID);
                relationship.SetValue("CareerTypeId", ddlCareer.SelectedValue);
                relationship.SetValue("OfficeId", ddlOffice.SelectedValue);
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
}