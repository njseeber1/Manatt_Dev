SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SM_Insight](
	[InsightID] [int] IDENTITY(1,1) NOT NULL,
	[InsightCodeName] [nvarchar](200) NOT NULL,
	[InsightExternalID] [nvarchar](max) NOT NULL,
	[InsightPeriodType] [nvarchar](20) NOT NULL,
	[InsightValueName] [nvarchar](max) NULL,
 CONSTRAINT [PK_SM_Insight] PRIMARY KEY CLUSTERED 
(
	[InsightID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_SM_Insight_InsightCodeName_InsightPeriodType] ON [dbo].[SM_Insight]
(
	[InsightCodeName] ASC,
	[InsightPeriodType] ASC
)
GO
ALTER TABLE [dbo].[SM_Insight] ADD  CONSTRAINT [DEFAULT_SM_Insight_InsightExternalID]  DEFAULT ('') FOR [InsightExternalID]
GO
