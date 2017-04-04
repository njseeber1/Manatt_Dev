SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_ObjectRelationship](
	[RelationshipID] [int] IDENTITY(1,1) NOT NULL,
	[RelationshipLeftObjectID] [int] NOT NULL,
	[RelationshipLeftObjectType] [nvarchar](100) NOT NULL,
	[RelationshipNameID] [int] NOT NULL,
	[RelationshipRightObjectID] [int] NOT NULL,
	[RelationshipRightObjectType] [nvarchar](100) NOT NULL,
	[RelationshipCustomData] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_ObjectRelationship] PRIMARY KEY CLUSTERED 
(
	[RelationshipID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectRelationship_RelationshipLeftObjectType_RelationshipLeftObjectID] ON [dbo].[CMS_ObjectRelationship]
(
	[RelationshipLeftObjectType] ASC,
	[RelationshipLeftObjectID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectRelationship_RelationshipNameID] ON [dbo].[CMS_ObjectRelationship]
(
	[RelationshipNameID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectRelationship_RelationshipRightObjectType_RelationshipRightObjectID] ON [dbo].[CMS_ObjectRelationship]
(
	[RelationshipRightObjectType] ASC,
	[RelationshipRightObjectID] ASC
)
GO
ALTER TABLE [dbo].[CMS_ObjectRelationship]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ObjectRelationship_RelationshipNameID_CMS_RelationshipName] FOREIGN KEY([RelationshipNameID])
REFERENCES [dbo].[CMS_RelationshipName] ([RelationshipNameID])
GO
ALTER TABLE [dbo].[CMS_ObjectRelationship] CHECK CONSTRAINT [FK_CMS_ObjectRelationship_RelationshipNameID_CMS_RelationshipName]
GO
