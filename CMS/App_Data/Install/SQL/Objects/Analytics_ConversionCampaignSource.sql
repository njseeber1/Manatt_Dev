SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Analytics_ConversionCampaignSource](
	[ConversionCampaignSourceID] [int] IDENTITY(1,1) NOT NULL,
	[CampaignID] [int] NOT NULL,
	[ConversionID] [int] NOT NULL,
	[SourceName] [nvarchar](200) NOT NULL,
	[ConversionHits] [int] NOT NULL,
 CONSTRAINT [PK_Analytics_ConversionCampaignSource] PRIMARY KEY CLUSTERED 
(
	[ConversionCampaignSourceID] ASC
)
)

GO
ALTER TABLE [dbo].[Analytics_ConversionCampaignSource] ADD  CONSTRAINT [DEFAULT_Analytics_ConversionCampaignSource_CampaignID]  DEFAULT ((0)) FOR [CampaignID]
GO
ALTER TABLE [dbo].[Analytics_ConversionCampaignSource] ADD  CONSTRAINT [DEFAULT_Analytics_ConversionCampaignSource_ConversionID]  DEFAULT ((0)) FOR [ConversionID]
GO
ALTER TABLE [dbo].[Analytics_ConversionCampaignSource] ADD  CONSTRAINT [DEFAULT_Analytics_ConversionCampaignSource_SourceName]  DEFAULT (N'') FOR [SourceName]
GO
ALTER TABLE [dbo].[Analytics_ConversionCampaignSource] ADD  CONSTRAINT [DEFAULT_Analytics_ConversionCampaignSource_ConversionHits]  DEFAULT ((0)) FOR [ConversionHits]
GO
