SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_AbuseReport](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[ReportGUID] [uniqueidentifier] NOT NULL,
	[ReportTitle] [nvarchar](100) NULL,
	[ReportURL] [nvarchar](1000) NOT NULL,
	[ReportCulture] [nvarchar](50) NOT NULL,
	[ReportObjectID] [int] NULL,
	[ReportObjectType] [nvarchar](100) NULL,
	[ReportComment] [nvarchar](max) NOT NULL,
	[ReportUserID] [int] NULL,
	[ReportWhen] [datetime2](7) NOT NULL,
	[ReportStatus] [int] NOT NULL,
	[ReportSiteID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_AbuseReport] PRIMARY KEY NONCLUSTERED 
(
	[ReportID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_AbuseReport_ReportWhen] ON [dbo].[CMS_AbuseReport]
(
	[ReportWhen] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AbuseReport_ReportSiteID] ON [dbo].[CMS_AbuseReport]
(
	[ReportSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AbuseReport_ReportStatus] ON [dbo].[CMS_AbuseReport]
(
	[ReportStatus] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AbuseReport_ReportUserID] ON [dbo].[CMS_AbuseReport]
(
	[ReportUserID] ASC
)
GO
ALTER TABLE [dbo].[CMS_AbuseReport] ADD  CONSTRAINT [DEFAULT_cms_abusereport_ReportGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ReportGUID]
GO
ALTER TABLE [dbo].[CMS_AbuseReport] ADD  CONSTRAINT [DEFAULT_CMS_AbuseReport_ReportTitle]  DEFAULT ('') FOR [ReportTitle]
GO
ALTER TABLE [dbo].[CMS_AbuseReport] ADD  CONSTRAINT [DEFAULT_cms_abusereport_ReportURL]  DEFAULT ('') FOR [ReportURL]
GO
ALTER TABLE [dbo].[CMS_AbuseReport] ADD  CONSTRAINT [DEFAULT_cms_abusereport_ReportCulture]  DEFAULT ('') FOR [ReportCulture]
GO
ALTER TABLE [dbo].[CMS_AbuseReport] ADD  CONSTRAINT [DEFAULT_cms_abusereport_ReportComment]  DEFAULT ('') FOR [ReportComment]
GO
ALTER TABLE [dbo].[CMS_AbuseReport] ADD  CONSTRAINT [DEFAULT_cms_abusereport_ReportWhen]  DEFAULT ('9/11/2008 4:32:15 PM') FOR [ReportWhen]
GO
ALTER TABLE [dbo].[CMS_AbuseReport] ADD  CONSTRAINT [DEFAULT_cms_abusereport_ReportStatus]  DEFAULT ((0)) FOR [ReportStatus]
GO
ALTER TABLE [dbo].[CMS_AbuseReport] ADD  CONSTRAINT [DEFAULT_cms_abusereport_ReportSiteID]  DEFAULT ((0)) FOR [ReportSiteID]
GO
ALTER TABLE [dbo].[CMS_AbuseReport]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AbuseReport_ReportSiteID_CMS_Site] FOREIGN KEY([ReportSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_AbuseReport] CHECK CONSTRAINT [FK_CMS_AbuseReport_ReportSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_AbuseReport]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AbuseReport_ReportUserID_CMS_User] FOREIGN KEY([ReportUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_AbuseReport] CHECK CONSTRAINT [FK_CMS_AbuseReport_ReportUserID_CMS_User]
GO
