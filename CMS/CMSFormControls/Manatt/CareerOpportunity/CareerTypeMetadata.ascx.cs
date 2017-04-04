using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.FormControls;
using CMS.Helpers;
using TreeNode = CMS.DocumentEngine.TreeNode;
using CMS.ExtendedControls;
using CMS.DataEngine;
using CMS.CustomTables;

public partial class CMSFormControls_Manatt_CareerOpportunity_CareerTypeMetadata : FormEngineUserControl
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
                btnAddMetadata.Enabled = true;
                btnAddMetadata.OnClientClick = string.Format("modalDialog('/CMSFormControls/Manatt/CareerOpportunity/AddCareerTypeMetadata.aspx?DocumentId={0}&externalControlID={1}', 'AddCareerTypeMetadata', '1000', '700'); return false;", TreeNode.DocumentID, ClientID);
                ScriptHelper.RegisterClientScriptBlock(this, typeof(string), "RefreshUpdatePanel_" + ClientID, ScriptHelper.GetScript(
                "function RefreshUpdatePanel_" + ClientID + "(){ " + Page.ClientScript.GetPostBackEventReference(pnlUpdate, "insert") + "; } \n"));
            }
            else
            {
                btnAddMetadata.Enabled = false;
            }
        }

        // Assigns a handler for the OnAction event
        metadataUniGrid.OnAction += MetadataUniGrid_OnAction;
        metadataUniGrid.ShowActionsMenu = false;
        metadataUniGrid.OnExternalDataBound += MetadataUniGrid_OnExternalDataBound;
        
        LoadGrid();
    }
    
    private object MetadataUniGrid_OnExternalDataBound(object sender, string sourceName, object parameter)
    {
        object param = null;

        if (parameter is System.Web.UI.WebControls.GridViewRow)
        {
            param = ((System.Web.UI.WebControls.GridViewRow)parameter).DataItem;
        }
        else if (parameter is System.Data.DataRowView)
        {
            param = parameter;
        }

        string editedItemId = ((System.Data.DataRowView)(param)).Row["ItemID"].ToString();

        switch (sourceName)
        {            
            case "editaction":
                Button btn = ((Button)sender);
                btn.OnClientClick = string.Format("modalDialog('/CMSFormControls/Manatt/CareerOpportunity/AddCareerTypeMetadata.aspx?DocumentId={0}&externalControlID={1}&itemID={2}', 'AddCareerTypeMetadata', '1000', '700'); return false;", TreeNode.DocumentID, ClientID, editedItemId);
                return btn;                
        }

        return parameter;
    }

    private void MetadataUniGrid_OnAction(string actionName, object actionArgument)
    {
        // Implements the logic of the delete action
        if (actionName == "delete")
        {
            string customTableClassName = "Manatt.CareerTypeBenefits";

            try
            {
                var item = CustomTableItemProvider.GetItem(Convert.ToInt32(actionArgument.ToString()), customTableClassName);
                item.Delete();
                LoadGrid();
            }
            catch (Exception e)
            {
                ShowError(e.Message);
            }
        }
        else if(actionName == "edit")
        {

        }
    }

    protected void LoadGrid()
    {
        //Grid Data source
        var query = new DataQuery("Manatt.CareerTypeBenefits.SelectQuery");
        QueryDataParameters parameters = new QueryDataParameters();
        parameters.Add("@CareerTypeId", TreeNode == null ? 0 : TreeNode.DocumentID);
        query.Parameters = parameters;
        var result = query.Result;
        metadataUniGrid.DataSource = result;
    }
}