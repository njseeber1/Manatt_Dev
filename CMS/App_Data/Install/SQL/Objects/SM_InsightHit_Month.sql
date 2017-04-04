SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SM_InsightHit_Month](
	[InsightHitID] [int] IDENTITY(1,1) NOT NULL,
	[InsightHitPeriodFrom] [datetime2](7) NOT NULL,
	[InsightHitPeriodTo] [datetime2](7) NOT NULL,
	[InsightHitValue] [bigint] NOT NULL,
	[InsightHitInsightID] [int] NOT NULL,
 CONSTRAINT [PK_SM_InsightHit_Month] PRIMARY KEY CLUSTERED 
(
	[InsightHitID] ASC
)
)

GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_SM_InsightHit_Month_InsightHitInsightID_InsightHitPeriodFrom_InsightHitPeriodTo] ON [dbo].[SM_InsightHit_Month]
(
	[InsightHitInsightID] ASC,
	[InsightHitPeriodFrom] ASC,
	[InsightHitPeriodTo] ASC
)
GO
ALTER TABLE [dbo].[SM_InsightHit_Month]  WITH CHECK ADD  CONSTRAINT [FK_SM_InsightHit_Month_SM_Insight_InsightHitInsightID] FOREIGN KEY([InsightHitInsightID])
REFERENCES [dbo].[SM_Insight] ([InsightID])
GO
ALTER TABLE [dbo].[SM_InsightHit_Month] CHECK CONSTRAINT [FK_SM_InsightHit_Month_SM_Insight_InsightHitInsightID]
GO
