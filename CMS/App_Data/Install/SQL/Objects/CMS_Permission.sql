SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Permission](
	[PermissionID] [int] IDENTITY(1,1) NOT NULL,
	[PermissionDisplayName] [nvarchar](100) NOT NULL,
	[PermissionName] [nvarchar](100) NOT NULL,
	[ClassID] [int] NULL,
	[ResourceID] [int] NULL,
	[PermissionGUID] [uniqueidentifier] NOT NULL,
	[PermissionLastModified] [datetime2](7) NOT NULL,
	[PermissionDescription] [nvarchar](max) NULL,
	[PermissionDisplayInMatrix] [bit] NULL,
	[PermissionOrder] [int] NULL,
	[PermissionEditableByGlobalAdmin] [bit] NULL,
 CONSTRAINT [PK_CMS_Permission] PRIMARY KEY CLUSTERED 
(
	[PermissionID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Permission_ClassID_PermissionName] ON [dbo].[CMS_Permission]
(
	[ClassID] ASC,
	[PermissionName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Permission_ResourceID_PermissionName] ON [dbo].[CMS_Permission]
(
	[ResourceID] ASC,
	[PermissionName] ASC
)
GO
ALTER TABLE [dbo].[CMS_Permission] ADD  CONSTRAINT [DEFAULT_CMS_Permission_PermissionDisplayInMatrix]  DEFAULT ((0)) FOR [PermissionDisplayInMatrix]
GO
ALTER TABLE [dbo].[CMS_Permission]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_Permission_ClassID_CMS_Class] FOREIGN KEY([ClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_Permission] CHECK CONSTRAINT [FK_CMS_Permission_ClassID_CMS_Class]
GO
ALTER TABLE [dbo].[CMS_Permission]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_Permission_ResourceID_CMS_Resource] FOREIGN KEY([ResourceID])
REFERENCES [dbo].[CMS_Resource] ([ResourceID])
GO
ALTER TABLE [dbo].[CMS_Permission] CHECK CONSTRAINT [FK_CMS_Permission_ResourceID_CMS_Resource]
GO
