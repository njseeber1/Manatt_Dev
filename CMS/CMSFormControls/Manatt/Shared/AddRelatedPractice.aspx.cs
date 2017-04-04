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

public partial class CMSFormControls_Manatt_Shared_AddRelatedPractice : CMSModalPage
{
    #region "Variables"

    private string externalControlID;

    #endregion

    #region Public Properties

    public string CustomTable
    {
        get;
        set;
    }

    public string CustomParameter
    {
        get;
        set;
    }

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        // Initialize modal page
        RegisterEscScript();
        ScriptHelper.RegisterWOpenerScript(Page);

        externalControlID = QueryHelper.GetString("externalControlID", string.Empty);

        Page.Title = "Add Related Practice";
        PageTitle.TitleText = "Add Related Practice";
        Save += btnSave_Click;
        this.lblRelatedPractice.Text = "Select Related Practice: ";

        GetCustomData();

        if (!IsPostBack)
        {
            List<CMS.DocumentEngine.TreeNode> practices = new List<CMS.DocumentEngine.TreeNode>();
            var services = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Services", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.Practice" && d.NodeLinkedNodeID == 0).ToList();
            var industries = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Industries", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).Where(d => d.ClassName == "Manatt.Practice" && d.NodeLinkedNodeID == 0).ToList();            

            practices.AddRange(services);
            practices.AddRange(industries);

            ddlRelatedPractice.Items.Add(new ListItem { Text = "-- Select Related Service --", Value = "0" });
            foreach (var service in practices.OrderBy(p => p.DocumentName))
            {
                ddlRelatedPractice.Items.Add(new ListItem { Text = service.DocumentName, Value = service.DocumentID.ToString() });
            }            
        }
    }

    private void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlRelatedPractice.SelectedValue == "0")
        {
            ShowInformation("Please select a Related Practice");
        }
        else
        {
            var relationships = CustomTableItemProvider.GetItems(this.CustomTable).WhereEquals(this.CustomParameter, this.DocumentID).ToList();

            if (relationships != null)
            {
                foreach (var relationship in relationships)
                {
                    if ((int)relationship.GetValue("PracticeId") == Convert.ToInt32(ddlRelatedPractice.SelectedValue))
                    {
                        ShowInformation("The selected practice already exists.");
                        return;
                    }
                }
            }
            try
            {
                CustomTableItem relationship = CustomTableItem.New(this.CustomTable);
                relationship.ItemCreatedBy = this.CurrentUser.UserID;
                relationship.ItemCreatedWhen = DateTime.Now;
                relationship.ItemModifiedBy = this.CurrentUser.UserID;
                relationship.ItemModifiedWhen = DateTime.Now;
                relationship.ItemGUID = Guid.NewGuid();
                relationship.SetValue(this.CustomParameter, this.DocumentID);
                relationship.SetValue("PracticeId", ddlRelatedPractice.SelectedValue);                
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

    protected void GetCustomData()
    {
        try
        {
            switch (this.Node.ClassName)
            {
                case "Manatt.Insights":
                    this.CustomTable = "Manatt.InsightRelatedPracticeRelationship";
                    this.CustomParameter = "InsightId";
                    break;
                case "Manatt.DocumentEvent":
                    this.CustomTable = "Manatt.EventRelatedPracticeRelationship";
                    this.CustomParameter = "EventId";
                    break;
                case "Manatt.DocumentNews":
                    this.CustomTable = "Manatt.NewRelatedPracticeRelationship";
                    this.CustomParameter = "NewId";
                    break;
                case "Manatt.DocumentNewsletter":
                    this.CustomTable = "Manatt.NewsletterRelatedPracticeRelationship";
                    this.CustomParameter = "NewsletterId";
                    break;
                case "Manatt.Practice":
                    this.CustomTable = "Manatt.StandardPracticeRelatedPracticeRelationship";
                    this.CustomParameter = "StandardPracticeId";
                    break;
                default:
                    throw new Exception("ClassName not found.");                    
            }
        }
        catch(Exception ex)
        {
            ShowError(ex.Message);
        }
    }
}