SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Analytics_MonthHits](
	[HitsID] [int] IDENTITY(1,1) NOT NULL,
	[HitsStatisticsID] [int] NOT NULL,
	[HitsStartTime] [datetime2](7) NOT NULL,
	[HitsEndTime] [datetime2](7) NOT NULL,
	[HitsCount] [int] NOT NULL,
	[HitsValue] [float] NULL,
 CONSTRAINT [PK_Analytics_MonthHits] PRIMARY KEY NONCLUSTERED 
(
	[HitsID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_Analytics_MonthHits_HitsStartTime_HitsEndTime] ON [dbo].[Analytics_MonthHits]
(
	[HitsStartTime] DESC,
	[HitsEndTime] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_Analytics_MonthHits_HitsStatisticsID] ON [dbo].[Analytics_MonthHits]
(
	[HitsStatisticsID] ASC
)
GO
ALTER TABLE [dbo].[Analytics_MonthHits]  WITH CHECK ADD  CONSTRAINT [FK_Analytics_MonthHits_HitsStatisticsID_Analytics_Statistics] FOREIGN KEY([HitsStatisticsID])
REFERENCES [dbo].[Analytics_Statistics] ([StatisticsID])
GO
ALTER TABLE [dbo].[Analytics_MonthHits] CHECK CONSTRAINT [FK_Analytics_MonthHits_HitsStatisticsID_Analytics_Statistics]
GO
