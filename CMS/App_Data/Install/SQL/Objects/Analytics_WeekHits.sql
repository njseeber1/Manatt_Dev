SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Analytics_WeekHits](
	[HitsID] [int] IDENTITY(1,1) NOT NULL,
	[HitsStatisticsID] [int] NOT NULL,
	[HitsStartTime] [datetime2](7) NOT NULL,
	[HitsEndTime] [datetime2](7) NOT NULL,
	[HitsCount] [int] NOT NULL,
	[HitsValue] [float] NULL,
 CONSTRAINT [PK_Analytics_WeekHits] PRIMARY KEY NONCLUSTERED 
(
	[HitsID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_Analytics_WeekHits_HitsStartTime_HitsEndTime] ON [dbo].[Analytics_WeekHits]
(
	[HitsStartTime] DESC,
	[HitsEndTime] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_Analytics_WeekHits_HitsStatisticsID] ON [dbo].[Analytics_WeekHits]
(
	[HitsStatisticsID] ASC
)
GO
ALTER TABLE [dbo].[Analytics_WeekHits]  WITH CHECK ADD  CONSTRAINT [FK_Analytics_WeekHits_HitsStatisticsID_Analytics_Statistics] FOREIGN KEY([HitsStatisticsID])
REFERENCES [dbo].[Analytics_Statistics] ([StatisticsID])
GO
ALTER TABLE [dbo].[Analytics_WeekHits] CHECK CONSTRAINT [FK_Analytics_WeekHits_HitsStatisticsID_Analytics_Statistics]
GO
