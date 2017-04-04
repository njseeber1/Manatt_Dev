SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_CMS_ResourceString_Joined
AS
SELECT        dbo.CMS_ResourceString.StringID, dbo.CMS_ResourceString.StringKey, dbo.CMS_ResourceString.StringIsCustom, dbo.CMS_ResourceString.StringLoadGeneration, 
                         dbo.CMS_ResourceTranslation.TranslationID, dbo.CMS_ResourceTranslation.TranslationStringID, dbo.CMS_ResourceTranslation.TranslationCultureID, 
                         dbo.CMS_ResourceTranslation.TranslationText, dbo.CMS_Culture.CultureID, dbo.CMS_Culture.CultureName, dbo.CMS_Culture.CultureCode, 
                         dbo.CMS_Culture.CultureGUID, dbo.CMS_Culture.CultureLastModified
FROM            dbo.CMS_ResourceString LEFT OUTER JOIN
                         dbo.CMS_ResourceTranslation ON dbo.CMS_ResourceString.StringID = dbo.CMS_ResourceTranslation.TranslationStringID LEFT OUTER JOIN
                         dbo.CMS_Culture ON dbo.CMS_ResourceTranslation.TranslationCultureID = dbo.CMS_Culture.CultureID


GO
