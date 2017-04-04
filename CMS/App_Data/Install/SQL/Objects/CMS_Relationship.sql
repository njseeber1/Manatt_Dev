SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Relationship](
	[RelationshipID] [int] IDENTITY(1,1) NOT NULL,
	[LeftNodeID] [int] NOT NULL,
	[RightNodeID] [int] NOT NULL,
	[RelationshipNameID] [int] NOT NULL,
	[RelationshipCustomData] [nvarchar](max) NULL,
	[RelationshipOrder] [int] NULL,
	[RelationshipIsAdHoc] [bit] NULL,
 CONSTRAINT [PK_CMS_Relationship] PRIMARY KEY CLUSTERED 
(
	[RelationshipID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Relationship_LeftNodeID] ON [dbo].[CMS_Relationship]
(
	[LeftNodeID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Relationship_RelationshipNameID] ON [dbo].[CMS_Relationship]
(
	[RelationshipNameID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Relationship_RightNodeID] ON [dbo].[CMS_Relationship]
(
	[RightNodeID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Relationship]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Relationship_LeftNodeID_CMS_Tree] FOREIGN KEY([LeftNodeID])
REFERENCES [dbo].[CMS_Tree] ([NodeID])
GO
ALTER TABLE [dbo].[CMS_Relationship] CHECK CONSTRAINT [FK_CMS_Relationship_LeftNodeID_CMS_Tree]
GO
ALTER TABLE [dbo].[CMS_Relationship]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Relationship_RelationshipNameID_CMS_RelationshipName] FOREIGN KEY([RelationshipNameID])
REFERENCES [dbo].[CMS_RelationshipName] ([RelationshipNameID])
GO
ALTER TABLE [dbo].[CMS_Relationship] CHECK CONSTRAINT [FK_CMS_Relationship_RelationshipNameID_CMS_RelationshipName]
GO
ALTER TABLE [dbo].[CMS_Relationship]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Relationship_RightNodeID_CMS_Tree] FOREIGN KEY([RightNodeID])
REFERENCES [dbo].[CMS_Tree] ([NodeID])
GO
ALTER TABLE [dbo].[CMS_Relationship] CHECK CONSTRAINT [FK_CMS_Relationship_RightNodeID_CMS_Tree]
GO
