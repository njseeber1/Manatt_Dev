using CMS;
using CMS.Base;
using CMS.DataEngine;
using CMS.EventLog;
using CMS.Helpers;
using CMS.IO;
using CMS.MacroEngine;
using CMS.OutputFilter;
using CMS.PortalEngine;
using CMS.SiteProvider;
using System;
using System.Collections.Generic;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Caching;

public class PMCResourceCombinerHandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        if (!PMCResourceCombinerHelper.Enabled)
        {
            SendNotFoundResponse();
            return;
        }

        string[] parts = RequestContext.URL.Segments.ToArray();

        if (parts.Length == 4) // root
            parts = parts.Skip(1).ToArray();
        else if (parts.Length == 5) // virtual directory
            parts = parts.Skip(2).ToArray();
        else
        {
            // unsupported
            SendNotFoundResponse();
            return;
        }
        parts = parts.Select(x => x.TrimEnd('/')).ToArray();
        if (parts.Length != 3)
        {
            SendNotFoundResponse();
            return;
        }

        PMCResourceCombinerGroupType type;
        if (!Enum.TryParse(parts[0], true, out type))
        {
            SendNotFoundResponse();
            return;
        }

        Guid guid = ValidationHelper.GetValue<Guid>(parts[1], Guid.Empty);
        if (guid == Guid.Empty)
        {
            SendNotFoundResponse();
            return;
        }

        string combinedGroupKey = PMCResourceCombinerHelper.GetCacheKey(type, guid, RequestContext.IsSSL, true);

        CMSOutputResource combinedResource = CacheHelper.Cache<CMSOutputResource>((CacheSettings cs) => LoadCombinedResource(type, guid, cs),
                                                                                    new CacheSettings(CacheHelper.PhysicalFilesCacheMinutes, combinedGroupKey));
        if (combinedResource != null)
        {
            SendResponse(context, combinedResource, CacheHelper.PhysicalFilesCacheMinutes);
            return;
        }
        SendNotFoundResponse();
    }

    private void SendResponse(HttpContext context, CMSOutputResource resource, int cacheMinutes)
    {
        context.Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
        if (IsResourceUnchanged(resource))
        {
            context.Response.ContentType = resource.ContentType;
            SendNotModifiedResponse(context, resource.LastModified, resource.Etag, cacheMinutes, true);
            return;
        }

        string text;
        byte[] array = GetOutputData(resource, out text);
        if (array == null)
        {
            RequestHelper.Respond404();
        }
        if (text != "identity")
        {
            context.Response.AppendHeader("Content-Encoding", text);
            context.Response.AppendHeader("Vary", "Accept-Encoding");
            RequestContext.ResponseIsCompressed = true;
        }

        context.Response.AppendHeader("Content-Length", array.Length.ToString());
        DateTime expires = DateTime.Now.AddMinutes((double)cacheMinutes);
        DateTime lastModified = resource.LastModified;
        if (lastModified >= DateTime.Now)
        {
            lastModified = DateTime.Now.AddSeconds(-1.0);
        }
        context.Response.Cache.SetLastModified(lastModified);
        context.Response.Cache.SetExpires(expires);
        context.Response.Cache.SetETag(resource.Etag);
        context.Response.Cache.SetCacheability(HttpCacheability.Public);
        context.Response.ContentType = resource.ContentType;
        if (!string.IsNullOrEmpty(resource.FileName) && !string.IsNullOrEmpty(resource.Extension))
        {
            HTTPHelper.SetFileDisposition(resource.FileName, resource.Extension);
        }
        if (array != null && array.Length > 0)
        {
            context.Response.OutputStream.Write(array, 0, array.Length);
        }
    }


    private CMSOutputResource LoadCombinedResource(PMCResourceCombinerGroupType type, Guid guid, CacheSettings cs)
    {
        string groupKey = PMCResourceCombinerHelper.GetCacheKey(type, guid, RequestContext.IsSSL);
        PMCResourceCombinerGroup group = new PMCResourceCombinerGroup();
        bool hasGroup = CacheHelper.TryGetItem<PMCResourceCombinerGroup>(groupKey, out group);
        if (!hasGroup || group == null || !group.Files.Any())
            return null;

        bool minificationEnabled = false;
        if (ConnectionHelper.ConnectionAvailable)
            minificationEnabled = ScriptHelper.ScriptMinificationEnabled;

        CMSOutputResource output = null;
        switch (type)
        {
            case PMCResourceCombinerGroupType.Axd:
                output = LoadCombinedAxdResource(group, minificationEnabled, cs);
                break;
            case PMCResourceCombinerGroupType.Css:
                output = LoadCombinedCssResource(group, minificationEnabled, cs);
                break;
            case PMCResourceCombinerGroupType.Js:
                output = LoadCombinedJsResource(group, minificationEnabled, cs);
                break;
        }

        return output;
    }

    private CMSOutputResource LoadCombinedAxdResource(PMCResourceCombinerGroup group, bool minify, CacheSettings cs)
    {
        List<CMSOutputResource> resources = new List<CMSOutputResource>();
        foreach (var file in group.Files)
        {
            CMSOutputResource resource = GetResource(file, ".axd", false, false);
            if (resource != null)
                resources.Add(resource);
        }

        CMSOutputResource output = CombineResources(resources, ".axd");
        MinifyResource(output, minify, true);

        if (output != null && cs.Cached)
        {
            output.CacheDependency = CacheHelper.GetCacheDependency(PMCResourceCombinerHelper.GetGroupDependencies(group));
            cs.CacheDependency = output.CacheDependency;
        }

        return output;
    }
    private CMSOutputResource LoadCombinedJsResource(PMCResourceCombinerGroup group, bool minify, CacheSettings cs)
    {
        IJavaScriptMinifier minifier = New.Instance<IJavaScriptMinifier>();

        List<string> fileDependencies = new List<string>();
        List<CMSOutputResource> resources = new List<CMSOutputResource>();
        foreach (var file in group.Files)
        {
            string actualFileUrl = URLHelper.GetQueryValue(file, "scriptfile");
            string actualPhysicalPath = URLHelper.GetPhysicalPath(URLHelper.GetVirtualPath(actualFileUrl));
            string resourceCacheKey = PMCResourceCombinerHelper.GetJsResourceCacheKey(actualPhysicalPath, RequestContext.IsSSL);
            CMSOutputResource resource = null;
            using (CachedSection<CMSOutputResource> cachedSection = new CachedSection<CMSOutputResource>(ref resource, cs.CacheMinutes, true, null, resourceCacheKey))
            {
                if (cachedSection.LoadData)
                {
                    resource = GetResource(actualFileUrl, ".js", false, true);
                    MinifyResource(resource, minify, true, minifier);
                    cachedSection.Data = resource;
                    if (cachedSection.Cached && resource.CacheDependency != null)
                        cachedSection.CacheDependency = resource.CacheDependency;
                }
            }

            if (resource != null)
            {
                resources.Add(resource);
                if (resource.CacheDependency != null)
                    fileDependencies.AddRange(resource.CacheDependency.FileNames);
                else
                    fileDependencies.Add(actualPhysicalPath); //add anyway
            }
        }

        CMSOutputResource output = CombineResources(resources, ".js");
        MinifyResource(output, minify, true, minifier);

        if (output != null && cs.Cached)
        {
            output.CacheDependency = CacheHelper.GetCacheDependency(fileDependencies, PMCResourceCombinerHelper.GetGroupDependencies(group));
            cs.CacheDependency = output.CacheDependency;
        }

        return output;
    }
    private CMSOutputResource LoadCombinedCssResource(PMCResourceCombinerGroup group, bool minify, CacheSettings cs)
    {
        ICssMinifier minifier = New.Instance<ICssMinifier>();
        List<string> combinedFileCacheDependencies = new List<string>();
        List<string> combinedCacheDependencies = new List<string>(PMCResourceCombinerHelper.GetGroupDependencies(group));

        List<CMSOutputResource> combinedOutput = new List<CMSOutputResource>();
        foreach (var resourceUrl in group.Files)
        {
            string resourceParams = URLHelper.GetQuery(resourceUrl).Substring(1);
            string combiner = URLHelper.GetQueryValue(resourceUrl, "combiner");
            string[] files = URLHelper.GetQueryValue(resourceUrl, "stylesheetfile").Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            if (files.Any())
            {

                string resourceCacheKey = PMCResourceCombinerHelper.GetCssResourceCacheKey(SiteContext.CurrentSiteName, RequestContext.CurrentDomain, resourceParams, RequestContext.IsSSL);
                CMSOutputResource cachedResource = null;
                using (CachedSection<CMSOutputResource> cachedSection =
                    new CachedSection<CMSOutputResource>(ref cachedResource, cs.CacheMinutes, true, null, resourceCacheKey))
                {
                    if (cachedSection.LoadData)
                    {
                        List<string> fileCacheDependencies = new List<string>();
                        List<CMSOutputResource> combinedResources = new List<CMSOutputResource>();
                        foreach (var fileUrl in files)
                        {
                            string filePhysicalPath = URLHelper.GetPhysicalPath(URLHelper.GetVirtualPath(fileUrl));

                            CMSOutputResource resourceFile = GetResource(fileUrl, ".css", true, false);
                            if (resourceFile != null)
                            {
                                combinedResources.Add(resourceFile);
                                fileCacheDependencies.Add(filePhysicalPath);
                            }
                        }

                        cachedResource = CombineResources(combinedResources, ".css");
                        MinifyResource(cachedResource, minify, true, minifier);

                        cachedSection.Data = cachedResource;
                        if (cachedSection.Cached)
                        {
                            cachedResource.CacheDependency = CacheHelper.GetCacheDependency(fileCacheDependencies, null);
                            cachedSection.CacheDependency = cachedResource.CacheDependency;
                        }
                    }
                }

                if (cachedResource != null)
                {
                    combinedOutput.Add(cachedResource);
                    if (cachedResource.CacheDependency != null && cachedResource.CacheDependency.FileNames != null)
                        combinedFileCacheDependencies.AddRange(cachedResource.CacheDependency.FileNames);
                }
            }

            List<CMSItem> styleSheetNames = GetStylesheetNames(resourceUrl);
            bool dynamic = ValidationHelper.GetBoolean(URLHelper.GetQueryValue(resourceUrl, "dynamic"), false);
            if (styleSheetNames != null && styleSheetNames.Any())
            {
                string resourceCacheKey = PMCResourceCombinerHelper.GetCssResourceCacheKey(SiteContext.CurrentSiteName, RequestContext.CurrentDomain, resourceParams, RequestContext.IsSSL);
                CMSOutputResource cachedResource = null;
                using (CachedSection<CMSOutputResource> cachedSection =
                    new CachedSection<CMSOutputResource>(ref cachedResource, cs.CacheMinutes, true, null, resourceCacheKey))
                {
                    if (cachedSection.LoadData)
                    {
                        List<string> cacheDependencies = new List<string>();
                        if (!combinedCacheDependencies.Contains("css"))
                            cacheDependencies.Add("css");

                        List<CMSOutputResource> combinedResources = new List<CMSOutputResource>();
                        foreach (var styleSheetItem in styleSheetNames)
                        {
                            CMSOutputResource resourceStylesheet = GetStylesheet(styleSheetItem, dynamic);
                            if (resourceStylesheet != null)
                            {
                                combinedResources.Add(resourceStylesheet);
                                string format = ValidationHelper.IsInteger(styleSheetItem) ? "cms.cssstylesheet|byid|{0}" : "cms.cssstylesheet|byname|{0}";
                                cacheDependencies.Add(string.Format(format, styleSheetItem.ToString().ToLowerCSafe()));
                            }
                        }

                        cachedResource = CombineResources(combinedResources, ".css");

                        if (CSSHelper.ResolveMacrosInCSS)
                        {
                            MacroSettings macroSettings = new MacroSettings
                            {
                                TrackCacheDependencies = true
                            };
                            if (cachedSection.Cached)
                            {
                                macroSettings.AddCacheDependencies(cacheDependencies);
                            }
                            cachedResource.Data = MacroResolver.Resolve(cachedResource.Data, macroSettings);
                            if (cachedSection.Cached)
                            {
                                cachedResource.CacheDependency = CacheHelper.GetCacheDependency(macroSettings.FileCacheDependencies, macroSettings.CacheDependencies);
                            }
                        }
                        else if (cachedSection.Cached)
                        {
                            cachedResource.CacheDependency = CacheHelper.GetCacheDependency(cacheDependencies);
                        }

                        cachedResource.Data = ResolveCSSClientUrls(cachedResource.Data, "~/CMSPages/GetResource.ashx");

                        MinifyResource(cachedResource, minify, true, minifier);

                        cachedSection.Data = cachedResource;
                        if (cachedSection.Cached && cachedResource.CacheDependency != null)
                            cachedSection.CacheDependency = cachedResource.CacheDependency;

                    }
                }

                if (cachedResource != null)
                {
                    combinedOutput.Add(cachedResource);
                    if (cachedResource.CacheDependency != null)
                    {
                        if (cachedResource.CacheDependency.FileNames != null)
                            combinedFileCacheDependencies.AddRange(cachedResource.CacheDependency.FileNames);
                        if (cachedResource.CacheDependency.CacheKeys != null)
                            combinedCacheDependencies.AddRange(cachedResource.CacheDependency.CacheKeys);
                    }
                }
            }

        }

        CMSOutputResource output = CombineResources(combinedOutput, ".css");

        MinifyResource(output, minify, true, minifier);

        if (output != null && cs.Cached)
        {
            output.CacheDependency = CacheHelper.GetCacheDependency(combinedFileCacheDependencies, combinedCacheDependencies);
            cs.CacheDependency = output.CacheDependency;
        }

        return output;
    }


    private CMSOutputResource CombineResources(IEnumerable<CMSOutputResource> resources, string extension)
    {
        StringBuilder combinedContent = new StringBuilder();
        StringBuilder etags = new StringBuilder();
        DateTime dateTime = DateTimeHelper.ZERO_TIME;
        List<string> list = new List<string>();
        bool isCss = (extension.ToLowerCSafe() == ".css");
        int num = 0;
        bool flag = false;
        string value = null;
        foreach (CMSOutputResource current in resources)
        {
            if (current != null)
            {
                flag = true;
                string text = current.Data;
                if (combinedContent.Length > 0 && !string.IsNullOrEmpty(text) && isCss)
                {
                    text = CSSHelper.TrimCharset(text);
                    if (string.IsNullOrEmpty(text))
                    {
                        continue;
                    }
                    combinedContent.AppendLine();
                    combinedContent.AppendLine();
                }
                combinedContent.Append(text);
                if (etags.Length > 0)
                {
                    etags.Append('|');
                }
                etags.Append(current.Etag.Trim(new char[] { '"' }));
                if (current.LastModified > dateTime)
                {
                    dateTime = current.LastModified;
                }
                list.AddRange(current.ComponentFiles);
                value = current.Name + extension;
                if (!string.IsNullOrEmpty(current.FileName))
                {
                    value = current.FileName;
                }
            }
            num++;
        }
        if (!flag)
        {
            return null;
        }
        CMSOutputResource cMSOutputResource = new CMSOutputResource
        {
            Data = combinedContent.ToString(),
            Etag = etags.ToString(),
            LastModified = dateTime,
            ComponentFiles = list,
            Extension = extension
        };
        cMSOutputResource.FileName = ((num == 1) ? ValidationHelper.GetSafeFileName(value, null) : ("combiner" + extension));
        cMSOutputResource.ContentType = MimeTypeHelper.GetMimetype(extension, "application/x-javascript");
        return cMSOutputResource;
    }

    private void MinifyResource(CMSOutputResource resource, bool minify, bool compress, IResourceMinifier minifier = null)
    {
        if (resource == null)
        {
            return;
        }
        if (minify && minifier != null)
        {
            resource.MinifiedData = minifier.Minify(resource.Data);
        }
        else if (minify)
        {
            resource.MinifiedData = StripWhitespace(resource.Data);
        }

        if (compress && ConnectionHelper.ConnectionAvailable)
        {
            compress &= RequestHelper.AllowResourceCompression;
        }
        if (compress)
        {
            resource.CompressedData = Compress(resource.Data);
        }
        if (minify && compress)
        {
            resource.MinifiedCompressedData = Compress(resource.MinifiedData);
        }
    }


    private byte[] Compress(string resource)
    {
        byte[] result;
        using (System.IO.MemoryStream memoryStream = new System.IO.MemoryStream())
        {
            using (DeflateStream deflateStream = new DeflateStream(memoryStream, CompressionMode.Compress))
            {
                using (System.IO.StreamWriter streamWriter = new System.IO.StreamWriter(deflateStream))
                {
                    streamWriter.Write(resource);
                }
            }
            result = memoryStream.ToArray();
        }
        return result;
    }

    private void SendNotFoundResponse()
    {
        RequestDebug.LogRequestOperation("404NotFound", RequestContext.URL.ToString(), 1);
        RequestHelper.Respond404();
    }
    private void SendNotModifiedResponse(HttpContext context, DateTime lastModified, string etag, int clientCacheMinutes, bool publicCache)
    {
        context.Response.StatusCode = 304;
        context.Response.Cache.SetETag(etag);
        context.Response.Cache.SetCacheability(publicCache ? HttpCacheability.Public : HttpCacheability.ServerAndPrivate);
        DateTime expires = DateTime.Now.AddMinutes((double)clientCacheMinutes);
        if (lastModified >= DateTime.Now)
        {
            lastModified = DateTime.Now.AddSeconds(-1.0);
        }
        context.Response.Cache.SetLastModified(lastModified);
        context.Response.Cache.SetExpires(expires);
        RequestDebug.LogRequestOperation("304NotModified", etag, 1);
        RequestHelper.EndResponse();
    }

    private CMSOutputResource GetResource(string url, string extension, bool resolveCSSUrls, bool resolveMacros)
    {
        string content = string.Empty;
        string fileName = string.Empty;
        string fileUrl = string.Empty;
        string virtualPath = URLHelper.GetVirtualPath(url);
        DateTime lastWriteTime = DateTime.UtcNow;
        string fileCacheDependency = string.Empty;
        switch (extension.ToLowerCSafe())
        {
            case ".css":
            case ".js":
                string physicalPath = URLHelper.GetPhysicalPath(virtualPath);
                if (!physicalPath.StartsWithCSafe(SystemContext.WebApplicationPhysicalPath, true))
                {
                    RequestHelper.Respond404();
                }

                content = ReadFile(physicalPath, extension);

                FileInfo fileInfo = FileInfo.New(physicalPath);
                if (fileInfo == null || string.IsNullOrEmpty(content))
                    return null;

                lastWriteTime = fileInfo.LastWriteTime;

                fileUrl = URLHelper.ResolveUrl(virtualPath, true, false);
                fileName = Path.GetFileName(physicalPath);
                if (resolveCSSUrls)
                    content = ResolveCSSClientUrls(content, virtualPath);
                fileCacheDependency = physicalPath;
                break;
            case ".axd":
                content = ReadWebResource(url);
                if (string.IsNullOrEmpty(content))
                    return null;
                fileUrl = URLHelper.ResolveUrl(url, true, false);
                fileName = url.GetHashCode().ToString();
                break;

        }

        CMSOutputResource cMSOutputResource = new CMSOutputResource
        {
            Data = content,
            BinaryData = null,
            Name = fileUrl,
            Etag = "file|" + lastWriteTime,
            LastModified = lastWriteTime,
            FileName = fileName,
            Extension = extension
        };
        switch (extension.ToLowerCSafe())
        {
            case ".css":
                cMSOutputResource.ContentType = "text/css";
                return cMSOutputResource;
            case ".js":
            case ".axd":
                cMSOutputResource.ContentType = "application/x-javascript";
                if (resolveMacros)
                {
                    cMSOutputResource.Data = MacroResolver.Resolve(cMSOutputResource.Data, null);
                    return cMSOutputResource;
                }
                return cMSOutputResource;
            default:
                break;
        }
        cMSOutputResource.ContentType = MimeTypeHelper.GetMimetype(extension, "application/octet-stream");
        if (!string.IsNullOrEmpty(fileCacheDependency))
            cMSOutputResource.CacheDependency = CacheHelper.GetFileCacheDependency(fileCacheDependency);
        return cMSOutputResource;
    }

    private string ResolveCSSClientUrls(string inputText, string baseUrl)
    {
        if (ValidationHelper.GetBoolean(SettingsHelper.AppSettings["CMSUseAbsoluteCSSClientURLs"], false, null))
        {
            baseUrl = URLHelper.GetAbsoluteUrl(baseUrl);
        }
        else
        {
            baseUrl = URLHelper.ResolveUrl(baseUrl, true, false);
        }
        return HTMLHelper.ResolveCSSClientUrls(inputText, baseUrl);
    }

    private string ReadFile(string path, string fileExtension)
    {
        if (!File.Exists(path) || Path.GetExtension(path) != fileExtension)
        {
            return null;
        }
        string result;
        try
        {
            result = File.ReadAllText(path);
        }
        catch
        {
            result = string.Empty;
        }
        return result;
    }

    private string ReadWebResource(string url)
    {
        string absoluteUrl = URLHelper.GetAbsoluteUrl(url);

        string content = null;
        try
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(new Uri(absoluteUrl, UriKind.Absolute));
            request.Method = "GET";
            request.AutomaticDecompression = DecompressionMethods.GZip;

            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            using (System.IO.StreamReader reader = new System.IO.StreamReader(response.GetResponseStream()))
            {
                content = reader.ReadToEnd();
            }
        }
        catch (System.Net.Sockets.SocketException)
        {
            // The remote site is currently down. Try again next time.
        }
        catch (UriFormatException)
        {
            // Only valid absolute URLs are accepted
        }

        return content;
    }

    private string StripWhitespace(string body)
    {
        string[] lines = body.Split(new string[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);
        StringBuilder emptyLines = new StringBuilder();
        foreach (string line in lines)
        {
            string s = line.Trim();
            if (s.Length > 0 && !s.StartsWith("//"))
                emptyLines.AppendLine(s.Trim());
        }

        body = emptyLines.ToString();

        // remove C styles comments
        body = Regex.Replace(body, "/\\*.*?\\*/", String.Empty, RegexOptions.Compiled | RegexOptions.Singleline);
        //// trim left
        body = Regex.Replace(body, "^\\s*", String.Empty, RegexOptions.Compiled | RegexOptions.Multiline);
        //// trim right
        body = Regex.Replace(body, "\\s*[\\r\\n]", "\r\n", RegexOptions.Compiled | RegexOptions.ECMAScript);
        // remove whitespace beside of left curly braced
        body = Regex.Replace(body, "\\s*{\\s*", "{", RegexOptions.Compiled | RegexOptions.ECMAScript);
        // remove whitespace beside of coma
        body = Regex.Replace(body, "\\s*,\\s*", ",", RegexOptions.Compiled | RegexOptions.ECMAScript);
        // remove whitespace beside of semicolon
        body = Regex.Replace(body, "\\s*;\\s*", ";", RegexOptions.Compiled | RegexOptions.ECMAScript);
        // remove newline after keywords
        body = Regex.Replace(body, "\\r\\n(?<=\\b(abstract|boolean|break|byte|case|catch|char|class|const|continue|default|delete|do|double|else|extends|false|final|finally|float|for|function|goto|if|implements|import|in|instanceof|int|interface|long|native|new|null|package|private|protected|public|return|short|static|super|switch|synchronized|this|throw|throws|transient|true|try|typeof|var|void|while|with)\\r\\n)", " ", RegexOptions.Compiled | RegexOptions.ECMAScript);

        return body;
    }

    private bool IsResourceUnchanged(CMSOutputResource resource)
    {
        string header = RequestHelper.GetHeader("If-None-Match", string.Empty);
        string header2 = RequestHelper.GetHeader("If-Modified-Since", string.Empty);
        DateTime dateTime;
        return header2 != string.Empty && header == resource.Etag && DateTime.TryParse(header2.Split(";".ToCharArray())[0], out dateTime) && resource.LastModified.ToUniversalTime() <= dateTime.ToUniversalTime().AddSeconds(1.0);
    }

    private byte[] GetOutputData(CMSOutputResource resource, out string contentCoding)
    {
        bool flag = resource.ContainsMinifiedData;
        bool flag2 = false;
        if (ConnectionHelper.ConnectionAvailable)
        {
            flag2 = RequestHelper.AllowResourceCompression;
        }
        bool flag3 = flag2 && RequestHelper.IsGZipSupported() && resource.ContainsCompressedData;
        contentCoding = "identity";
        if (!flag && !flag3)
        {
            return Encoding.UTF8.GetBytes(resource.Data);
        }
        if (flag && !flag3)
        {
            return Encoding.UTF8.GetBytes(resource.MinifiedData);
        }
        if (!flag)
        {
            contentCoding = "deflate";
            return resource.CompressedData;
        }
        contentCoding = "deflate";
        return resource.MinifiedCompressedData;
    }

    private List<CMSItem> GetStylesheetNames(string url)
    {
        string key = "stylesheetname";
        string @string = URLHelper.GetQueryValue(url, key);
        if (!string.IsNullOrEmpty(@string))
        {
            List<CMSItem> list = new List<CMSItem>();
            string[] array = @string.Split(new char[]
            {
            ';'
            }, StringSplitOptions.RemoveEmptyEntries);
            string[] array2 = array;
            for (int i = 0; i < array2.Length; i++)
            {
                string name = array2[i];
                list.Add(new CMSItem(name));
            }
            return list;
        }
        @string = URLHelper.GetQueryValue(url, "_" + key);
        if (!string.IsNullOrEmpty(@string))
        {
            List<CMSItem> list2 = new List<CMSItem>();
            string[] array3 = @string.Split(new char[]
            {
            ';'
            }, StringSplitOptions.RemoveEmptyEntries);
            string[] array4 = array3;
            for (int j = 0; j < array4.Length; j++)
            {
                string value = array4[j];
                int integer = ValidationHelper.GetInteger(value, 0, null);
                if (integer > 0)
                {
                    list2.Add(new CMSItem(integer));
                }
            }
            return list2;
        }
        return null;
    }

    private CMSOutputResource GetStylesheet(CMSItem item, bool dynamic)
    {
        CssStylesheetInfo cssStylesheetInfo;
        if (item.Name != null)
        {
            cssStylesheetInfo = CssStylesheetInfoProvider.GetCssStylesheetInfo(item.Name);
        }
        else
        {
            cssStylesheetInfo = CssStylesheetInfoProvider.GetCssStylesheetInfo(item.ID);
        }
        if (cssStylesheetInfo == null)
        {
            return null;
        }
        DateTime lastModified = cssStylesheetInfo.StylesheetLastModified;
        FileInfo fileInfo = cssStylesheetInfo.GetFileInfo("StylesheetText");
        if (fileInfo != null && fileInfo.Exists)
        {
            lastModified = fileInfo.LastWriteTime.ToUniversalTime();
        }
        string stylesheetName = cssStylesheetInfo.StylesheetName;
        string inputText = (!cssStylesheetInfo.IsPlainCss() && dynamic) ? cssStylesheetInfo.StylesheetDynamicCode : cssStylesheetInfo.StylesheetText;
        CMSOutputResource cMSOutputResource = new CMSOutputResource
        {
            Data = HTMLHelper.ResolveCSSUrls(inputText, SystemContext.ApplicationPath),
            Name = stylesheetName,
            LastModified = lastModified,
            Etag = "cssstylesheet|" + cssStylesheetInfo.StylesheetVersionGUID,
            FileName = stylesheetName + ".css",
            Extension = ".css"
        };
        if (fileInfo != null && fileInfo.Exists)
        {
            cMSOutputResource.ComponentFiles.Add(cssStylesheetInfo.Generalized.GetVirtualFileRelativePath("StylesheetText", null));
        }
        return cMSOutputResource;
    }

    public bool IsReusable
    {
        get { return false; }
    }

}
public static class PMCResourceCombinerHelper
{
    private const string COMBINER_BASECACHEKEY = "pmcresourcecombiner";
    private const string GETRESOURCE_BASECACHEKEY = "getresource";

    internal static string GetGroupDummyKey(PMCResourceCombinerGroup group)
    {
        return GetGroupDummyKey(group.Type, group.Name);
    }
    internal static string GetGroupDummyKey(PMCResourceCombinerGroupType groupType, string groupName)
    {
        return COMBINER_BASECACHEKEY + "|" + groupType.ToString().ToLowerCSafe() + "|byname|" + groupName.ToLowerCSafe();
    }
    internal static List<string> GetGroupDependencies(PMCResourceCombinerGroup group)
    {
        string baseKey = COMBINER_BASECACHEKEY + "|" + group.Type.ToString().ToLowerCSafe();
        List<string> dummies = new List<string>();
        dummies.Add(COMBINER_BASECACHEKEY + "|all");
        dummies.Add(baseKey + "|all");
        dummies.Add(baseKey + "|byname|" + group.Name.ToLowerCSafe());
        dummies.Add(baseKey + "|byguid|" + group.GUID.ToString().ToLowerCSafe());
        return dummies;
    }

    internal static string GetCacheKey(PMCResourceCombinerGroupType type, bool ssl, IEnumerable<int> fileHashes)
    {
        List<string> key = new List<string>();
        key.Add(COMBINER_BASECACHEKEY);
        key.Add(type.ToString().ToLowerCSafe());
        key.AddRange(fileHashes.Select(i => i.ToString()));
        key.Add(ssl.ToString().ToLowerCSafe());
        return string.Join("|", key);
    }
    internal static string GetCacheKey(PMCResourceCombinerGroupType type, Guid guid, bool ssl, bool output = false)
    {
        List<string> key = new List<string>();
        key.Add(COMBINER_BASECACHEKEY);
        key.Add(type.ToString().ToLowerCSafe());
        key.Add(guid.ToString());
        if (output)
            key.Add("output");
        key.Add(ssl.ToString().ToLowerCSafe());
        return string.Join("|", key);
    }
    internal static string GetAxdResourceCacheKey(Guid guid, int fileHash, bool ssl)
    {
        List<string> key = new List<string>();
        key.Add(COMBINER_BASECACHEKEY);
        key.Add(PMCResourceCombinerGroupType.Axd.ToString().ToLowerCSafe());
        key.Add(guid.ToString());
        key.Add(fileHash.ToString());
        key.Add(ssl.ToString().ToLowerCSafe());
        return string.Join("|", key);
    }
    internal static string GetJsResourceCacheKey(string physicalPath, bool ssl)
    {
        List<string> key = new List<string>();
        key.Add(GETRESOURCE_BASECACHEKEY);
        key.Add(physicalPath);
        key.Add(ssl.ToString().ToLowerCSafe());
        return string.Join("|", key);
    }
    internal static string GetCssResourceCacheKey(string siteName, string domain, string urlParameters, bool ssl)
    {
        List<string> key = new List<string>();
        key.Add(GETRESOURCE_BASECACHEKEY);
        key.Add(siteName);
        key.Add(domain);
        key.Add(urlParameters);
        key.Add(ssl.ToString().ToLowerCSafe());
        return string.Join("|", key);
    }
    private static bool IsAbsoluteUrl(string url)
    {
        Uri uri;
        return Uri.TryCreate(url, UriKind.Absolute, out uri);
    }
    public static string GetScriptUrl(string url, string combiner = "js")
    {
        if (IsAbsoluteUrl(url))
        {
            return url;
        }
        if (!url.StartsWithCSafe("/"))
        {
            url = URLHelper.ResolveUrl(url, true, false);
        }
        url = string.Format("/CMSPages/GetResource.ashx?scriptfile={0}&amp;combiner={1}", url, combiner);
        return url;
    }
    public static string GetScriptTag(string url, string combiner = "js")
    {
        if (string.IsNullOrEmpty(url))
        {
            return null;
        }
        url = GetScriptUrl(url, combiner);
        return string.Format("<script src=\"{0}\" type=\"text/javascript\"></script>", url);
    }

    public static string GetCssUrl(string url, string combiner = "css")
    {
        if (IsAbsoluteUrl(url))
        {
            return url;
        }
        if (!url.StartsWithCSafe("/"))
        {
            url = URLHelper.ResolveUrl(url, true, false);
        }
        url = string.Format("/CMSPages/GetResource.ashx?stylesheetfile={0}&amp;combiner={1}", url, combiner);
        return url;
    }

    public static bool Enabled
    {
        get
        {
            return ValidationHelper.GetBoolean(SettingsKeyInfoProvider.GetValue(SiteContext.CurrentSiteName + ".PMCResourceCombinerEnabled"), false);
        }
    }

    private static Regex _cssRegExp = null;
    private static Regex _axdRegExp = null;
    private static Regex _jsRegExp = null;
    /*
    * /<link\s*href=\"([^\"]*(?:\/CMSPages\/GetResource\.ashx\?stylesheetfile=[^\"&]+|\/CMSPages\/GetResource\.ashx\?stylesheetname=[^\"&]+)&amp;combiner=([^\"&]+)[^\"]*)\"\s*type=\"text\/css\"[^>]*>/ig
    */
    private static Regex CssRegExp
    {
        get
        {
            if (_cssRegExp == null)
                _cssRegExp = RegexHelper.GetRegex("<link\\s*href=\"([^\"]*(?:/CMSPages/GetResource\\.ashx\\?stylesheetfile=[^\"&]+|/CMSPages/GetResource\\.ashx\\?stylesheetname=[^\"&]+)&amp;combiner=([^\"&]+)[^\"]*)\"\\s*type=\"text/css\"\\s*rel=\"stylesheet\"[^>]*>", true);
            return _cssRegExp;
        }
    }
    /*
    * /<script\s*src=\"((?=[^\"]*(webresource.axd|scriptresource.axd))[^\"]*)\"\s*type=\"text\/javascript\"[^>]*>[^<]*(?:<\/script>)?/ig
    */
    private static Regex AxdRegExp
    {
        get
        {
            if (_axdRegExp == null)
                _axdRegExp = RegexHelper.GetRegex("<script\\s*src=\"((?=[^\"]*(webresource.axd|scriptresource.axd))[^\"]*)\"\\s*type=\"text/javascript\"[^>]*>[^<]*(?:</script>)?", true);
            return _axdRegExp;
        }
    }
    /*
    * /<script\s*src=\"([^\"]*(?:\/CMSPages\/GetResource\.ashx\?scriptfile=[^\"&]+)&amp;combiner=([^\"&]+)[^\"]*)\"\s*type=\"text\/javascript\"[^>]*>[^<]*(?:<\/script>)?/ig
    */
    private static Regex JsRegExp
    {
        get
        {
            if (_jsRegExp == null)
                _jsRegExp = RegexHelper.GetRegex("<script\\s*src=\"([^\"]*(?:/CMSPages/GetResource\\.ashx\\?scriptfile=[^\"&]+)&amp;combiner=([^\"&]+)[^\"]*)\"\\s*type=\"text/javascript\"[^>]*>[^<]*(?:</script>)?", true);
            return _jsRegExp;
        }
    }
    internal static Regex GetRegex(PMCResourceCombinerGroupType type)
    {
        switch (type)
        {
            case PMCResourceCombinerGroupType.Axd:
                return AxdRegExp;
            case PMCResourceCombinerGroupType.Css:
                return CssRegExp;
            case PMCResourceCombinerGroupType.Js:
                return JsRegExp;
        }
        throw new Exception("Type not enum!");
    }

}

[PMCResourceCombinerModuleLoader]
public partial class CMSModuleLoader
{
    public class PMCResourceCombinerModuleLoader : CMSLoaderAttribute
    {
        public override void Init()
        {
            RequestEvents.PostMapRequestHandler.Execute += PostMapRequestHandler_Execute;
        }
        private void PostMapRequestHandler_Execute(object sender, EventArgs e)
        {
            if (!PMCResourceCombinerHelper.Enabled) return;

            // Creates an output filter instance
            if (!URLHelper.IsExcludedSystem(RequestContext.CurrentRelativePath)
                    && PortalContext.ViewMode == ViewModeEnum.LiveSite
                    && !RequestHelper.IsAsyncPostback())
            {
                ResponseOutputFilter.EnsureOutputFilter();

                OutputFilterContext.CurrentFilter.OnAfterFiltering += CombineAxdResources;
                OutputFilterContext.CurrentFilter.OnAfterFiltering += CombineCssResources;
                OutputFilterContext.CurrentFilter.OnAfterFiltering += CombineJsResources;
            }
        }
        private void CombineJsResources(ResponseOutputFilter filter, ref string finalHtml)
        {
            CombineResourceGroups(PMCResourceCombinerGroupType.Js, filter, ref finalHtml);
        }

        private void CombineCssResources(ResponseOutputFilter filter, ref string finalHtml)
        {
            CombineResourceGroups(PMCResourceCombinerGroupType.Css, filter, ref finalHtml);
        }

        private void CombineAxdResources(ResponseOutputFilter filter, ref string finalHtml)
        {
            int index = 0;
            HashSet<string> files = new HashSet<string>();

            Regex regex = PMCResourceCombinerHelper.GetRegex(PMCResourceCombinerGroupType.Axd);
            foreach (Match match in regex.Matches(finalHtml))
            {
                if (index == 0)
                    index = finalHtml.IndexOf(match.Value);

                string relative = match.Groups[1].Value;
                files.Add(relative);
                finalHtml = finalHtml.Replace(match.Value, string.Empty);
            }

            if (index > 0)
            {
                string url = GetOutputLink(PMCResourceCombinerGroupType.Axd, files, "axd");
                finalHtml = finalHtml.Insert(index, ScriptHelper.GetScriptTag(url, false));
            }
        }

        private void CombineResourceGroups(PMCResourceCombinerGroupType type, ResponseOutputFilter filter, ref string finalHtml)
        {
            HashSet<string> groups = new HashSet<string>();
            Dictionary<string, HashSet<Match>> groupMatches = new Dictionary<string, HashSet<System.Text.RegularExpressions.Match>>();
            Dictionary<string, HashSet<string>> groupFiles = new Dictionary<string, HashSet<string>>();
            Dictionary<string, int> groupIndex = new Dictionary<string, int>();

            Regex regex = PMCResourceCombinerHelper.GetRegex(type);

            string newHtml = finalHtml.ToString();
            // Parse matches
            foreach (Match match in regex.Matches(newHtml))
            {
                if (match.Groups[2] == null || string.IsNullOrEmpty(match.Groups[2].Value))
                    continue;

                string groupName = match.Groups[2].Value;
                if (!groups.Contains(match.Groups[2].Value))
                {
                    groups.Add(groupName);
                    groupMatches.Add(groupName, new HashSet<System.Text.RegularExpressions.Match>());
                    groupFiles.Add(groupName, new HashSet<string>());
                    groupIndex.Add(groupName, newHtml.IndexOf(match.Value));
                }
                groupMatches[groupName].Add(match);
                groupFiles[groupName].Add(match.Groups[1].Value);
            }
            if (!groups.Any())
                return;

            int offset = 0;
            // Append tags to group's first index position
            foreach (var group in groups)
            {
                string url = GetOutputLink(type, groupFiles[group], group);
                string tag = string.Empty;

                if (type == PMCResourceCombinerGroupType.Css)
                    tag = CSSHelper.GetCSSFileLink(url);
                else
                    tag = ScriptHelper.GetScriptTag(url, false);


                newHtml = newHtml.Insert(groupIndex[group] + offset, tag);
                offset += tag.Length;
            }

            // Clean up, remove old script references
            foreach (var group in groups)
            {
                foreach (var match in groupMatches[group])
                {
                    newHtml = newHtml.Replace(match.Value, string.Empty);
                }
            }
            finalHtml = newHtml;
        }



        private string GetOutputLink(PMCResourceCombinerGroupType type, HashSet<string> files, string groupName)
        {
            Guid guid = Guid.Empty;
            // append
            string filesCacheKey = PMCResourceCombinerHelper.GetCacheKey(type, RequestContext.IsSSL, files.Select(i => i.GetHashCode()));
            using (CachedSection<Guid> cachedSection = new CachedSection<Guid>(ref guid, CacheHelper.PhysicalFilesCacheMinutes, true, null, filesCacheKey))
            {
                if (cachedSection.LoadData)
                {
                    CacheHelper.TouchKey(PMCResourceCombinerHelper.GetGroupDummyKey(type, groupName));

                    guid = Guid.NewGuid();

                    cachedSection.Data = guid;
                }
            }

            string guidCacheKey = PMCResourceCombinerHelper.GetCacheKey(type, guid, RequestContext.IsSSL);
            PMCResourceCombinerGroup group = null;
            if (!CacheHelper.TryGetItem<PMCResourceCombinerGroup>(guidCacheKey, out group))

            {
                group = new PMCResourceCombinerGroup() { Type = type, Name = groupName, GUID = guid };
                group.Files = files.ToList();

                CacheHelper.Add(guidCacheKey, group, CacheHelper.GetCacheDependency(PMCResourceCombinerHelper.GetGroupDependencies(group)),
                                Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(CacheHelper.PhysicalFilesCacheMinutes));
            }
            return string.Format("~/{0}/{1}/combiner.axd", type.ToString().ToLowerCSafe(), guid);
        }

    }

}
public enum PMCResourceCombinerGroupType
{
    Axd,
    Css,
    Js
}

public class PMCResourceCombinerGroup : IDataContainer, ISimpleDataContainer
{

    /// <summary>
    /// List of component files
    /// </summary>
    private List<string> mFiles;

    /// <summary>
    /// Gets or sets the list of component files
    /// </summary>
    public List<string> Files
    {
        get
        {
            if (this.mFiles == null)
            {
                this.mFiles = new List<string>();
            }
            return this.mFiles;
        }
        set
        {
            this.mFiles = value;
        }
    }

    /// <summary>
    /// Gets or sets the value of the column.
    /// </summary>
    /// <param name="columnName">Column name</param>
    public object this[string columnName]
    {
        get
        {
            return this.GetValue(columnName);
        }
        set
        {
            this.SetValue(columnName, value);
        }
    }

    /// <summary>
    /// Gets the names of the columns this container contains.
    /// </summary>
    public List<string> ColumnNames
    {
        get
        {
            return TypeHelper.NewList(new string[]
            {
                    "Name",
                    "Type",
                    "Guid"
            });
        }
    }

    /// <summary>
    /// Cache dependency for the output
    /// </summary>
    public CMSCacheDependency CacheDependency
    {
        get;
        set;
    }

    /// <summary>
    /// Gets or sets the guid of the group combined.
    /// </summary>
    public Guid GUID
    {
        get;
        set;
    }


    /// <summary>
    /// Gets or sets the name of the group combined.
    /// </summary>
    public string Name
    {
        get;
        set;
    }

    /// <summary>
    /// Gets or sets the type of the group combined.
    /// </summary>
    public PMCResourceCombinerGroupType Type
    {
        get;
        set;
    }

    /// <summary>
    /// Checks if a container contains specific column.
    /// </summary>
    /// <param name="columnName">Name of the column to check</param>
    /// <returns>true, if a container contains given column, otherwise false</returns>
    public bool ContainsColumn(string columnName)
    {
        return this.ColumnNames.Contains(columnName);
    }

    /// <summary>
    /// Attempts to retrieve a value of a column.
    /// </summary>
    /// <param name="columnName">Name of the column</param>
    /// <param name="value">If successful, this object will stored the retrieved value</param>
    /// <returns>true, if object was successfully retrieved, otherwise false</returns>
    public bool TryGetValue(string columnName, out object value)
    {
        value = null;
        string key;
        switch (key = columnName.ToLowerCSafe())
        {
            case "name":
                value = this.Name;
                return true;
            case "type":
                value = this.Type;
                return true;
        }
        return false;
    }

    /// <summary>
    /// Gets the value of a column.
    /// </summary>
    /// <param name="columnName">Name of the column</param>
    /// <returns>The value in a column</returns>
    public object GetValue(string columnName)
    {
        object result;
        this.TryGetValue(columnName, out result);
        return result;
    }

    /// <summary>
    /// Sets the value of a column.
    /// </summary>
    /// <param name="columnName">Name of the column</param>
    /// <param name="value">The value to set</param>
    /// <returns>true, if value was successfully retrieved, otherwise false</returns>
    public bool SetValue(string columnName, object value)
    {
        throw new NotSupportedException();
    }
}