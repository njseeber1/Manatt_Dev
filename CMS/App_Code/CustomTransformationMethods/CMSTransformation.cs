using CMS.Helpers;
using CMS.MediaLibrary;
using CMS.SiteProvider;
using System;

namespace CMS.Controls
{
    /// <summary>
    /// Extends the CMSTransformation partial class.
    /// </summary>
    public partial class CMSTransformation
    {
        /// <summary>
        /// Gets the value of media file title field in "Manatt Media" library.
        /// </summary>
        /// <param name="fileUrl"></param>
        /// <returns></returns>
        public string GetManattMediaTitle(string fileUrl)
        {
            string alt = string.Empty;
            if (!string.IsNullOrWhiteSpace(fileUrl))
            {
                string url = ValidationHelper.GetString(fileUrl, "");
                url = CleanUrl(url);
                string id = CleanId(url);
                alt = CacheHelper.Cache(cs => LoadMedia(cs, url), new CacheSettings(360, "manatt.imagetitle|" + id));
            }
            else
                throw new System.ArgumentNullException();

            return alt;
        }

        private static string CleanId(string fileUrl)
        {
            return fileUrl.Replace("/", "_").Replace(" ", "_").Replace("%20", "_");
        }

        private static string LoadMedia(CacheSettings cs, string fileUrl)
        {
            string result = string.Empty;
            MediaLibraryInfo library = MediaLibraryInfoProvider.GetMediaLibraryInfo("Media", SiteContext.CurrentSiteName);
            MediaFileInfo imageFile = MediaFileInfoProvider.GetMediaFileInfo(library.LibraryID, fileUrl);
            if (imageFile != null)
            {
                result = imageFile.FileTitle ?? imageFile.FileDescription;
            }
            return result;
        }

        private static string CleanUrl(string fileUrl)
        {
            string result = string.Empty;
            if (fileUrl.Contains("?"))
                result = fileUrl.Split('?')[0];
            else
                result = fileUrl;

            return result.Replace("~/Manatt/media/Media/", "")
                .Replace("/Manatt/media/Media/", "");
        }
    }
}