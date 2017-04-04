SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[View_CMS_ResourceTranslated_Joined]
AS
SELECT StringID, StringKey, TranslationText, CultureID, CultureName, CultureCode
FROM CMS_ResourceString 
CROSS JOIN CMS_Culture 
LEFT OUTER JOIN CMS_ResourceTranslation ON CMS_ResourceString.StringID = CMS_ResourceTranslation.TranslationStringID AND CMS_ResourceTranslation.TranslationCultureID = CMS_Culture.CultureID



GO
