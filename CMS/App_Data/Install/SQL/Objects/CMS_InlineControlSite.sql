SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_InlineControlSite](
	[ControlID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_InlineControlSite] PRIMARY KEY CLUSTERED 
(
	[ControlID] ASC,
	[SiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_InlineControlSite_SiteID] ON [dbo].[CMS_InlineControlSite]
(
	[SiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_InlineControlSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_InlineControlSite_ControlD_CMS_InlineControl] FOREIGN KEY([ControlID])
REFERENCES [dbo].[CMS_InlineControl] ([ControlID])
GO
ALTER TABLE [dbo].[CMS_InlineControlSite] CHECK CONSTRAINT [FK_CMS_InlineControlSite_ControlD_CMS_InlineControl]
GO
ALTER TABLE [dbo].[CMS_InlineControlSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_InlineControlSite_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_InlineControlSite] CHECK CONSTRAINT [FK_CMS_InlineControlSite_SiteID_CMS_Site]
GO
