SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_CMS_Relationship_Joined
AS
SELECT        LeftTree.NodeID AS LeftNodeID, LeftTree.NodeGUID AS LeftNodeGUID, LeftTree.NodeName AS LeftNodeName, dbo.CMS_RelationshipName.RelationshipName, 
                         dbo.CMS_RelationshipName.RelationshipNameID, RightTree.NodeID AS RightNodeID, RightTree.NodeGUID AS RightNodeGUID, 
                         RightTree.NodeName AS RightNodeName, dbo.CMS_RelationshipName.RelationshipDisplayName, dbo.CMS_Relationship.RelationshipCustomData, 
                         LeftTree.NodeClassID AS LeftClassID, RightTree.NodeClassID AS RightClassID, dbo.CMS_Relationship.RelationshipID, 
                         dbo.CMS_Relationship.RelationshipOrder
FROM            dbo.CMS_Relationship INNER JOIN
                         dbo.CMS_Tree AS LeftTree ON dbo.CMS_Relationship.LeftNodeID = LeftTree.NodeID INNER JOIN
                         dbo.CMS_Tree AS RightTree ON dbo.CMS_Relationship.RightNodeID = RightTree.NodeID INNER JOIN
                         dbo.CMS_RelationshipName ON dbo.CMS_Relationship.RelationshipNameID = dbo.CMS_RelationshipName.RelationshipNameID


GO
