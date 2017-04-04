using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.ExtendedControls;
using CMS.Helpers;
using CMS.SiteProvider;
using CMS.Membership;
using CMS.DocumentEngine;
using CMS.UIControls;
using CMS.DataEngine;
using CMS.Relationships;

public partial class CMSFormControls_Manatt_HRContact_AddRelatedCareerTypeOffice : CMSUserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //// Register the dialog script
        //ScriptHelper.RegisterDialogScript(Page);

        //this.lblCareer.Text = "Select Career: ";

        //var careers = DocumentHelper.GetDocuments("CMS.Document").OnSite("Manatt").Path("/Corporate/Careers", PathTypeEnum.Children).Culture("en-us").CombineWithDefaultCulture(false).ToList();

        //ddlCareer.DataSource = careers.Select(d => new { d.DocumentID, d.DocumentName });
    }
}