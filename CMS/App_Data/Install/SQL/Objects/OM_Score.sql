SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_Score](
	[ScoreID] [int] IDENTITY(1,1) NOT NULL,
	[ScoreName] [nvarchar](200) NOT NULL,
	[ScoreDisplayName] [nvarchar](200) NOT NULL,
	[ScoreDescription] [nvarchar](max) NULL,
	[ScoreSiteID] [int] NOT NULL,
	[ScoreEnabled] [bit] NOT NULL,
	[ScoreEmailAtScore] [int] NULL,
	[ScoreNotificationEmail] [nvarchar](250) NULL,
	[ScoreLastModified] [datetime2](7) NOT NULL,
	[ScoreGUID] [uniqueidentifier] NOT NULL,
	[ScoreStatus] [int] NULL,
	[ScoreScheduledTaskID] [int] NULL,
	[ScoreBelongsToPersona] [bit] NOT NULL,
 CONSTRAINT [PK_OM_Score] PRIMARY KEY CLUSTERED 
(
	[ScoreID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_Score_ScoreSiteID] ON [dbo].[OM_Score]
(
	[ScoreSiteID] ASC
)
GO
ALTER TABLE [dbo].[OM_Score] ADD  CONSTRAINT [DEFAULT_OM_Score_ScoreBelongsToPersona]  DEFAULT ((0)) FOR [ScoreBelongsToPersona]
GO
ALTER TABLE [dbo].[OM_Score]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Score_CMS_Site] FOREIGN KEY([ScoreSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_Score] CHECK CONSTRAINT [FK_OM_Score_CMS_Site]
GO
