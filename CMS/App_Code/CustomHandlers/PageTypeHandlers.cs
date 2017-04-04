using System;
using System.Linq;
using System.Web;
using System.Data;
using CMS.Base;
using CMS.EventLog;
using CMS.DocumentEngine;
using CMS.Forums;
using CMS.DataEngine;
using CMS.Helpers;
using CMS.Core;
using CMS.SettingsProvider;
using CMS.GlobalHelper;
using System.Text;
using CMS.SiteProvider;
using CMS.MediaLibrary;
using CMS.IO;

/// <summary>
/// Sample event handler 
/// </summary>

[PageTypeHandlers]
public partial class CMSModuleLoader
{

    #region "Macro methods loader attribute"

    /// <summary>
    /// Attribute class that ensures the loading of custom handlers
    /// </summary>
    private class PageTypeHandlers : CMSLoaderAttribute
    {
        private object thisLock = new object();
        /// <summary>
        /// The system executes the Init method of the CMSModuleLoader attributes when the application starts
        /// </summary>
        public override void Init()
        {
            DocumentEvents.Insert.Before += Insert_Before;
            //   DocumentEvents.Move.After += Move_After;
            DocumentEvents.Update.Before += Update_Before;
            WorkflowEvents.SaveVersion.Before += SaveVersion_Before;

        }

        private void SaveVersion_Before(object sender, WorkflowEventArgs e)
        {
            if (e.Document.NodeClassName == "Manatt.People")
            {
                string fName = e.Document.GetStringValue("FirstName", "").Trim();
                string lName = e.Document.GetStringValue("LastName", "").Trim();
                string mName = e.Document.GetStringValue("MiddleName", "").Trim();
                string vcardfilePath = e.Document.GetStringValue("VcardFile", "").Trim();
                string FullName = fName + ((mName == "") ? "" : " " + mName) + " " + lName;
                //string FullNameSEO = FullName.Replace(".", "").Replace(" ", "-");
                string FullNameSEO = FullName.Replace(".", "").Replace(" ", "-").Replace("'", "");

                e.Document.DocumentName = FullName;
                e.Document.NodeAlias = FullNameSEO;
                e.Document.DocumentUrlPath = FullNameSEO;
                e.Document.NodeName = FullName;
                e.Document.SetValue("FullName", FullName);
                e.Document.SetValue("FullNameSEO", FullNameSEO);
                e.Document.SetValue("DocumentNamePath", "/" + FullName);
                e.Document.SetValue("NodeAliasPath", "/" + FullNameSEO);
                e.Document.SetValue("DocumentPageTitle", FullName);

                vcardfilePath = string.Format("~/Manatt/media/Media/Images/People/{0}_{1}.vcf", fName, lName);
                e.Document.SetValue("VcardFile", vcardfilePath + "?ext=.vcf");

                try
                {
                    string vcardFile = SaveVcard(BuildvCard(e.Document), HttpContext.Current.Server.MapPath(vcardfilePath), string.Format("{0} {1} Vcard", fName, lName));
                }
                catch (Exception)
                {
                }                                
            }

        }


        private string SaveVcard(string vcard, string path, string name)
        {
            string value = "";
            lock (thisLock)
            {
                using (var vCardFile = System.IO.File.OpenWrite(path))
                using (var swWriter = new System.IO.StreamWriter(vCardFile))
                {
                    swWriter.Write(vcard);
                }
            }            

            MediaLibraryInfo library = MediaLibraryInfoProvider.GetMediaLibraryInfo("Media", SiteContext.CurrentSiteName);

            if (library != null)
            {
                // Prepares a path to a local file                
                //string filePath = "~/Manatt/media/Media/Images/People";
                // Prepares a CMS.IO.FileInfo object representing the local file
                CMS.IO.FileInfo file = CMS.IO.FileInfo.New(path);

                if (file != null)
                {
                    //string fullPath = HttpContext.Current.Server.MapPath(filePath + "/" + file.Name);

                    MediaFileInfo mediaFile = MediaFileInfoProvider.GetMediaFileInfo(library.LibraryID, "Images/People/" + file.Name);

                    if (mediaFile == null)
                        // Creates a new media library file object
                        mediaFile = new MediaFileInfo(path, library.LibraryID);

                    // Sets the media library file properties                    
                    mediaFile.FileTitle = name;
                    mediaFile.FilePath = "Images/People/" + file.Name; // Sets the path within the media library's folder structure
                    mediaFile.FileExtension = file.Extension;
                    mediaFile.FileMimeType = MimeTypeHelper.GetMimetype(file.Extension);
                    mediaFile.FileSiteID = SiteContext.CurrentSiteID;
                    mediaFile.FileLibraryID = library.LibraryID;
                    mediaFile.FileSize = file.Length;
                    mediaFile.FileModifiedWhen = DateTime.UtcNow;
                    // Saves the media library file                                        
                    //MediaFileInfoProvider.SetMediaFileInfo(mediaFile, false);
                    MediaFileInfoProvider.ImportMediaFileInfo(mediaFile);
                    
                    value = string.Format("~/Manatt/media/Media/{0}?ext=.vcf", mediaFile.FilePath);
                }
            }            

            return value;
        }

        private void Update_Before(object sender, DocumentEventArgs e)
        {
            TreeNode node = e.Node as TreeNode;
            if (node.NodeClassName == "Manatt.People")
            {
                string fName = node.GetStringValue("FirstName", "").Trim();
                string lName = node.GetStringValue("LastName", "").Trim();
                string mName = node.GetStringValue("MiddleName", "").Trim();
                string vcardfilePath = node.GetStringValue("VcardFile", "").Trim();
                string FullName = fName + ((mName == "") ? "" : " " + mName) + " " + lName;
                //string FullNameSEO = FullName.Replace(".", "").Replace(" ", "-");
                string FullNameSEO = FullName.Replace(".", "").Replace(" ", "-").Replace("'", "");

                node.DocumentName = FullName;
                node.NodeAlias = FullNameSEO;
                node.DocumentUrlPath = FullNameSEO;
                node.NodeName = FullName;
                node.SetValue("FullName", FullName);
                node.SetValue("FullNameSEO", FullNameSEO);
                node.SetValue("DocumentNamePath", "/" + FullName);
                node.SetValue("NodeAliasPath", "/" + FullNameSEO);
                node.SetValue("DocumentPageTitle", FullName);

                //if (string.IsNullOrEmpty(vcardfilePath))
                vcardfilePath = string.Format("~/Manatt/media/Media/Images/People/{0}_{1}.vcf", fName, lName);
                node.SetValue("VcardFile", vcardfilePath + "?ext=.vcf");
                //var vcardfilePath2 = vcardfilePath.Substring(0, vcardfilePath.IndexOf('?'));
                string vcardFile = "";
                try
                {
                    vcardFile = SaveVcard(BuildvCard(node), HttpContext.Current.Server.MapPath(vcardfilePath), string.Format("{0} {1} Vcard", fName, lName));
                }
                catch
                {                                      
                }               
            }            
        }


        /// <summary>
        /// Sample before insert handler which uppercases the document name
        /// </summary>
        private void Insert_Before(object sender, DocumentEventArgs e)
        {
            TreeNode node = e.Node;
            e.TreeProvider.AutomaticallyUpdateDocumentAlias = true;
            if (node.NodeClassName == "Manatt.People")
            {
                string fName = node.GetStringValue("FirstName", "").Trim();
                string lName = node.GetStringValue("LastName", "").Trim();
                string mName = node.GetStringValue("MiddleName", "").Trim();
                string vcardfilePath = node.GetStringValue("VcardFile", "").Trim();
                string FullName = fName + ((mName == "") ? "" : " " + mName) + " " + lName;
                //string FullNameSEO = FullName.Replace(".", "").Replace(" ", "-");
                string FullNameSEO = FullName.Replace(".", "").Replace(" ", "-").Replace("'", "");

                node.DocumentName = FullName;
                node.NodeAlias = FullNameSEO;
                node.NodeName = FullName;
                node.DocumentUrlPath = FullNameSEO;
                node.SetValue("FullName", FullName);
                node.SetValue("FullNameSEO", FullNameSEO);
                node.SetValue("DocumentNamePath", "/" + FullName);
                node.SetValue("NodeAliasPath", "/" + FullNameSEO);
                node.SetValue("DocumentPageTitle", FullName);

                vcardfilePath = string.Format("~/Manatt/media/Media/Images/People/{0}_{1}.vcf", fName, lName);
                node.SetValue("VcardFile", vcardfilePath + "?ext=.vcf");
                string vcardFile = "";
                try
                {
                    vcardFile = SaveVcard(BuildvCard(node), HttpContext.Current.Server.MapPath(vcardfilePath), string.Format("{0} {1} Vcard", fName, lName));
                }
                catch
                {
                }                
            }
        }


        private string BuildvCard(TreeNode node)
        {
            int officeId = node.GetIntegerValue("Office1", 0);
            int peopleId = node.GetIntegerValue("PeopleId", 0);
            DataRow drOffice = GetOfficeById(officeId);
            string role = GetRole(peopleId);
            string address = drOffice != null && drOffice["Address1"] != null ? drOffice["Address1"].ToString() + (drOffice["Address2"] != null ? ", " + drOffice["Address2"].ToString() : "") : "";
            string country = drOffice != null && drOffice["Country"] != null ? drOffice["Country"].ToString() : "";
            string state = drOffice != null && drOffice["State"] != null ? drOffice["State"].ToString() : "";
            string zip = drOffice != null && drOffice["Zip"] != null ? drOffice["Zip"].ToString() : "";
            string city = drOffice != null && drOffice["City"] != null ? drOffice["City"].ToString() : "";
            string firstname = node.GetStringValue("FirstName", "").Trim(),
                lastname = node.GetStringValue("LastName", "").Trim(),
                middlename = node.GetStringValue("MiddleName", "").Trim(),
                company = "Manatt, Phelps & Phillips, LLP",
                jobTitle = node.GetStringValue("PrimaryPracticeTitle", "").Trim(),
                officePhone = node.GetStringValue("Office1Phone", "").Trim(),
                faxPhone = node.GetStringValue("Office2Phone", "").Trim(),
                email = node.GetStringValue("Email", "").Trim(),
                photopath = node.GetStringValue("PhotoPath", "");

            string fullName = firstname + ((middlename == "") ? "" : " " + middlename) + " " + lastname;

            byte[] image = null;
            if (!string.IsNullOrEmpty(photopath))
            {
                photopath = photopath.Substring(0, photopath.IndexOf('?'));

                try
                {
                    image = System.IO.File.ReadAllBytes(HttpContext.Current.Server.MapPath(photopath));
                }
                catch
                {
                }
            }
            //http://www.dotnetspider.com/resources/44303-How-generate-vCard-dynamically-using-ASPNET.aspx
            var strvCardBuilder = new StringBuilder();
            strvCardBuilder.AppendLine("BEGIN:VCARD");
            strvCardBuilder.AppendLine("VERSION:2.1");
            strvCardBuilder.AppendLine("N:" + lastname + ";" + firstname);
            strvCardBuilder.AppendLine("FN:" + fullName);
            strvCardBuilder.AppendLine("ADR;WORK:;;" + address + ";" + city + ";" + state + ";" + zip + ";" + country);            
            strvCardBuilder.AppendLine("ORG:" + company);
            strvCardBuilder.AppendLine("ROLE:" + role);
            strvCardBuilder.AppendLine("TITLE:" + jobTitle);
            strvCardBuilder.AppendLine("TEL;WORK;VOICE:" + officePhone);
            strvCardBuilder.AppendLine("TEL;FAX;WORK:" + faxPhone);
            strvCardBuilder.AppendLine("URL;WORK:www.manatt.com");
            strvCardBuilder.AppendLine("EMAIL;PREF;INTERNET:" + email);

            if (image != null)
            {
                strvCardBuilder.AppendLine("PHOTO;ENCODING=BASE64;TYPE=JPEG:");
                strvCardBuilder.AppendLine(Convert.ToBase64String(image));
            }
            strvCardBuilder.AppendLine(string.Empty);
            strvCardBuilder.AppendLine(string.Empty);
            strvCardBuilder.AppendLine(string.Empty);
            strvCardBuilder.AppendLine("END:VCARD");
            return strvCardBuilder.ToString();
        }

        private string GetRole(int peopleId)
        {
            GeneralConnection cn = ConnectionHelper.GetConnection();
            QueryDataParameters parameters = new QueryDataParameters();
            parameters.Add("@documentId", peopleId);
            var query = new QueryParameters("SELECT B.DocumentName as Practice, C.DocumentName as Role  " +
                                            "FROM Manatt_PeoplePrimaryPracticeRelationship A " +
                                            "LEFT JOIN View_Cms_Tree_Joined B ON A.PracticeId = B.DocumentID AND B.Classname = 'Manatt.Practice' AND B.nodelinkednodeid is null " +
                                            "LEFT JOIN View_Cms_Tree_Joined C ON A.RoleId = C.DocumentID AND C.Classname = 'Manatt.Role' " +
                                            "WHERE A.PeopleId = @documentId", parameters, QueryTypeEnum.SQLQuery);
            var ds = cn.ExecuteQuery(query);
            string result = "";
            foreach (DataTable tbl in ds.Tables)
                foreach (DataRow dr in tbl.Rows)
                {
                    if (dr["Role"] != null)
                        result += dr["Role"].ToString() + ", ";
                    if (dr["Practice"] != null)
                        result += dr["Practice"].ToString();
                }

            return result;
        }

        private DataRow GetOfficeById(int officeId)
        {
            GeneralConnection cn = ConnectionHelper.GetConnection();
            QueryDataParameters parameters = new QueryDataParameters();
            parameters.Add("@documentId", officeId);
            var query = new QueryParameters("Select A.Phone,A.Country,A.State,A.ZIP,A.City,A.Address1,A.Address2,A.CompanyName,A.Title from Manatt_Offices A " +
                                            "INNER JOIN View_Cms_Tree_Joined B ON A.OfficesID = B.DocumentForeignKeyValue " +
                                            "WHERE B.ClassName = 'Manatt.Offices' " +
                                            "AND B.DocumentID = @documentId", parameters, QueryTypeEnum.SQLQuery);
            var ds = cn.ExecuteQuery(query);
            DataRow result = null;
            foreach (DataTable tbl in ds.Tables)
                foreach (DataRow dr in tbl.Rows)
                    result = dr;

            return result;
        }
    }

    #endregion
}