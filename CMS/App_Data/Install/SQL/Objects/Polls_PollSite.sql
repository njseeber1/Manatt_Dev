SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Polls_PollSite](
	[PollID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
 CONSTRAINT [PK_Polls_PollSite] PRIMARY KEY CLUSTERED 
(
	[PollID] ASC,
	[SiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Polls_PollSite_SiteID] ON [dbo].[Polls_PollSite]
(
	[SiteID] ASC
)
GO
ALTER TABLE [dbo].[Polls_PollSite]  WITH CHECK ADD  CONSTRAINT [FK_Polls_PollSite_PollID_Polls_Poll] FOREIGN KEY([PollID])
REFERENCES [dbo].[Polls_Poll] ([PollID])
GO
ALTER TABLE [dbo].[Polls_PollSite] CHECK CONSTRAINT [FK_Polls_PollSite_PollID_Polls_Poll]
GO
ALTER TABLE [dbo].[Polls_PollSite]  WITH CHECK ADD  CONSTRAINT [FK_Polls_PollSite_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Polls_PollSite] CHECK CONSTRAINT [FK_Polls_PollSite_SiteID_CMS_Site]
GO
