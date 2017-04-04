SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_ContactStatus](
	[ContactStatusID] [int] IDENTITY(1,1) NOT NULL,
	[ContactStatusName] [nvarchar](200) NOT NULL,
	[ContactStatusDisplayName] [nvarchar](200) NOT NULL,
	[ContactStatusDescription] [nvarchar](max) NULL,
	[ContactStatusSiteID] [int] NULL,
 CONSTRAINT [PK_OM_ContactStatus] PRIMARY KEY CLUSTERED 
(
	[ContactStatusID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_ContactStatus_ContactStatusSiteID] ON [dbo].[OM_ContactStatus]
(
	[ContactStatusSiteID] ASC
)
GO
ALTER TABLE [dbo].[OM_ContactStatus] ADD  CONSTRAINT [DEFAULT_OM_ContactStatus_ContactStatusName]  DEFAULT ('') FOR [ContactStatusName]
GO
ALTER TABLE [dbo].[OM_ContactStatus] ADD  CONSTRAINT [DEFAULT_OM_ContactStatus_ContactStatusDisplayName]  DEFAULT ('') FOR [ContactStatusDisplayName]
GO
ALTER TABLE [dbo].[OM_ContactStatus]  WITH CHECK ADD  CONSTRAINT [FK_OM_ContactStatus_CMS_Site] FOREIGN KEY([ContactStatusSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_ContactStatus] CHECK CONSTRAINT [FK_OM_ContactStatus_CMS_Site]
GO
