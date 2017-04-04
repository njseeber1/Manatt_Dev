SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_CMS_SettingsKeyCategory
AS
SELECT        dbo.CMS_SettingsCategory.CategoryID AS Expr19, dbo.CMS_SettingsCategory.CategoryDisplayName AS Expr20, 
                         dbo.CMS_SettingsCategory.CategoryOrder AS Expr21, dbo.CMS_SettingsCategory.CategoryName AS Expr22, 
                         dbo.CMS_SettingsCategory.CategoryParentID AS Expr23, dbo.CMS_SettingsCategory.CategoryIDPath AS Expr24, 
                         dbo.CMS_SettingsCategory.CategoryLevel AS Expr25, dbo.CMS_SettingsCategory.CategoryChildCount AS Expr26, 
                         dbo.CMS_SettingsCategory.CategoryIconPath AS Expr27, dbo.CMS_SettingsCategory.CategoryIsGroup AS Expr28, 
                         dbo.CMS_SettingsCategory.CategoryIsCustom AS Expr29, dbo.CMS_SettingsKey.KeyID AS Expr1, dbo.CMS_SettingsKey.KeyName AS Expr2, 
                         dbo.CMS_SettingsKey.KeyDisplayName AS Expr3, dbo.CMS_SettingsKey.KeyDescription AS Expr4, dbo.CMS_SettingsKey.KeyValue AS Expr5, 
                         dbo.CMS_SettingsKey.KeyType AS Expr6, dbo.CMS_SettingsKey.KeyCategoryID AS Expr7, dbo.CMS_SettingsKey.SiteID AS Expr8, 
                         dbo.CMS_SettingsKey.KeyGUID AS Expr9, dbo.CMS_SettingsKey.KeyLastModified AS Expr10, dbo.CMS_SettingsKey.KeyOrder AS Expr11, 
                         dbo.CMS_SettingsKey.KeyDefaultValue AS Expr12, dbo.CMS_SettingsKey.KeyValidation AS Expr13, dbo.CMS_SettingsKey.KeyEditingControlPath AS Expr14, 
                         dbo.CMS_SettingsKey.KeyLoadGeneration AS Expr15, dbo.CMS_SettingsKey.KeyIsGlobal AS Expr16, dbo.CMS_SettingsKey.KeyIsCustom AS Expr17, 
                         dbo.CMS_SettingsKey.KeyIsHidden AS Expr18, dbo.CMS_SettingsKey.KeyFormControlSettings AS KeyFormFieldInfoXml, dbo.CMS_SettingsKey.*, 
                         dbo.CMS_SettingsCategory.*
FROM            dbo.CMS_SettingsKey LEFT OUTER JOIN
                         dbo.CMS_SettingsCategory ON dbo.CMS_SettingsKey.KeyCategoryID = dbo.CMS_SettingsCategory.CategoryID


GO
