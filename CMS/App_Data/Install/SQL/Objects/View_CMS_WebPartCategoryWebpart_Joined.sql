SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_CMS_WebPartCategoryWebpart_Joined]
AS
(SELECT     CategoryID AS ObjectID, CategoryName AS CodeName, CategoryDisplayName AS DisplayName, CategoryParentID AS ParentID, CategoryGUID AS GUID, 
                      CategoryLastModified AS LastModified, CategoryImagePath, CategoryPath AS ObjectPath, CategoryLevel AS ObjectLevel, CategoryChildCount, 
                      CategoryWebPartChildCount, ISNULL(CategoryChildCount, 0) + ISNULL(CategoryWebPartChildCount, 0) AS CompleteChildCount, NULL AS WebPartParentID, NULL 
                      AS WebPartFileName, NULL AS WebPartGUID, NULL AS WebPartType, NULL AS WebPartLoadGeneration, NULL AS WebPartDescription, 
                      'webpartcategory' AS ObjectType, NULL AS ThumbnailGUID, NULL AS IconClass, NULL AS WebPartSkipInsertProperties, 0 AS CategoryOrder
FROM         CMS_WebPartCategory)
UNION ALL
(SELECT     WebPartID AS ObjectID, WebPartName AS CodeName, WebPartDisplayName AS DisplayName, WebPartCategoryID AS ParentID, WebPartGUID AS GUID, 
                        WebPartLastModified AS LastModified, NULL AS CategoryImagePath, CMS_WebPartCategory.CategoryPath + '/' + WebPartName AS ObjectPath, 
                        CMS_WebPartCategory.CategoryLevel + 1 AS ObjectLevel, 0 AS CategoryChildCount, 0 AS CategoryWebPartChildCount, 0 AS CompleteChildCount, WebPartParentID, 
                        WebPartFileName, WebPartGUID, WebPartType, WebPartLoadGeneration, CAST(WebPartDescription AS nvarchar(1000)), 
                        'webpart' AS ObjectType, WebPartThumbnailGUID AS ThumbnailGUID, WebPartIconClass AS IconClass, WebPartSkipInsertProperties, 0 AS CategoryOrder
 FROM         CMS_WebPart LEFT JOIN
                        CMS_WebPartCategory ON CMS_WebPart.WebPartCategoryID = CMS_WebPartCategory.CategoryID)



GO
