SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_PublicStatus](
	[PublicStatusID] [int] IDENTITY(1,1) NOT NULL,
	[PublicStatusName] [nvarchar](200) NOT NULL,
	[PublicStatusDisplayName] [nvarchar](200) NOT NULL,
	[PublicStatusEnabled] [bit] NOT NULL,
	[PublicStatusGUID] [uniqueidentifier] NULL,
	[PublicStatusLastModified] [datetime2](7) NOT NULL,
	[PublicStatusSiteID] [int] NULL,
 CONSTRAINT [PK_COM_PublicStatus] PRIMARY KEY NONCLUSTERED 
(
	[PublicStatusID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_PublicStatus_PublicStatusDisplayName_PublicStatusEnabled] ON [dbo].[COM_PublicStatus]
(
	[PublicStatusDisplayName] ASC,
	[PublicStatusEnabled] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_PublicStatus_PublicStatusSiteID] ON [dbo].[COM_PublicStatus]
(
	[PublicStatusSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_PublicStatus] ADD  CONSTRAINT [DEFAULT_COM_PublicStatus_PublicStatusName]  DEFAULT (N'') FOR [PublicStatusName]
GO
ALTER TABLE [dbo].[COM_PublicStatus] ADD  CONSTRAINT [DEFAULT_COM_PublicStatus_PublicStatusDisplayName]  DEFAULT (N'') FOR [PublicStatusDisplayName]
GO
ALTER TABLE [dbo].[COM_PublicStatus] ADD  CONSTRAINT [DEFAULT_COM_PublicStatus_PublicStatusEnabled]  DEFAULT ((1)) FOR [PublicStatusEnabled]
GO
ALTER TABLE [dbo].[COM_PublicStatus]  WITH CHECK ADD  CONSTRAINT [FK_COM_PublicStatus_PublicStatusSiteID_CMS_Site] FOREIGN KEY([PublicStatusSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_PublicStatus] CHECK CONSTRAINT [FK_COM_PublicStatus_PublicStatusSiteID_CMS_Site]
GO
