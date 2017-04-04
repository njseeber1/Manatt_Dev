SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_RelationshipName](
	[RelationshipNameID] [int] IDENTITY(1,1) NOT NULL,
	[RelationshipDisplayName] [nvarchar](200) NOT NULL,
	[RelationshipName] [nvarchar](200) NOT NULL,
	[RelationshipAllowedObjects] [nvarchar](450) NULL,
	[RelationshipGUID] [uniqueidentifier] NOT NULL,
	[RelationshipLastModified] [datetime2](7) NOT NULL,
	[RelationshipNameIsAdHoc] [bit] NULL,
 CONSTRAINT [PK_CMS_RelationshipName] PRIMARY KEY CLUSTERED 
(
	[RelationshipNameID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_RelationshipName_RelationshipAllowedObjects] ON [dbo].[CMS_RelationshipName]
(
	[RelationshipAllowedObjects] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_RelationshipName_RelationshipName_RelationshipDisplayName] ON [dbo].[CMS_RelationshipName]
(
	[RelationshipName] ASC,
	[RelationshipDisplayName] ASC
)
GO
ALTER TABLE [dbo].[CMS_RelationshipName] ADD  CONSTRAINT [DEFAULT_CMS_RelationshipName_RelationshipDisplayName]  DEFAULT ('') FOR [RelationshipDisplayName]
GO
ALTER TABLE [dbo].[CMS_RelationshipName] ADD  CONSTRAINT [DEFAULT_CMS_RelationshipName_RelationshipName]  DEFAULT ('') FOR [RelationshipName]
GO
ALTER TABLE [dbo].[CMS_RelationshipName] ADD  CONSTRAINT [DEFAULT_CMS_RelationshipName_RelationshipGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [RelationshipGUID]
GO
