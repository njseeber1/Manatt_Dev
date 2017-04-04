SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Export_History](
	[ExportID] [int] IDENTITY(1,1) NOT NULL,
	[ExportDateTime] [datetime2](7) NOT NULL,
	[ExportFileName] [nvarchar](450) NOT NULL,
	[ExportSiteID] [int] NULL,
	[ExportUserID] [int] NULL,
	[ExportSettings] [nvarchar](max) NULL,
 CONSTRAINT [PK_Export_History] PRIMARY KEY NONCLUSTERED 
(
	[ExportID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_Export_History_ExportDateTime] ON [dbo].[Export_History]
(
	[ExportDateTime] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_Export_History_ExportSiteID] ON [dbo].[Export_History]
(
	[ExportSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Export_History_ExportUserID] ON [dbo].[Export_History]
(
	[ExportUserID] ASC
)
GO
ALTER TABLE [dbo].[Export_History] ADD  CONSTRAINT [DEFAULT_Export_History_ExportFileName]  DEFAULT (N'') FOR [ExportFileName]
GO
ALTER TABLE [dbo].[Export_History]  WITH CHECK ADD  CONSTRAINT [FK_Export_History_ExportSiteID_CMS_Site] FOREIGN KEY([ExportSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Export_History] CHECK CONSTRAINT [FK_Export_History_ExportSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[Export_History]  WITH CHECK ADD  CONSTRAINT [FK_Export_History_ExportUserID_CMS_User] FOREIGN KEY([ExportUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Export_History] CHECK CONSTRAINT [FK_Export_History_ExportUserID_CMS_User]
GO
