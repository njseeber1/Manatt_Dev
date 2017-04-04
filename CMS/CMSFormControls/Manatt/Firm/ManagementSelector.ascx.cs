using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.Base;
using CMS.DataEngine;
using CMS.ExtendedControls;
using CMS.FormEngine;
using CMS.Helpers;
using CMS.Membership;
using CMS.SiteProvider;
using CMS.UIControls;
using CMS.FormControls;
using CMS.CustomTables;

public partial class CMSFormControls_Manatt_Firm_ManagementSelector : FormEngineUserControl
{
    /// <summary>
    /// Gets or sets the value entered into the field, a hexadecimal color code in this case.
    /// </summary>
    public override object Value
    {
        get
        {
            return "";
        }
        set
        {
            // Selects the matching value in the drop-down
            //EnsureItems();
            //drpColor.SelectedValue = System.Convert.ToString(value);
        }
    }

    /// <summary>
    /// Property used to access the Width parameter of the form control.
    /// </summary>
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

    /// <summary>
    /// Returns an array of values of any other fields returned by the control.
    /// </summary>
    /// <returns>It returns an array where the first dimension is the attribute name and the second is its value.</returns>
    public override object[,] GetOtherValues()
    {
        object[,] array = new object[1, 2];
        array[0, 0] = "ProductColor";
        array[0, 1] = "";// drpColor.SelectedItem.Text;
        return array;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        CSSHelper.RegisterBootstrap(Page);
        ScriptHelper.RegisterBootstrapScripts(Page);

        ScriptHelper.RegisterClientScriptBlock(this, typeof(string), "RefreshUpdatePanel_" + ClientID, ScriptHelper.GetScript(
                       "function RefreshUpdatePanel_" + ClientID + "(){ " + Page.ClientScript.GetPostBackEventReference(pnlUpdate, "insert") + "; } \n"));

        mgmtGrid.DataSource = GetManagementPeople().Result;

        SetupMultiple();
    }

    private void MgmtGrid_OnAction(string actionName, object actionArgument)
    {
        switch (actionName.ToLower())
        {
            case "delete":

                var peopleId = ValidationHelper.GetInteger(actionArgument, 0);

                // Repopulate the UniGrid with the new data             
                mgmtGrid.DataSource = GetManagementPeople().Result;
                break;
        }
    }

    private DataQuery GetManagementPeople()
    {
        return new DataQuery("Manatt.Management.QueryAll");
    }

    private void SetupMultiple()
    {
        var selScript = GetSelectionDialogScript();

        btnAddItems.ResourceString = "general.additems";
        btnAddItems.OnClientClick = selScript;

        // Remove buttons
        string confirmation = GetString("general.confirmremove");
        btnRemove.Actions.Clear();
        btnRemove.Actions.Add(new CMSButtonAction
        {
            Text = GetString("general.removeselected"),
            OnClientClick = "if (confirm(" + ScriptHelper.GetString(confirmation) + ")) { " + ControlsHelper.GetPostBackEventReference(btnRemoveSelected) + " } return false;",
        });
        //btnRemove.Actions.Add(new CMSButtonAction
        //{
        //    Text = GetString("general.removeall"),
        //    OnClientClick = "US_ContextRemoveAll(" + ScriptHelper.GetString(this.ClientID) + "); return false;"
        //});

        //const string removeScript = @"function US_ContextRemoveAll(clientId) {
        //                                     setTimeout('US_RemoveAll_' + clientId + '();');
        //                                  }";

        //ScriptHelper.RegisterClientScriptBlock(this, typeof(string), "US_CM_RemoveAll", ScriptHelper.GetScript(removeScript));
    }


    /// <summary>
    /// Gets the script to display the selection dialog
    /// </summary>
    public string GetSelectionDialogScript()
    {
        //        var script = String.Format("US_SelectionDialog_{0}(); return false;", this.ClientID);
        return string.Format("modalDialog('/CMSFormControls/Manatt/Firm/PeopleSelectionDialog.aspx?externalControlID={0}', 'PeopleSelectionDialog', '900', '600'); return false;", ClientID);
    }


    protected void btnRemoveSelected_Click(object sender, EventArgs e)
    {
        foreach (var itemId in mgmtGrid.SelectedItems)
        {
            var existing = CustomTableItemProvider.GetItem(int.Parse(itemId), "Manatt.Management");
            existing.Delete();
        }
        mgmtGrid.ReloadData();
        
    }



    /// <summary>
    /// Removes all selected items.
    /// </summary>
    private void RemoveAll()
    {
        // Unselect selected items
        if (!String.IsNullOrEmpty(hiddenField.Value))
        {
            hiddenField.Value = String.Empty;

            //Reload(true);

            //RaiseSelectionChanged();
        }
    }

}