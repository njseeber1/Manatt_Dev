using System;
using CMS.Base;
using CMS.DataEngine;
using CMS.MediaLibrary;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using CMS.SiteProvider;
using CMS.IO;
using CMS.Helpers;

[MediaFileHandlerModuleLoader]
public partial class CMSModuleLoader
{

    #region "Macro methods loader attribute"

    /// <summary>
    /// Module registration
    /// </summary>
    private class MediaFileHandlerModuleLoader : CMSLoaderAttribute
    {
        #region Private Properties

        private static Guid ResizeKey
        {
            get
            {
                return Guid.Parse("40BB6661-CCE0-4E54-B863-6B295906D66E");
            }
        }

        private static float Small
        {
            get
            {
                return 0.4f;
            }
        }

        private static float Medium
        {
            get
            {
                return 0.6f;
            }
        }

        #endregion

        /// <summary>
        /// Initializes the module
        /// </summary>
        public override void Init()
        {
            //ObjectEvents.Insert.After += CopyResizeImage;
            MediaFileInfo.TYPEINFO.Events.Insert.After += CopyResizeImage;
        }

        private void CopyResizeImage(object sender, ObjectEventArgs e)
        {
            if (e.Object != null)
            {
                if (e.Object is MediaFileInfo)
                {
                    MediaFileInfo mediaFile = (MediaFileInfo)e.Object;

                    if (!mediaFile.FilePath.StartsWith("Images/People/"))
                        return;

                    if (!mediaFile.FileMimeType.Contains("image/"))
                        return;

                    if (mediaFile.FileName.Contains(ResizeKey.ToString()))
                        return;

                    MediaLibraryInfo libraryInfo = MediaLibraryInfoProvider.GetMediaLibraryInfo(mediaFile.FileLibraryID);
                    var siteName = SiteInfoProvider.GetSiteName(mediaFile.FileSiteID);
                    string origFileName = mediaFile.FileName;
                    CopyImage(mediaFile, string.IsNullOrEmpty(siteName) ? SiteContext.CurrentSiteName : siteName, origFileName, Small, "small");
                    CopyImage(mediaFile, string.IsNullOrEmpty(siteName) ? SiteContext.CurrentSiteName : siteName, origFileName, Medium, "medium");
                }
            }
        }

        private static void CopyImage(MediaFileInfo originalMediaFile, string siteName, string fileName, float size, string sizeDescription)
        {
            string newFileName = RenameFile(ResizeKey, sizeDescription);
            string path = Path.GetDirectoryName(DirectoryHelper.CombinePath(MediaLibraryInfoProvider.GetMediaLibraryFolderPath(originalMediaFile.FileLibraryID), originalMediaFile.FilePath));
            var newFilePath = DirectoryHelper.CombinePath(path, fileName + newFileName + originalMediaFile.FileExtension);
            var paths = originalMediaFile.FilePath.Split('.');

            var newFileInfo = NewMediaFile(originalMediaFile);
            newFileInfo.FileName = fileName + newFileName;
            newFileInfo.FileTitle = fileName + newFileName;
            newFileInfo.FilePath = paths[paths.Length - 2] + newFileName + "." + paths[paths.Length - 1];
            newFileInfo.FileImageWidth = (int)Math.Round(originalMediaFile.FileImageWidth * size, 2);
            newFileInfo.FileImageHeight = (int)Math.Round(originalMediaFile.FileImageHeight * size, 2);
            var newImageBytes = ResizeImage(originalMediaFile, size);
            newFileInfo.FileBinary = newImageBytes;
            newFileInfo.FileSize = newFileInfo.FileBinary.Length;

            File.WriteAllBytes(newFilePath, newImageBytes);

            if (File.Exists(newFilePath))
            {
                MediaFileInfoProvider.ImportMediaFileInfo(newFileInfo);
            }
        }

        public static byte[] ResizeImage(MediaFileInfo originalFile, float percent)
        {
            int newWidth;
            int newHeight;
            int originalWidth = originalFile.FileImageWidth;
            int originalHeight = originalFile.FileImageHeight;
            newWidth = (int)(originalWidth * percent);
            newHeight = (int)(originalHeight * percent);

            return ImageHelper.GetResizedImageData(originalFile.FileBinary, originalFile.FileExtension, newWidth, newHeight, 0);
        }

        public static string RenameFile(Guid key, string size)
        {
            return string.Format("_{0}_{1}", key.ToString(), size);
        }

        public static MediaFileInfo NewMediaFile(MediaFileInfo originalMediaFile)
        {
            MediaFileInfo newMediaFile = new MediaFileInfo();
            newMediaFile.FileDescription = string.Empty;
            newMediaFile.FileExtension = originalMediaFile.FileExtension;
            newMediaFile.FileMimeType = originalMediaFile.FileMimeType;
            newMediaFile.FileBinary = originalMediaFile.FileBinary;
            newMediaFile.FileGUID = Guid.NewGuid();
            newMediaFile.FileLibraryID = originalMediaFile.FileLibraryID;
            newMediaFile.FileSiteID = originalMediaFile.FileSiteID;
            newMediaFile.FileCreatedByUserID = originalMediaFile.FileCreatedByUserID;
            newMediaFile.FileCreatedWhen = originalMediaFile.FileCreatedWhen;
            newMediaFile.FileModifiedByUserID = originalMediaFile.FileModifiedByUserID;
            newMediaFile.FileModifiedWhen = originalMediaFile.FileModifiedWhen;
            return newMediaFile;
        }
    }

    #endregion
}