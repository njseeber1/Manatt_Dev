SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_CMS_Tree_Joined WITH SCHEMABINDING AS 
SELECT C.ClassName, C.ClassDisplayName, T.[NodeID], T.[NodeAliasPath], T.[NodeName], T.[NodeAlias], T.[NodeClassID], T.[NodeParentID], T.[NodeLevel], T.[NodeACLID], T.[NodeSiteID], T.[NodeGUID], T.[NodeOrder], T.[IsSecuredNode], T.[NodeCacheMinutes], T.[NodeSKUID], T.[NodeDocType], T.[NodeHeadTags], T.[NodeBodyElementAttributes], T.[NodeInheritPageLevels], T.[RequiresSSL], T.[NodeLinkedNodeID], T.[NodeOwner], T.[NodeCustomData], T.[NodeGroupID], T.[NodeLinkedNodeSiteID], T.[NodeTemplateID], T.[NodeTemplateForAllCultures], T.[NodeInheritPageTemplate], T.[NodeAllowCacheInFileSystem], T.[NodeHasChildren], T.[NodeHasLinks], T.[NodeOriginalNodeID], T.[NodeIsContentOnly], T.[NodeIsACLOwner], D.[DocumentID], D.[DocumentName], D.[DocumentNamePath], D.[DocumentModifiedWhen], D.[DocumentModifiedByUserID], D.[DocumentForeignKeyValue], D.[DocumentCreatedByUserID], D.[DocumentCreatedWhen], D.[DocumentCheckedOutByUserID], D.[DocumentCheckedOutWhen], D.[DocumentCheckedOutVersionHistoryID], D.[DocumentPublishedVersionHistoryID], D.[DocumentWorkflowStepID], D.[DocumentPublishFrom], D.[DocumentPublishTo], D.[DocumentUrlPath], D.[DocumentCulture], D.[DocumentNodeID], D.[DocumentPageTitle], D.[DocumentPageKeyWords], D.[DocumentPageDescription], D.[DocumentShowInSiteMap], D.[DocumentMenuItemHideInNavigation], D.[DocumentMenuCaption], D.[DocumentMenuStyle], D.[DocumentMenuItemImage], D.[DocumentMenuItemLeftImage], D.[DocumentMenuItemRightImage], D.[DocumentPageTemplateID], D.[DocumentMenuJavascript], D.[DocumentMenuRedirectUrl], D.[DocumentUseNamePathForUrlPath], D.[DocumentStylesheetID], D.[DocumentContent], D.[DocumentMenuClass], D.[DocumentMenuStyleHighlighted], D.[DocumentMenuClassHighlighted], D.[DocumentMenuItemImageHighlighted], D.[DocumentMenuItemLeftImageHighlighted], D.[DocumentMenuItemRightImageHighlighted], D.[DocumentMenuItemInactive], D.[DocumentCustomData], D.[DocumentExtensions], D.[DocumentTags], D.[DocumentTagGroupID], D.[DocumentWildcardRule], D.[DocumentWebParts], D.[DocumentRatingValue], D.[DocumentRatings], D.[DocumentPriority], D.[DocumentType], D.[DocumentLastPublished], D.[DocumentUseCustomExtensions], D.[DocumentGroupWebParts], D.[DocumentCheckedOutAutomatically], D.[DocumentTrackConversionName], D.[DocumentConversionValue], D.[DocumentSearchExcluded], D.[DocumentLastVersionNumber], D.[DocumentIsArchived], D.[DocumentHash], D.[DocumentLogVisitActivity], D.[DocumentGUID], D.[DocumentWorkflowCycleGUID], D.[DocumentSitemapSettings], D.[DocumentIsWaitingForTranslation], D.[DocumentSKUName], D.[DocumentSKUDescription], D.[DocumentSKUShortDescription], D.[DocumentWorkflowActionStatus], D.[DocumentMenuRedirectToFirstChild], D.[DocumentCanBePublished], D.[DocumentInheritsStylesheet]
FROM dbo.CMS_Tree T INNER JOIN dbo.CMS_Document D ON T.NodeOriginalNodeID = D.DocumentNodeID INNER JOIN dbo.CMS_Class C ON T.NodeClassID = C.ClassID

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

GO
CREATE UNIQUE CLUSTERED INDEX [IX_View_CMS_Tree_Joined_NodeSiteID_DocumentCulture_NodeID] ON [dbo].[View_CMS_Tree_Joined]
(
	[NodeSiteID] ASC,
	[DocumentCulture] ASC,
	[NodeID] ASC
)
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

GO
CREATE NONCLUSTERED INDEX [IX_View_CMS_Tree_Joined_ClassName_NodeSiteID_DocumentForeignKeyValue_DocumentCulture] ON [dbo].[View_CMS_Tree_Joined]
(
	[ClassName] ASC,
	[NodeSiteID] ASC,
	[DocumentForeignKeyValue] ASC,
	[DocumentCulture] ASC
)
GO
