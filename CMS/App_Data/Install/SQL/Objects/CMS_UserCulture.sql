SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_UserCulture](
	[UserID] [int] NOT NULL,
	[CultureID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_UserCulture] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[CultureID] ASC,
	[SiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserCulture_CultureID] ON [dbo].[CMS_UserCulture]
(
	[CultureID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserCulture_SiteID] ON [dbo].[CMS_UserCulture]
(
	[SiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_UserCulture]  WITH CHECK ADD  CONSTRAINT [FK_CMS_UserCulture_CultureID_CMS_Culture] FOREIGN KEY([CultureID])
REFERENCES [dbo].[CMS_Culture] ([CultureID])
GO
ALTER TABLE [dbo].[CMS_UserCulture] CHECK CONSTRAINT [FK_CMS_UserCulture_CultureID_CMS_Culture]
GO
ALTER TABLE [dbo].[CMS_UserCulture]  WITH CHECK ADD  CONSTRAINT [FK_CMS_UserCulture_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_UserCulture] CHECK CONSTRAINT [FK_CMS_UserCulture_SiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_UserCulture]  WITH CHECK ADD  CONSTRAINT [FK_CMS_UserCulture_UserID_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_UserCulture] CHECK CONSTRAINT [FK_CMS_UserCulture_UserID_CMS_User]
GO
