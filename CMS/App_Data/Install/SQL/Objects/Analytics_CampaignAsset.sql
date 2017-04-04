SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Analytics_CampaignAsset](
	[CampaignAssetID] [int] IDENTITY(1,1) NOT NULL,
	[CampaignAssetGuid] [uniqueidentifier] NOT NULL,
	[CampaignAssetLastModified] [datetime2](0) NOT NULL,
	[CampaignAssetAssetGuid] [uniqueidentifier] NOT NULL,
	[CampaignAssetCampaignID] [int] NOT NULL,
	[CampaignAssetType] [nvarchar](200) NOT NULL,
	[CampaignAssetSiteName] [nvarchar](200) NULL,
 CONSTRAINT [PK_Analytics_CampaignAsset] PRIMARY KEY CLUSTERED 
(
	[CampaignAssetID] ASC
)
)

GO
ALTER TABLE [dbo].[Analytics_CampaignAsset] ADD  CONSTRAINT [DEFAULT_Analytics_CampaignAsset_CampaignAssetGuid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CampaignAssetGuid]
GO
ALTER TABLE [dbo].[Analytics_CampaignAsset] ADD  CONSTRAINT [DEFAULT_Analytics_CampaignAsset_CampaignAssetLastModified]  DEFAULT ('1/1/0001 12:00:00 AM') FOR [CampaignAssetLastModified]
GO
ALTER TABLE [dbo].[Analytics_CampaignAsset] ADD  CONSTRAINT [DEFAULT_Analytics_CampaignAsset_CampaignAssetAssetGuid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CampaignAssetAssetGuid]
GO
ALTER TABLE [dbo].[Analytics_CampaignAsset] ADD  CONSTRAINT [DEFAULT_Analytics_CampaignAsset_CampaignAssetCampaignID]  DEFAULT ((0)) FOR [CampaignAssetCampaignID]
GO
ALTER TABLE [dbo].[Analytics_CampaignAsset] ADD  CONSTRAINT [DEFAULT_Analytics_CampaignAsset_CampaignAssetType]  DEFAULT (N'') FOR [CampaignAssetType]
GO
