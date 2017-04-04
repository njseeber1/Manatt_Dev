SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Analytics_Campaign](
	[CampaignID] [int] IDENTITY(1,1) NOT NULL,
	[CampaignName] [nvarchar](200) NOT NULL,
	[CampaignDisplayName] [nvarchar](100) NOT NULL,
	[CampaignDescription] [nvarchar](max) NULL,
	[CampaignSiteID] [int] NOT NULL,
	[CampaignOpenFrom] [datetime2](7) NULL,
	[CampaignOpenTo] [datetime2](7) NULL,
	[CampaignGUID] [uniqueidentifier] NOT NULL,
	[CampaignLastModified] [datetime2](7) NOT NULL,
	[CampaignEnabled] [bit] NULL,
	[CampaignUTMCode] [nvarchar](200) NULL,
 CONSTRAINT [PK_Analytics_Campaign] PRIMARY KEY CLUSTERED 
(
	[CampaignID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Analytics_Campaign_CampaignSiteID] ON [dbo].[Analytics_Campaign]
(
	[CampaignSiteID] ASC
)
GO
ALTER TABLE [dbo].[Analytics_Campaign] ADD  CONSTRAINT [DEFAULT_Analytics_Campaign_CampaignName]  DEFAULT ('') FOR [CampaignName]
GO
ALTER TABLE [dbo].[Analytics_Campaign] ADD  CONSTRAINT [DEFAULT_Analytics_Campaign_CampaignDisplayName]  DEFAULT ('') FOR [CampaignDisplayName]
GO
ALTER TABLE [dbo].[Analytics_Campaign] ADD  CONSTRAINT [DEFAULT_Analytics_Campaign_CampaignEnabled]  DEFAULT ((1)) FOR [CampaignEnabled]
GO
ALTER TABLE [dbo].[Analytics_Campaign]  WITH CHECK ADD  CONSTRAINT [FK_Analytics_Campaign_StatisticsSiteID_CMS_Site] FOREIGN KEY([CampaignSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Analytics_Campaign] CHECK CONSTRAINT [FK_Analytics_Campaign_StatisticsSiteID_CMS_Site]
GO
