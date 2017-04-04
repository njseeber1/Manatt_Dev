using System;
using System.Collections;

using CMS.Helpers;
using CMS.UIControls;
using CMS.ExtendedControls;
using CMS.DataEngine;
using CMS.DocumentEngine;
using System.Text.RegularExpressions;
using System.Text;
using CMS.CustomTables;

public partial class CMSFormControls_Manatt_Firm_PeopleSelectionDialog : CMSModalPage
{
    #region "Variables"

    private string externalControlID;

    #endregion    

    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterEscScript();
        ScriptHelper.RegisterWOpenerScript(Page);
        CurrentMaster.PanelContent.RemoveCssClass("dialog-content");
        externalControlID = QueryHelper.GetString("externalControlID", string.Empty);
        // Set the page title
        string titleText = "Select People";

        PageTitle.TitleText = titleText;
        Page.Title = titleText;
        Save += CMSFormControls_Manatt_Firm_PeopleSelectionDialog_Save;
        btnSearch.Click += BtnSearch_Click;


        uniGrid.DataSource = GetPeople(txtSearch.Text).Result;
        LoadControls();
    }

    private void BtnSearch_Click(object sender, EventArgs e)
    {
        uniGrid.DataSource = GetPeople(txtSearch.Text).Result;
        //uniGrid.ReloadData();
    }

    private void CMSFormControls_Manatt_Firm_PeopleSelectionDialog_Save(object sender, EventArgs e)
    {
        //int order = 0;
        foreach (var peopleId in uniGrid.SelectedItems)
        {
            foreach (System.Web.UI.WebControls.GridViewRow row in uniGrid.GridView.Rows)
            {
                var id = row.Cells[1].Text;
                var title = row.Cells[2].Text;
                var fullname = string.Format("{0} {1}", row.Cells[3].Text, row.Cells[5].Text);
                if (id == peopleId)
                {
                    CustomTableItem mgmt = CustomTableItem.New("Manatt.Management");
                    mgmt.ItemCreatedBy = this.CurrentUser.UserID;
                    mgmt.ItemCreatedWhen = DateTime.Now;
                    mgmt.ItemModifiedBy = this.CurrentUser.UserID;
                    mgmt.ItemModifiedWhen = DateTime.Now;
                    mgmt.ItemGUID = Guid.NewGuid();                    
                    mgmt.SetValue("PeopleID", int.Parse(peopleId));
                    mgmt.SetValue("Title", title);
                    mgmt.SetValue("FullName", fullname);
                    mgmt.Insert();
                }
            }
        }


        string script2 = "if (wopener.RefreshUpdatePanel_" + externalControlID + ") { wopener.RefreshUpdatePanel_" + externalControlID + "(); CloseDialog(); } ";
        ltlScript.Text = ScriptHelper.GetScript(script2);
    }

    private DataQuery GetPeople(string search)
    {
        var query = new DataQuery("Manatt.ManagementPageType.QueryPeople");

        if (!string.IsNullOrEmpty(search))
            query = query.WhereContains("FirstName", search).Or(x => x.WhereContains("LastName", search)).Or(x => x.WhereContains("PrimaryPracticeTitle", search)).Or(x => x.WhereContains("Email", search));

        return query;
    }

    protected void lnkSelectAll_Click(object sender, EventArgs e)
    {

    }

    protected void lnkDeselectAll_Click(object sender, EventArgs e)
    {

    }

    private void LoadControls()
    {

        lblSearch.ResourceString = "general.entersearch";
        btnSearch.ResourceString = "general.search";

        pnlSearch.Visible = true;

        if (!URLHelper.IsPostback())
        {
            ScriptHelper.RegisterStartupScript(this, typeof(string), "Focus", ScriptHelper.GetScript("try{document.getElementById('" + txtSearch.ClientID + "').focus();}catch(err){}"));
        }

        lnkSelectAll.Text = GetString("UniSelector.SelectAll");
        lnkDeselectAll.Text = GetString("UniSelector.DeselectAll");

    }
}