SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_CMS_SettingsCategory_SelectSite]
	@SiteID int
AS
BEGIN
SELECT DISTINCT CMS_SettingsCategory.* FROM CMS_SettingsKey, CMS_SettingsCategory
	WHERE	CategoryID = KeyCategoryID AND
			SiteID = SiteID ORDER BY CategoryOrder, CategoryDisplayName;
END

GO
