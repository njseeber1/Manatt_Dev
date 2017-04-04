SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_ObjectVersionHistory](
	[VersionID] [int] IDENTITY(1,1) NOT NULL,
	[VersionObjectID] [int] NULL,
	[VersionObjectType] [nvarchar](100) NOT NULL,
	[VersionObjectSiteID] [int] NULL,
	[VersionObjectDisplayName] [nvarchar](450) NOT NULL,
	[VersionXML] [nvarchar](max) NOT NULL,
	[VersionBinaryDataXML] [nvarchar](max) NULL,
	[VersionModifiedByUserID] [int] NULL,
	[VersionModifiedWhen] [datetime2](7) NOT NULL,
	[VersionDeletedByUserID] [int] NULL,
	[VersionDeletedWhen] [datetime2](7) NULL,
	[VersionNumber] [nvarchar](50) NOT NULL,
	[VersionSiteBindingIDs] [nvarchar](max) NULL,
	[VersionComment] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_ObjectVersionHistory_VersionID] PRIMARY KEY NONCLUSTERED 
(
	[VersionID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE CLUSTERED INDEX [PK_CMS_ObjectVersionHistory] ON [dbo].[CMS_ObjectVersionHistory]
(
	[VersionObjectType] ASC,
	[VersionObjectID] ASC,
	[VersionID] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectVersionHistory_VersionDeletedByUserID_VersionDeletedWhen] ON [dbo].[CMS_ObjectVersionHistory]
(
	[VersionDeletedByUserID] ASC,
	[VersionDeletedWhen] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectVersionHistory_VersionModifiedByUserID] ON [dbo].[CMS_ObjectVersionHistory]
(
	[VersionModifiedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectVersionHistory_VersionObjectSiteID_VersionDeletedWhen] ON [dbo].[CMS_ObjectVersionHistory]
(
	[VersionObjectSiteID] ASC,
	[VersionDeletedWhen] DESC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_ObjectVersionHistory_VersionObjectType_VersionObjectID_VersionModifiedWhen] ON [dbo].[CMS_ObjectVersionHistory]
(
	[VersionObjectType] ASC,
	[VersionObjectID] ASC,
	[VersionModifiedWhen] DESC
)
GO


ALTER TABLE [dbo].[CMS_ObjectVersionHistory] ADD  CONSTRAINT [DEFAULT_CMS_ObjectVersionHistory_VersionNumber] 
DEFAULT ('') FOR [VersionNumber]
GO

ALTER TABLE [dbo].[CMS_ObjectVersionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ObjectVersionHistory_VersionDeletedByUserID_CMS_User] FOREIGN KEY([VersionDeletedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_ObjectVersionHistory] CHECK CONSTRAINT [FK_CMS_ObjectVersionHistory_VersionDeletedByUserID_CMS_User]
GO

ALTER TABLE [dbo].[CMS_ObjectVersionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ObjectVersionHistory_VersionModifiedByUserID_CMS_User] 
FOREIGN KEY([VersionModifiedByUserID]) REFERENCES [dbo].[CMS_User] ([UserID])
GO

ALTER TABLE [dbo].[CMS_ObjectVersionHistory] CHECK CONSTRAINT [FK_CMS_ObjectVersionHistory_VersionModifiedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_ObjectVersionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ObjectVersionHistory_VersionObjectSiteID_CMS_Site] FOREIGN KEY([VersionObjectSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_ObjectVersionHistory] CHECK CONSTRAINT [FK_CMS_ObjectVersionHistory_VersionObjectSiteID_CMS_Site]
GO
