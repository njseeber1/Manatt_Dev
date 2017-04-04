using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using CMS.Base;
using System.Text;
using CMS.DocumentEngine;
using CMS.DataEngine;
using CMS.Membership;
using CMS.SiteProvider;
using CMS.MediaLibrary;
using CMS.EventLog;
using System.Xml;
using CMS.Search;
using System.Data;
using System.Web.Configuration;

/// <summary>
/// Summary description for ExperienceMethods
/// </summary>
public class ExperienceMethods
{
    #region Public Methods
    public string DeleteAllExperienceData()
    {
        using (var ctx = new CMSActionContext() { LogWebFarmTasks = false })
        {
            ctx.CreateSearchTask = false;
            ctx.LogSynchronization = false;

            StringBuilder result = new StringBuilder();
            int deletedRecords = 0;
            try
            {
                // Creates an instance of the Tree provider
                TreeProvider tree = new TreeProvider(MembershipContext.AuthenticatedUser);
                // Gets the culture version of the page that will be deleted
                InfoDataSet<TreeNode> pages = tree.SelectNodes(SiteContext.CurrentSiteName, "/Corporate/Experience/%", "en-us", false);

                var children = pages.Where(x => x.ClassName != "CMS.Folder" && x.ClassName != "Manatt.Experience" && x.ClassName != "Manatt.ExperienceProfile").OrderBy(x => x.ClassName);
                var experiences = pages.Where(x => x.ClassName == "Manatt.Experience").OrderBy(x => x.ClassName);

                //DELTE EXPERIENCE CHILDREN
                foreach (var child in children)
                {
                    deletedRecords++;
                    result.AppendLine(string.Format("{0} has been deleted", child.DocumentNamePath));
                    child.Delete();
                }

                // DELETE EXPERIENCE
                foreach (var exp in experiences)
                {
                    deletedRecords++;
                    result.AppendLine(string.Format("{0} has been deleted", exp.DocumentNamePath));
                    exp.Delete();
                }

                // DELETE ALL EXPERIENCE IMAGES
                MediaLibraryInfo library = MediaLibraryInfoProvider.GetMediaLibraryInfo("Media", SiteContext.CurrentSiteName);
                var mediaFiles = MediaFileInfoProvider.GetMediaFiles()
                                                 .WhereEquals("FileLibraryID", library.LibraryID)
                                                 .WhereContains("FilePath", "Images/Experience");
                //foreach (var media in mediaFiles)
                //{
                //    deletedRecords++;
                //    result.AppendLine(string.Format("{0} - {1}", media.FilePath, media.FileMimeType));
                //    media.Delete();
                //}

                //Config.LogEvent(EventType.INFORMATION, "DELETEEXPEERIENCE.IMAGE", string.Format("({0}) images found.", mediaFiles.Count));


                if (deletedRecords == 0)
                    result.AppendLine("No records where deleted");

                EventLogProvider.LogInformation("Manatt.ExperienceLoader", "DELETEEXPERIENCE", string.Format("{0} experience records have been deleted", deletedRecords));
            }
            catch (Exception ex)
            {
                result.AppendLine(string.Format("An error occurred: {0}", ex.Message));
                EventLogProvider.LogInformation("Manatt.ExperienceLoader", "DELETEEXPERIENCE", string.Format("An error occurred while trying to delete experience data: {0}", ex.Message));

            }

            return result.ToString();
        }
    }

    public string AddExperienceData(string xml)
    {
        using (var ctx = new CMSActionContext())
        {
            ctx.CreateSearchTask = false;
            ctx.LogSynchronization = false;

            string logInfo = string.Empty;
            string nodeNamePlural = string.Empty;
            string nodeNameSingular = string.Empty;
            TreeProvider tree = new TreeProvider(MembershipContext.AuthenticatedUser);
            // Create a new version manager instance
            //VersionManager versionmanager = VersionManager.GetInstance(tree);

            try
            {
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(xml);

                string rootElementXPath = @"/*";
                string childElementsXPath = string.Empty;
                string documentNameXPath = string.Empty;
                nodeNamePlural = doc.SelectSingleNode(rootElementXPath).Name;

                //  return nodeNamePlural + " was found to be loaded";

                // Experience Node is an exception
                if (nodeNamePlural == "Root")
                {
                    rootElementXPath = @"/*/*";
                    nodeNamePlural = doc.SelectSingleNode(rootElementXPath).Name;
                }

                nodeNameSingular = doc.SelectSingleNode(rootElementXPath + "/*[1]").Name;
                string className = string.Format("Manatt.Experience{0}", (nodeNamePlural == "Experiences") ? "" : nodeNameSingular);
                string cmsNodePath = string.Format("{1}{0}", (nodeNamePlural == "Experiences") ? "" : "/" + nodeNamePlural, WebConfigurationManager.AppSettings["kentico.manatt.experienceRoot"]);
                logInfo += " CLASS NAME : " + className + Environment.NewLine;
                logInfo += " NODE PATH : " + cmsNodePath + Environment.NewLine;

                tree.AutomaticallyUpdateDocumentAlias = true;
                // Gets the current site's root "/" page, which will serve as the parent page
                TreeNode parentNode = tree.SelectSingleNode(SiteContext.CurrentSiteName, cmsNodePath, "en-us");
                logInfo += " PARENT NODE : " + (parentNode != null).ToString() + Environment.NewLine;

                if (parentNode != null)
                {
                    childElementsXPath = string.Format("//{0}", nodeNameSingular);
                    XmlNodeList childNodes = doc.SelectNodes(childElementsXPath);

                    logInfo += string.Format("## ({1}) {0} records found and created {2}", nodeNameSingular, childNodes.Count.ToString(), Environment.NewLine);

                    foreach (XmlNode child in childNodes)
                    {
                        string elementGuid = "";
                        try
                        {
                            // Creates a new page of the "CMS.MenuItem" page type
                            TreeNode newPage = TreeNode.New(className, tree);
                            XmlNodeList propertyNodes = child.SelectNodes("*[. = text()]");

                            // SET the documentname with full descript value
                            string documentName = string.Empty;
                            string guidVal = elementGuid = child.SelectSingleNode("GUID").Value;
                            string documentPath = documentName.Replace(" ", "-")
                                .Replace(",", "")
                                .Replace("'", "")
                                .Replace(".", "");

                            if (nodeNameSingular == "Attorney")
                            {
                                string firstName = child.SelectSingleNode("FirstName/text()").Value;
                                string lastName = child.SelectSingleNode("LastName/text()").Value;
                                documentName = string.Format("{0} {1}", firstName, lastName);
                            }
                            else
                            {
                                documentNameXPath = (nodeNamePlural == "Experiences") ? "Headline/text()" : documentNameXPath = "Name/text()";
                                documentName = child.SelectSingleNode(documentNameXPath).Value;
                            }

                            if (string.IsNullOrEmpty(documentName))
                            {
                                EventLogProvider.LogInformation("Manatt.ExperienceLoader", string.Format("ADDEXPERIENCE.{0}", nodeNameSingular), string.Format("Document name is blank. {0} : {1}", elementGuid, logInfo));
                                continue;
                            }

                            // Sets the properties of the new page
                            newPage.DocumentName = documentName.Trim();
                            newPage.NodeAlias = documentPath.Trim();
                            newPage.DocumentCulture = "en-us";

                            // For child elements that are property values
                            foreach (XmlNode prop in propertyNodes)
                            {
                                string propName = prop.Name;
                                string propVal = prop.InnerText;

                                if (prop.Name == "GUID")
                                    propName = string.Format("{0}GUID", child.Name);

                                if (propName == "Profile")
                                    propVal = propVal.Replace(",", "~").Replace(" ", "");

                                if (propName == "HasExperience" || propName == "PriorFirmExperience" || propName == "TreatAsAnonymous")
                                    propVal = (propVal == "1") ? "true" : "false";

                                newPage.SetValue(propName.Trim(), propVal.Trim());
                            }

                            /// Load child elements of experience
                            if (nodeNameSingular == "Experience")
                            {
                                XmlNodeList childElements = child.SelectNodes("*[./*/*]");

                                foreach (XmlNode childElement in childElements)
                                {
                                    string ceName = childElement.Name;
                                    string val = ExperienceNodeToDelimitedGUID(childElement);
                                    newPage.SetValue(ceName.Trim(), val.Trim());
                                    logInfo += string.Format("\r\rname:{0}  -  value:{1}", ceName, val);
                                }
                            }
                            // Inserts the new page as a child of the parent page
                            newPage.Insert(parentNode);
                            //versionmanager.CheckIn(newPage, null, null);
                        }
                        catch (Exception ex)
                        {
                            EventLogProvider.LogInformation("Manatt.ExperienceLoader", string.Format("ADDEXPERIENCE.{0}", nodeNameSingular), string.Format("An error occurred while trying to add experience data with guid value {0}: {1}\r\n{2}", elementGuid, ex.Message, logInfo));
                        }
                    }
                }

                if (nodeNameSingular == "Industry")
                    SetExperienceIndustryHeirarchy(doc);

                // For experience, profile data has to be reset and documentids updated
                if (nodeNamePlural == "Experiences")
                {
                    UpdateProfiles();
                    ConnectionHelper.ExecuteQuery("Proc_Manatt_Experience_ParseChildGuidToDocumentID", null, QueryTypeEnum.StoredProcedure, false);
                    logInfo += UpdateGUIDs();
                }

                EventLogProvider.LogInformation("Manatt.ExperienceLoader", string.Format("ADDEXPERIENCE.{0}", nodeNameSingular), logInfo);
                return logInfo.ToString();
            }
            catch (Exception ex)
            {
                EventLogProvider.LogInformation("Manatt.ExperienceLoader", string.Format("ADDEXPERIENCE.{0}", nodeNameSingular), string.Format("An error occurred while trying to add experience data: {0}\r\n{1}", ex.Message, logInfo));
                return ex.Message;
            }
        }
    }

    public void UpdateAttorneysFullnames()
    {
        using (var scope = new CMSConnectionScope())
        {
            scope.Connection.CommandTimeout = ConnectionHelper.LongRunningCommandTimeout;
            ConnectionHelper.ExecuteQuery("Proc_Manatt_Experience_UpdateAttorneyFullNames", null, QueryTypeEnum.StoredProcedure, false);
        }
    }

    public bool RebuildIndex()
    {
        bool response = false;
        try
        {
            SearchIndexInfo index = SearchIndexInfoProvider.GetSearchIndexInfo(WebConfigurationManager.AppSettings["kentico.manatt.experienceIndex"]);
            if (index != null)
            {
                SearchTaskInfoProvider.CreateTask(SearchTaskTypeEnum.Rebuild, null, null, index.IndexName, index.IndexID);
                response = true;
            }
        }
        catch (Exception ex)
        {
            EventLogProvider.LogInformation("Manatt.ExperienceLoader", "REBUILDINDEX.EXPERIENCE", string.Format("An error occurred while trying to rebuild the Experience Index: {0}\r\n", ex.Message));
            response = false;
        }
        return response;
    }
    #endregion

    #region Private Methods
    private string ExperienceNodeToDelimitedGUID(XmlNode node)
    {
        XmlNodeList guidNodes = node.SelectNodes("*/GUID");
        List<string> guids = new List<string>();

        foreach (XmlNode guid in guidNodes)
            guids.Add(guid.InnerText);

        return string.Join("~", guids);
    }

    private string SetExperienceIndustryHeirarchy(XmlDocument doc)
    {
        string logInfo = string.Empty;
        try
        {
            TreeProvider tree = new TreeProvider(MembershipContext.AuthenticatedUser);

            XmlNodeList parentNodes = doc.SelectNodes("/Industries/Industry[Children]");
            logInfo += string.Format("({1}) Parent nodes found{0}.", Environment.NewLine, parentNodes.Count);

            if (parentNodes != null)
            {
                foreach (XmlNode parent in parentNodes)
                {
                    string parentGuid = parent.SelectSingleNode("GUID").InnerText;

                    logInfo += string.Format("({1}) Parent guid found{0}\r\n", Environment.NewLine, parentGuid);
                    TreeNode parentTree = GetIndustryNode(parentGuid, tree);

                    XmlNodeList childNodes = parent.SelectNodes("Children/Industry");
                    logInfo += string.Format("-- Parent \"{0}\" found, tree node found? {1}\r\n", parentTree.DocumentName, (parentTree != null));

                    if (childNodes != null)
                    {
                        foreach (XmlNode child in childNodes)
                        {
                            string childGuid = child.SelectSingleNode("GUID").InnerText;
                            TreeNode childTree = GetIndustryNode(childGuid, tree);
                            if (childTree == null)
                                continue;

                            logInfo += string.Format("= Child found {0} / GUID: {1}\r\n", childTree.DocumentName, childGuid);
                            childTree.NodeParentID = parentTree.NodeID;
                            childTree.SetValue("ParentIndustryGUID", parentGuid);
                            childTree.Update();

                        }
                    }
                }
            }

            EventLogProvider.LogInformation("Manatt.ExperienceLoader", "ADDEXPERIENCE.INDUSTRIES.ADJ", logInfo);
            return logInfo;
        }
        catch (Exception ex)
        {
            logInfo += string.Format("An error occurred while updating indsutry heirarchy: {0}\r\n{1}\r\n", ex.Message, logInfo);
            EventLogProvider.LogInformation("Manatt.ExperienceLoader", "ADDEXPERIENCE.INDUSTRIES.ADJ", logInfo);
            return logInfo;
        }
    }

    private TreeNode GetIndustryNode(string industryGuid, TreeProvider tree)
    {
        var industryPage = DocumentHelper.GetDocuments(SiteContext.CurrentSiteName,
             string.Format("{0}/Industries%", WebConfigurationManager.AppSettings["kentico.manatt.experienceRoot"]),
             "en-US",
             false,
             "Manatt.ExperienceIndustry",
             string.Format("IndustryGUID = '{0}'", industryGuid),
             "Name",
             2,
             true,
             tree).FirstOrDefault();

        EventLogProvider.LogInformation("Manatt.ExperienceLoader", "ADDEXPERIENCE.INDUSTRIES.ADJ", string.Format("Page null?{0}", (industryPage == null)));
        return industryPage;
    }

    private string UpdateProfiles()
    {
        try
        {
            TreeProvider tree = new TreeProvider(MembershipContext.AuthenticatedUser);
            //VersionManager versionmanager = VersionManager.GetInstance(tree);
            InfoDataSet<TreeNode> pages = tree.SelectNodes(SiteContext.CurrentSiteName, WebConfigurationManager.AppSettings["kentico.manatt.experienceRoot"] + "/Profiles/%", "en-us", false);
            DataSet ds = ConnectionHelper.ExecuteQuery("Proc_Manatt_ExperienceProfiles_Distinct", null, QueryTypeEnum.StoredProcedure);
            TreeNode parentNode = tree.SelectSingleNode(SiteContext.CurrentSiteName, WebConfigurationManager.AppSettings["kentico.manatt.experienceRoot"] + "/Profiles", "en-us");
            string logInfo = string.Empty;

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                string profileName = dr["ProfileName"].ToString().Trim();

                var profile = pages.Where(x => x.DocumentName == profileName).FirstOrDefault();
                if (profile == null)
                {
                    TreeNode newPage = TreeNode.New("Manatt.ExperienceProfile", tree);
                    newPage.DocumentName = profileName;
                    newPage.NodeAlias = profileName;
                    newPage.SetValue("ProfileName", profileName);
                    newPage.Insert(parentNode);
                    //versionmanager.CheckIn(newPage, null, null);
                    logInfo += profileName + " added \r\n";
                }
            }

            EventLogProvider.LogInformation("Manatt.ExperienceLoader", "ADDEXPERIENCE.PROFILES", logInfo);
            return logInfo;
        }
        catch (Exception ex)
        {
            EventLogProvider.LogInformation("Manatt.ExperienceLoader", "ADDEXPERIENCE.PROFILES", string.Format("An error occurred while updating profiles: {0}\r\n", ex.Message));
            return ex.Message;
        }
    }

    private string UpdateGUIDs()
    {
        try
        {
            DataSet ds = ConnectionHelper.ExecuteQuery("Proc_Manatt_ExperienceUpdateGUIDs", null, QueryTypeEnum.StoredProcedure, false);
            string retVal = string.Empty;

            if (ds.Tables[0].Rows.Count > 0)
            {
                retVal += string.Format("{0} duplicates were found when updating Manatt GUIDs \r\n", ds.Tables[0].Rows.Count);
                retVal += "#Matches \t Name \t Type \t GUID \r\n";
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    retVal += string.Format("{3} \t {1} \t {2} \t {3} \r\n", row["Matches"], row["Name"], row["TypeID"], row["ID"]);
                }
            }

            else
                retVal += "All matching GUIDs have been updated for Attorneys and Offices\r\n";

            return retVal;
        }
        catch (Exception ex)
        {
            return string.Format("AN error occurrred while updating the GUIDs: {0}", ex.Message);
        }
    }
    #endregion
}