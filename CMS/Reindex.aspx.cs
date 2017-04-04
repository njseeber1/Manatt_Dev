using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reindex : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {

            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(CMS.DataEngine.ConnectionHelper.GetSqlConnectionString()))
            {
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(
                    "Update Manatt_DocumentArticle Set Practices = 'p' + REPLACE(RelatedPractices, '~', 'p') + 'p';" +
                    "Update Manatt_Insights Set Practices = 'p' + REPLACE(RelatedPractices, '~', 'p') + 'p';" +
                    "Update Manatt_DocumentNews Set Practices = dbo.fn_Manatt_GetPracticesByNewsId(DocumentNewsID);" +
                    "Update Manatt_DocumentEvent Set Practices = dbo.fn_Manatt_GetPracticesByEventID(DocumentEventId);" +
                    "Update Manatt_DocumentNewsletter Set Practices = dbo.fn_Manatt_GetPracticesByNewsletterId(DocumentNewsletterID);" +
                    "Update Manatt_People Set LastNameIndex = LEFT(LastName, 1), Practices = dbo.fn_Manatt_GetPracticesByPeopleId(peopleID);" +
                    "UPDATE Manatt_Practice SET TitleSort = Title;" +
                    "Update Manatt_CareerOpportunities Set Offices = dbo.fn_Manatt_GetOfficesByCareerOpportunityId(CareerOpportunitiesId)"
                    , con))
                {
                    con.Open();
                    var result = cmd.ExecuteScalar();
                }
            }

            var indexes = CMS.Search.SearchIndexInfoProvider.GetSearchIndexes();
            foreach (var index in indexes)
            {
                CMS.Search.SearchTaskInfoProvider.CreateTask(CMS.Search.SearchTaskTypeEnum.Rebuild, null, null, index.IndexName, index.IndexID);
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
}