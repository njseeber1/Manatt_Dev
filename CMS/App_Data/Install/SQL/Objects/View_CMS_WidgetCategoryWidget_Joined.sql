SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_CMS_WidgetCategoryWidget_Joined
AS
(SELECT     WidgetCategoryID AS ObjectID, WidgetCategoryName AS CodeName, WidgetCategoryDisplayName AS DisplayName, WidgetCategoryParentID AS ParentID, 
                      WidgetCategoryGUID AS GUID, WidgetCategoryLastModified AS LastModified, WidgetCategoryImagePath, WidgetCategoryPath AS ObjectPath, 
                      WidgetCategoryLevel AS ObjectLevel, WidgetCategoryChildCount, WidgetCategoryWidgetChildCount, ISNULL(WidgetCategoryChildCount, 0) 
                      + ISNULL(WidgetCategoryWidgetChildCount, 0) AS CompleteChildCount, NULL AS WidgetWebPartID, 0 AS WidgetSecurity, NULL AS WidgetForGroup, NULL 
                      AS WidgetForInline, NULL AS WidgetForUser, NULL AS WidgetForEditor, NULL AS WidgetForDashboard, NULL AS WidgetGUID, 'widgetcategory' AS ObjectType, 0 AS WidgetCategoryOrder
FROM         CMS_WidgetCategory)
UNION ALL
(SELECT     WidgetID AS ObjectID, WidgetName AS CodeName, WidgetDisplayName AS DisplayName, CMS_Widget.WidgetCategoryID AS ParentID, WidgetGUID AS GUID, 
                        WidgetLastModified AS LastModified, NULL AS WidgetCategoryImagePath, CMS_WidgetCategory.WidgetCategoryPath + '/' + WidgetName AS ObjectPath, 
                        CMS_WidgetCategory.WidgetCategoryLevel + 1 AS ObjectLevel, 0 AS WidgetCategoryChildCount, 0 AS WidgetCategoryWidgetChildCount, 
                        0 AS WidgetCompleteChildCount, WidgetWebPartID, WidgetSecurity, WidgetForGroup, WidgetForInline, WidgetForUser, WidgetForEditor, WidgetForDashboard, 
                        WidgetGUID, 'widget' AS ObjectType, 0 AS WidgetCategoryOrder
 FROM         CMS_Widget LEFT JOIN
                        CMS_WidgetCategory ON CMS_Widget.WidgetCategoryID = CMS_WidgetCategory.WidgetCategoryID)


GO
