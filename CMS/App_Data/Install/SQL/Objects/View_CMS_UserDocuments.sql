SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_CMS_UserDocuments]
AS
/* APPROVAL */ SELECT DocumentName, NodeSiteID, NodeID, ClassName, ClassDisplayName, DocumentNamePath, DocumentModifiedWhen, DocumentCulture, CultureName, 
                         CMS_UserRole.UserID AS UserID1, 0 AS UserID2, 0 AS UserID3, DocumentWorkflowStepID, NodeAliasPath, 'Pending' AS 'Type'
FROM            View_CMS_Tree_Joined LEFT JOIN
                         CMS_WorkflowStep ON View_CMS_Tree_Joined.DocumentWorkflowStepID = CMS_WorkflowStep.StepID LEFT JOIN
                         CMS_Culture ON View_CMS_Tree_Joined.DocumentCulture = CMS_Culture.CultureCode LEFT JOIN
                         CMS_WorkflowStepRoles ON View_CMS_Tree_Joined.DocumentWorkflowStepID = CMS_WorkflowStepRoles.StepID LEFT JOIN
                         CMS_UserRole ON CMS_UserRole.RoleID = CMS_WorkflowStepRoles.RoleID
WHERE        CMS_WorkflowStep.StepType <> 2 AND CMS_WorkflowStep.StepType <> 100 AND CMS_WorkflowStep.StepType <> 101
UNION ALL
/* MY DOCUMENTS */ SELECT DocumentName, NodeSiteID, NodeID, ClassName, ClassDisplayName, DocumentNamePath, DocumentModifiedWhen, DocumentCulture, 
                         CultureName, NodeOwner AS UserID1, 0 AS UserID2, 0 AS UserID3, DocumentWorkflowStepID, NodeAliasPath, 'My Documents' AS 'Type'
FROM            View_CMS_Tree_Joined LEFT OUTER JOIN
                         CMS_WorkflowStep ON View_CMS_Tree_Joined.DocumentWorkflowStepID = CMS_WorkflowStep.StepID LEFT JOIN
                         CMS_Culture ON View_CMS_Tree_Joined.DocumentCulture = CMS_Culture.CultureCode
UNION ALL
/* RECENT */ SELECT DocumentName, NodeSiteID, NodeID, ClassName, ClassDisplayName, DocumentNamePath, DocumentModifiedWhen, DocumentCulture, CultureName, 
                         DocumentCreatedByUserID AS UserID1, DocumentModifiedByUserID AS UserID2, DocumentCheckedOutByUserID AS UserID3, DocumentWorkflowStepID, 
                         NodeAliasPath, 'Recent' AS 'Type'
FROM            View_CMS_Tree_Joined LEFT OUTER JOIN
                         CMS_WorkflowStep ON View_CMS_Tree_Joined.DocumentWorkflowStepID = CMS_WorkflowStep.StepID LEFT JOIN
                         CMS_Culture ON View_CMS_Tree_Joined.DocumentCulture = CMS_Culture.CultureCode
UNION ALL
/* RECYCLE BIN */ SELECT DocumentNamePath, NodeSiteID, '' AS NodeId, ClassName, ClassDisplayName, DocumentNamePath, 
                         VersionDeletedWhen AS DocumentModifiedWhen, '' AS DocumentCulture, '' AS CultureName, VersionDeletedByUserID AS UserID1, 0 AS UserID2, 0 AS UserID3, 
                         VersionWorkflowStepID AS DocumentWorkflowStepID, '' AS NodeAliasPath, 'Recycle bin' AS 'Type'
FROM            CMS_VersionHistory INNER JOIN
                         CMS_Class ON CMS_VersionHistory.VersionClassID = CMS_Class.ClassID 
WHERE        (DocumentID NOT IN
                             (SELECT        DocumentID
                               FROM            CMS_Document) AND VersionHistoryID =
                             (SELECT        MAX(VersionHistoryID)
                               FROM            CMS_VersionHistory A
                               WHERE        A.DocumentID = CMS_VersionHistory.DocumentID))
UNION ALL
/* CHECKED OUT */ SELECT DocumentName, NodeSiteID, NodeID, ClassName, ClassDisplayName, DocumentNamePath, DocumentModifiedWhen, DocumentCulture, 
                         CultureName, 0 AS UserID1, 0 AS UserID2, DocumentCheckedOutByUserID AS UserID3, DocumentWorkflowStepID, NodeAliasPath,  
                         'Checked out' AS 'Type'
FROM            View_CMS_Tree_Joined LEFT OUTER JOIN
                         CMS_WorkflowStep ON View_CMS_Tree_Joined.DocumentWorkflowStepID = CMS_WorkflowStep.StepID LEFT JOIN
                         CMS_Culture ON View_CMS_Tree_Joined.DocumentCulture = CMS_Culture.CultureCode


GO
