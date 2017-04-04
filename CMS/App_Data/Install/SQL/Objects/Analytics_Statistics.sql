SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Analytics_Statistics](
	[StatisticsID] [int] IDENTITY(1,1) NOT NULL,
	[StatisticsSiteID] [int] NULL,
	[StatisticsCode] [nvarchar](400) NOT NULL,
	[StatisticsObjectName] [nvarchar](450) NULL,
	[StatisticsObjectID] [int] NULL,
	[StatisticsObjectCulture] [nvarchar](10) NULL,
 CONSTRAINT [PK_Analytics_Statistics] PRIMARY KEY NONCLUSTERED 
(
	[StatisticsID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Analytics_Statistics_StatisticsCode_StatisticsSiteID_StatisticsObjectID_StatisticsObjectCulture] ON [dbo].[Analytics_Statistics]
(
	[StatisticsCode] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Analytics_Statistics_StatisticsSiteID] ON [dbo].[Analytics_Statistics]
(
	[StatisticsSiteID] ASC
)
GO
ALTER TABLE [dbo].[Analytics_Statistics] ADD  CONSTRAINT [DEFAULT_Analytics_Statistics_StatisticsCode]  DEFAULT ('') FOR [StatisticsCode]
GO
ALTER TABLE [dbo].[Analytics_Statistics] ADD  CONSTRAINT [DEFAULT_Analytics_Statistics_StatisticsObjectName]  DEFAULT (N'') FOR [StatisticsObjectName]
GO
ALTER TABLE [dbo].[Analytics_Statistics] ADD  CONSTRAINT [DEFAULT_Analytics_Statistics_StatisticsObjectCulture]  DEFAULT (N'') FOR [StatisticsObjectCulture]
GO
ALTER TABLE [dbo].[Analytics_Statistics]  WITH CHECK ADD  CONSTRAINT [FK_Analytics_Statistics_StatisticsSiteID_CMS_Site] FOREIGN KEY([StatisticsSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Analytics_Statistics] CHECK CONSTRAINT [FK_Analytics_Statistics_StatisticsSiteID_CMS_Site]
GO
