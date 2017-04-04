using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using CMS.Scheduler;
using CMS.EventLog;
using CMS;
using System.Timers;
using System.Web.Configuration;
using System.IO;


[assembly: RegisterCustomClass("ExperienceImport.ExperienceLoaderTask", typeof(ExperienceImport.ExperienceLoaderTask))]
namespace ExperienceImport
{
    /// <summary>
    /// Schedule Task to Import Experience Data
    /// </summary>
    public class ExperienceLoaderTask : ITask
    {
        private static Timer _timer;
        private static List<string> _logEntries;
        private static string _dateStr;
        private static string _nowDir;

        public string Execute(TaskInfo task)
        {
            string response = string.Empty;

            _logEntries = new List<string>();
            _timer = new Timer();
            _timer.Start();
            _logEntries.Add(string.Format("{0} - Starting Experience Import Process.", DateTime.Now.ToString()));
            EventLogProvider.LogInformation("Manatt.ExperienceLoader", "Log", string.Format("{0} - Starting Experience Import Process.", DateTime.Now.ToString()));
            _dateStr = DateTime.Now.ToString("MM_dd_yy");
            _nowDir = string.Format("{0}\\ManattXML_{1}", WebConfigurationManager.AppSettings["manatt.exp.localZipLocation"], _dateStr);

            if (VerifyFilesExists())
            {
                if (DeleteExperienceData())
                {
                    if (LoadDataFromFiles())
                    {
                        UpdateAttorneysFullNames();
                        RebuildExperienceIndex();
                        CopyImages();
                    }
                }
                LogResults();
            }
            else
            {
                response = "failed";
                throw new Exception("Zip file doesn't exist.");
                EventLogProvider.LogInformation("Manatt.ExperienceLoader", "ERROR", "Zip file doesn't exist.");
            }            
            EventLogProvider.LogInformation("Manatt.ExperienceLoader", "Log", string.Format("{0} - Experience Import Process Finished.", DateTime.Now.ToString()));
            response = "success";
            return response;
        }

        private static bool VerifyFilesExists()
        {
            try
            {
                DirectoryInfo dir = new DirectoryInfo(WebConfigurationManager.AppSettings["manatt.exp.localZipLocation"]);
                FileInfo[] zip = dir.GetFiles("ManattXML.zip", SearchOption.TopDirectoryOnly);
                string newZipPath = string.Format("{0}\\ManattXML.zip", _nowDir);

                // DIRECTORY
                if (Directory.Exists(_nowDir))
                    Directory.Delete(_nowDir, true);

                Directory.CreateDirectory(_nowDir);

                // MOVE ZIP
                if (zip.Length == 0)
                    throw new Exception("ManattXML.zip not found");
                else
                    File.Copy(zip[0].FullName, newZipPath);

                // UNZIP FILES
                System.IO.Compression.ZipFile.ExtractToDirectory(newZipPath, _nowDir);
                

                // FILES
                DirectoryInfo newDir = new DirectoryInfo(_nowDir);
                FileInfo[] xmlFiles = newDir.GetFiles("*.xml");
                foreach (string file in WebConfigurationManager.AppSettings["manatt.exp.fileNames"].Split(','))
                {
                    FileInfo xmlFile = xmlFiles.Where(x => x.Name == string.Format("{0}.xml", file)).FirstOrDefault();
                    if (xmlFile == null)
                        throw new Exception(string.Format("{0} was not found", file));
                }

                return true;
            }
            catch (Exception ex)
            {
                _logEntries.Add(string.Format("{0} - Error: {1}", DateTime.Now.ToString(), ex.Message));
                return false;
            }
        }

        private static void LogResults()
        {
            _logEntries.Add(string.Format("{0} - Experience Import Process Finished.", DateTime.Now.ToString()));
            System.IO.File.WriteAllLines(WebConfigurationManager.AppSettings["manatt.exp.logFolder"] + string.Format(@"\ExperienceLog_{0}.txt", DateTime.Now.ToString("yyyyMMdd_HHmm")), _logEntries);
        }

        private static bool LoadDataFromFiles()
        {
            ExperienceMethods api = new ExperienceMethods();
            bool response = false;
            try
            {
                _logEntries.Add(string.Format("{0} - Starting LoadDataFromFiles Process.", DateTime.Now.ToString()));
                DirectoryInfo dir = new DirectoryInfo(_nowDir);
                FileInfo[] files = dir.GetFiles("*.xml");

                FileInfo experience = files.Where(x => x.Name == "ExperiencesXML.xml").FirstOrDefault();
                List<FileInfo> nonExperience = files.Where(x => x.Name != "ExperiencesXML.xml").ToList();

                // ADDING NON EXPERIENCE DATA
                _logEntries.Add(string.Format("{0} - Starting Non-Exp Data.", DateTime.Now.ToString()));
                foreach (FileInfo file in nonExperience)
                {
                    using (StreamReader sr = new StreamReader(file.FullName))
                    {
                        // Read the stream to a string, and write the string to the console.
                        string content = sr.ReadToEnd();
                        //string result = Utils.Post(Config.AddExperienceURI, content, "text/xml");
                        string reuslt = api.AddExperienceData(content);
                        //     _logEntries.Add(string.Format("Starting Non-Exp Data: {0}", _timer.ToString()));
                    }
                }
                _logEntries.Add(string.Format("{0} - Finishing Non-Exp Data.", DateTime.Now.ToString()));

                // ADD EXPERIENCE LAST
                _logEntries.Add(string.Format("{0} - Starting Add Experience Last.", DateTime.Now.ToString()));
                using (StreamReader sr = new StreamReader(experience.FullName))
                {
                    string content = sr.ReadToEnd();
                    //string result = Utils.Post(Config.AddExperienceURI, content, "text/xml");
                    string reuslt = api.AddExperienceData(content);
                    //     _logEntries.Add(string.Format("Starting Non-Exp Data: {0}", _timer.ToString()));
                }
                _logEntries.Add(string.Format("{0} - Finishing Add Experience Last.", DateTime.Now.ToString()));
                _logEntries.Add(string.Format("{0} - LoadDataFromFiles Process Finished.", DateTime.Now.ToString()));
                response = true;
            }
            catch (Exception ex)
            {
                _logEntries.Add(string.Format("{0} - Error: {1}", DateTime.Now.ToString(), ex.Message));
                response = false;
            }
            return response;
        }

        private static bool DeleteExperienceData()
        {
            ExperienceMethods api = new ExperienceMethods();
            bool result = false;
            try
            {
                _logEntries.Add(string.Format("{0} - Starting DeleteExperienceData Process.", DateTime.Now.ToString()));
                //string resultAppi = Utils.Get(Config.DeleteExperienceURI);
                string resultApi = api.DeleteAllExperienceData();
                _logEntries.Add(string.Format("{0} :", DateTime.Now.ToString()));
                _logEntries.Add(string.Format("{0}", resultApi));
                _logEntries.Add(string.Format("{0} - DeleteExperienceDate Process Finished", DateTime.Now.ToString()));
                result = true;
            }
            catch (Exception ex)
            {
                result = false;
                _logEntries.Add(string.Format("{0} - DeleteExperienceData Error: {1}", DateTime.Now.ToString(), ex.Message));
            }
            return result;
        }

        private static void UpdateAttorneysFullNames()
        {
            ExperienceMethods api = new ExperienceMethods();
            _logEntries.Add(string.Format("{0} - Starting Updating Attorneys Full Names.", DateTime.Now.ToString()));
            api.UpdateAttorneysFullnames();
            _logEntries.Add(string.Format("{0} - Finishing Updating Attorneys Full Names.", DateTime.Now.ToString()));
        }

        private static bool RebuildExperienceIndex()
        {
            bool response = false;
            ExperienceMethods api = new ExperienceMethods();
            _logEntries.Add(string.Format("{0} - Starting RebuildExperienceIndex.", DateTime.Now.ToString()));
            if (api.RebuildIndex())
            {
                response = true;
                _logEntries.Add(string.Format("{0} - Index Task Created.", DateTime.Now.ToString()));
            }
            else
            {
                _logEntries.Add(string.Format("{0} - Index Task Wasn't Created.", DateTime.Now.ToString()));
            }
            _logEntries.Add(string.Format("{0} - Finishing RebuildExperienceIndex.", DateTime.Now.ToString()));
            return response;
        }

        private static bool CopyImages()
        {
            _logEntries.Add(string.Format("{0} - Starting CopyImages.", DateTime.Now.ToString()));
            bool response = false;
            try
            {
                List<string> images = Directory.GetFiles(WebConfigurationManager.AppSettings["manatt.exp.localZipLocation"]).Where(f => !f.EndsWith(".zip", true, null)).ToList();
                //Copy picture files
                foreach (string image in images)
                {
                    //Remove path from the file name.
                    string imageName = image.Substring(WebConfigurationManager.AppSettings["manatt.exp.localZipLocation"].Length + 1);

                    // Will overwrite if the destination file already exists.
                    File.Copy(Path.Combine(WebConfigurationManager.AppSettings["manatt.exp.localZipLocation"], imageName), Path.Combine(WebConfigurationManager.AppSettings["manatt.exp.localExperienceMediaLocation"], imageName), true);
                }
                response = true;
                _logEntries.Add(string.Format("{0} - {1} Images copied.", DateTime.Now.ToString(), images.Count));
                _logEntries.Add(string.Format("{0} - Finishing CopyImages.", DateTime.Now.ToString()));
            }
            catch (Exception ex)
            {
                _logEntries.Add(string.Format("{0} - CopyImages - Error: {1}", DateTime.Now.ToString(), ex.Message));
            }
            return response;
        }
    }
}
