using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CMS.FormControls;
using CMS.Helpers;
using CMS.Membership;

using TreeNode = CMS.DocumentEngine.TreeNode;
using CMS.ExtendedControls;
using CMS.DataEngine;
using CMS.CustomTables;

public partial class CMSFormControls_Manatt_Shared_RelatedPractice : FormEngineUserControl
{
    #region Public Properties

    public override object Value
    {
        get
        {
            return labelForm.Text;
        }

        set
        {
            labelForm.Text = System.Convert.ToString(value);
        }
    }

    public int SelectorWidth
    {
        get
        {
            return ValidationHelper.GetInteger(GetValue("SelectorWidth"), 0);
        }
        set
        {
            SetValue("SelectorWidth", value);
        }
    }

    public TreeNode TreeNode
    {
        get;
        set;
    }

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
        // Registers the default CSS and JavaScript files onto the page (used to style the UniGrid)
        CSSHelper.RegisterBootstrap(Page);
        ScriptHelper.RegisterBootstrapScripts(Page);


        // Set tree node from Form object
        if ((TreeNode == null) && (Form != null) && (Form.EditedObject != null))
        {
            var node = Form.EditedObject as TreeNode;
            if ((node != null) && (Form.Mode == FormModeEnum.Update))
            {
                TreeNode = node;
                btnAddRelationship.Enabled = true;
                btnAddRelationship.OnClientClick = string.Format("modalDialog('/CMSFormControls/Manatt/Shared/AddRelatedPractice.aspx?DocumentId={0}&externalControlID={1}', 'AddRelatedPractice', '700', '300'); return false;", TreeNode.DocumentID, ClientID);
                ScriptHelper.RegisterClientScriptBlock(this, typeof(string), "RefreshUpdatePanel_" + ClientID, ScriptHelper.GetScript(
                "function RefreshUpdatePanel_" + ClientID + "(){ " + Page.ClientScript.GetPostBackEventReference(pnlUpdate, "insert") + "; } \n"));
                GetCustomData();
                LoadGrid();
            }
            else
            {
                ShowInformation("Click Save to add Related Practices.");
                btnAddRelationship.Enabled = false;
            }
        }

        // Assigns a handler for the OnAction event
        RelatedPracticeGrid.OnAction += RelatedPracticeGrid_OnAction;
        RelatedPracticeGrid.ShowActionsMenu = false;
    }

    /// <summary>
    // Handles the UniGrid's OnAction event.
    /// </summary>
    protected void RelatedPracticeGrid_OnAction(string actionName, object actionArgument)
    {
        // Implements the logic of the delete action
        if (actionName == "delete")
        {
            try
            {
                var relationship = CustomTableItemProvider.GetItem(Convert.ToInt32(actionArgument.ToString()), this.CustomTable);
                relationship.Delete();
                LoadGrid();
            }
            catch (Exception e)
            {
                ShowError(e.Message);
            }
        }
    }

    protected void LoadGrid()
    {
        //Grid Data source
        var query = new DataQuery(this.CustomTable + ".SelectQuery");
        QueryDataParameters parameters = new QueryDataParameters();
        parameters.Add(this.CustomParameter, TreeNode == null ? 0 : TreeNode.DocumentID);
        query.Parameters = parameters;
        var result = query.Result;
        RelatedPracticeGrid.DataSource = result;
    }

    protected void GetCustomData()
    {
        try
        {
            switch (this.TreeNode.ClassName)
            {
                case "Manatt.Insights":
                    this.CustomTable = "Manatt.InsightRelatedPracticeRelationship";
                    this.CustomParameter = "@InsightId";
                    break;
                case "Manatt.DocumentEvent":
                    this.CustomTable = "Manatt.EventRelatedPracticeRelationship";
                    this.CustomParameter = "@EventId";
                    break;
                case "Manatt.DocumentNews":
                    this.CustomTable = "Manatt.NewRelatedPracticeRelationship";
                    this.CustomParameter = "@NewId";
                    break;
                case "Manatt.DocumentNewsletter":
                    this.CustomTable = "Manatt.NewsletterRelatedPracticeRelationship";
                    this.CustomParameter = "@NewsletterId";
                    break;
                case "Manatt.Practice":
                    this.CustomTable = "Manatt.StandardPracticeRelatedPracticeRelationship";
                    this.CustomParameter = "@StandardPracticeId";
                    break;
                default:
                    throw new Exception("ClassName not found.");
            }
        }
        catch (Exception ex)
        {
            ShowError(ex.Message);
        }
    }
}