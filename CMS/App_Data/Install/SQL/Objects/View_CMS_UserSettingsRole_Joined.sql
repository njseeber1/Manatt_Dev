SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_CMS_UserSettingsRole_Joined
AS
SELECT        dbo.CMS_UserRole.UserID, dbo.CMS_UserRole.RoleID, dbo.CMS_User.UserName, dbo.CMS_User.FullName, dbo.CMS_User.Email, dbo.CMS_Role.RoleName, 
                         dbo.CMS_Role.RoleDisplayName, dbo.CMS_Role.RoleDescription, dbo.CMS_Site.SiteID, dbo.CMS_Site.SiteName, ISNULL(dbo.CMS_UserSettings.UserBounces, 0) 
                         AS UserBounces, dbo.CMS_User.UserEnabled
FROM            dbo.CMS_UserRole INNER JOIN
                         dbo.CMS_Role ON dbo.CMS_UserRole.RoleID = dbo.CMS_Role.RoleID INNER JOIN
                         dbo.CMS_User ON dbo.CMS_UserRole.UserID = dbo.CMS_User.UserID INNER JOIN
                         dbo.CMS_Site ON dbo.CMS_Role.SiteID = dbo.CMS_Site.SiteID INNER JOIN
                         dbo.CMS_UserSettings ON dbo.CMS_UserRole.UserID = dbo.CMS_UserSettings.UserSettingsUserID


GO
