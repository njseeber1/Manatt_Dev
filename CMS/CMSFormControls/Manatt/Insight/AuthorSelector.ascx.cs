using System;
using System.Web.UI;
using CMS.FormControls;
using CMS.Helpers;

using TreeNode = CMS.DocumentEngine.TreeNode;
using CMS.ExtendedControls;
using CMS.DataEngine;
using CMS.CustomTables;

public partial class CMSFormControls_Manatt_Insight_AuthorSelector : FormEngineUserControl
{
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
                btnAddRelationship.OnClientClick = string.Format("modalDialog('/CMSFormControls/Manatt/Insight/AddAuthor.aspx?DocumentId={0}&externalControlID={1}', 'AddAuthor', '800', '300'); return false;", TreeNode.DocumentID, ClientID);
                ScriptHelper.RegisterClientScriptBlock(this, typeof(string), "RefreshUpdatePanel_" + ClientID, ScriptHelper.GetScript(
                "function RefreshUpdatePanel_" + ClientID + "(){ " + Page.ClientScript.GetPostBackEventReference(pnlUpdate, "insert") + "; } \n"));
            }
            else
            {
                btnAddRelationship.Enabled = false;
                ShowInformation("Click Save to add Authors, Categories and Related Practices.");
            }
        }

        // Assigns a handler for the OnAction event
        AuthorGrid.OnAction += AuthorGrid_OnAction;
        AuthorGrid.ShowActionsMenu = false;
        LoadGrid();
    }

    /// <summary>
    // Handles the UniGrid's OnAction event.
    /// </summary>
    protected void AuthorGrid_OnAction(string actionName, object actionArgument)
    {
        // Implements the logic of the delete action
        if (actionName == "delete")
        {
            string customTableClassName = "Manatt.InsightAuthorRelationship";

            try
            {
                var relationship = CustomTableItemProvider.GetItem(Convert.ToInt32(actionArgument.ToString()), customTableClassName);
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
        var query = new DataQuery("Manatt.InsightAuthorRelationship.SelectQuery");
        QueryDataParameters parameters = new QueryDataParameters();
        parameters.Add("@InsightId", TreeNode == null ? 0 : TreeNode.DocumentID);
        query.Parameters = parameters;
        AuthorGrid.DataSource = query.Result;
    }
}