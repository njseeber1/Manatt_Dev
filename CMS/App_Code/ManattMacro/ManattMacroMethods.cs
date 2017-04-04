using System.Web;
using CMS.MacroEngine;
using CMS;
using CMS.Helpers;
using CMS.MediaLibrary;
using CMS.SiteProvider;
using System;

[assembly: RegisterExtension(typeof(ManattMacroMethods), typeof(ManattMacroNamespace))]
/// <summary>
/// Summary description for ManattMacro
/// </summary>
public class ManattMacroMethods : MacroMethodContainer
{
    [MacroMethod(typeof(string), "Gets current request raw url.", 0)]
    public static object CurrentRawUrl(EvaluationContext context, params object[] parameters)
    {
        return HttpContext.Current.Request.RawUrl;
    }
    [MacroMethod(typeof(string), "Gets the media title field.", 1)]
    [MacroMethodParam(0, "fileUrl", typeof(string), "File url.")]
    public static object GetImageAlternateText(EvaluationContext context, params object[] parameters)
    {
        string alt = string.Empty;
        if (parameters.Length > 0)
        {
            string fileUrl = ValidationHelper.GetString(parameters[0], "");
            fileUrl = CleanUrl(fileUrl);
            string id = CleanId(fileUrl);
            alt = CacheHelper.Cache(cs => LoadMedia(cs, fileUrl), new CacheSettings(360, "manatt.imagetitle|" + id));
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
