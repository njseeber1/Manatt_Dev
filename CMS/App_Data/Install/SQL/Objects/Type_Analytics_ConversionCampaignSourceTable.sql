CREATE TYPE [dbo].[Type_Analytics_ConversionCampaignSourceTable] AS TABLE(
	[CampaignID] [int] NULL,
	[ConversionID] [int] NULL,
	[SourceName] [nvarchar](200) NULL,
	[ConversionHits] [int] NULL
)
GO
