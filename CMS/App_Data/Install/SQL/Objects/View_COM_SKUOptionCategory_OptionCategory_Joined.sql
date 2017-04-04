SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_COM_SKUOptionCategory_OptionCategory_Joined
AS
SELECT        dbo.COM_SKUOptionCategory.SKUID, dbo.COM_SKUOptionCategory.CategoryID, dbo.COM_SKUOptionCategory.AllowAllOptions, 
                         dbo.COM_SKUOptionCategory.SKUCategoryID, dbo.COM_SKUOptionCategory.SKUCategoryOrder, dbo.COM_OptionCategory.CategoryDisplayName, 
                         dbo.COM_OptionCategory.CategoryName, dbo.COM_OptionCategory.CategorySelectionType, dbo.COM_OptionCategory.CategoryDefaultOptions, 
                         dbo.COM_OptionCategory.CategoryDescription, dbo.COM_OptionCategory.CategoryDefaultRecord, dbo.COM_OptionCategory.CategoryEnabled, 
                         dbo.COM_OptionCategory.CategoryGUID, dbo.COM_OptionCategory.CategoryLastModified, dbo.COM_OptionCategory.CategoryDisplayPrice, 
                         dbo.COM_OptionCategory.CategorySiteID, dbo.COM_OptionCategory.CategoryTextMaxLength, dbo.COM_OptionCategory.CategoryFormControlName, 
                         dbo.COM_OptionCategory.CategoryType, dbo.COM_OptionCategory.CategoryTextMinLength, dbo.COM_OptionCategory.CategoryAllowEmpty, 
                         dbo.COM_OptionCategory.CategoryLiveSiteDisplayName
FROM            dbo.COM_OptionCategory INNER JOIN
                         dbo.COM_SKUOptionCategory ON dbo.COM_OptionCategory.CategoryID = dbo.COM_SKUOptionCategory.CategoryID


GO
