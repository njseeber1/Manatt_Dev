SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SM_LinkedInPost](
	[LinkedInPostID] [int] IDENTITY(1,1) NOT NULL,
	[LinkedInPostLinkedInAccountID] [int] NOT NULL,
	[LinkedInPostComment] [nvarchar](700) NOT NULL,
	[LinkedInPostSiteID] [int] NOT NULL,
	[LinkedInPostGUID] [uniqueidentifier] NOT NULL,
	[LinkedInPostLastModified] [datetime2](7) NULL,
	[LinkedInPostUpdateKey] [nvarchar](200) NULL,
	[LinkedInPostURLShortenerType] [int] NULL,
	[LinkedInPostScheduledPublishDateTime] [datetime2](7) NULL,
	[LinkedInPostCampaignID] [int] NULL,
	[LinkedInPostPublishedDateTime] [datetime2](7) NULL,
	[LinkedInPostHTTPStatusCode] [int] NULL,
	[LinkedInPostErrorCode] [int] NULL,
	[LinkedInPostErrorMessage] [nvarchar](max) NULL,
	[LinkedInPostDocumentGUID] [uniqueidentifier] NULL,
	[LinkedInPostIsCreatedByUser] [bit] NULL,
	[LinkedInPostPostAfterDocumentPublish] [bit] NULL,
	[LinkedInPostInsightsLastUpdated] [datetime2](7) NULL,
	[LinkedInPostCommentCount] [int] NULL,
	[LinkedInPostImpressionCount] [int] NULL,
	[LinkedInPostLikeCount] [int] NULL,
	[LinkedInPostShareCount] [int] NULL,
	[LinkedInPostClickCount] [int] NULL,
	[LinkedInPostEngagement] [float] NULL,
 CONSTRAINT [PK_SM_LinkedInPost] PRIMARY KEY CLUSTERED 
(
	[LinkedInPostID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_SM_LinkedInPost_LinkedInPostCampaignID] ON [dbo].[SM_LinkedInPost]
(
	[LinkedInPostCampaignID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_SM_LinkedInPost_LinkedInPostLinkedInAccountID] ON [dbo].[SM_LinkedInPost]
(
	[LinkedInPostLinkedInAccountID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_SM_LinkedInPost_LinkedInPostSiteID] ON [dbo].[SM_LinkedInPost]
(
	[LinkedInPostSiteID] ASC
)
GO
ALTER TABLE [dbo].[SM_LinkedInPost] ADD  CONSTRAINT [DEFAULT_SM_LinkedInPost_LinkedInPostLinkedInAccountID]  DEFAULT ((0)) FOR [LinkedInPostLinkedInAccountID]
GO
ALTER TABLE [dbo].[SM_LinkedInPost] ADD  CONSTRAINT [DEFAULT_SM_LinkedInPost_LinkedInPostComment]  DEFAULT (N'') FOR [LinkedInPostComment]
GO
ALTER TABLE [dbo].[SM_LinkedInPost] ADD  CONSTRAINT [DEFAULT_SM_LinkedInPost_LinkedInPostSiteID]  DEFAULT ((0)) FOR [LinkedInPostSiteID]
GO
ALTER TABLE [dbo].[SM_LinkedInPost] ADD  CONSTRAINT [DEFAULT_SM_LinkedInPost_LinkedInPostGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [LinkedInPostGUID]
GO
ALTER TABLE [dbo].[SM_LinkedInPost] ADD  CONSTRAINT [DEFAULT_SM_LinkedInPost_LinkedInPostIsCreatedByUser]  DEFAULT ((1)) FOR [LinkedInPostIsCreatedByUser]
GO
ALTER TABLE [dbo].[SM_LinkedInPost]  WITH CHECK ADD  CONSTRAINT [FK_SM_LinkedInPost_Analytics_Campaign_LinkedInPostCampaignID] FOREIGN KEY([LinkedInPostCampaignID])
REFERENCES [dbo].[Analytics_Campaign] ([CampaignID])
GO
ALTER TABLE [dbo].[SM_LinkedInPost] CHECK CONSTRAINT [FK_SM_LinkedInPost_Analytics_Campaign_LinkedInPostCampaignID]
GO
ALTER TABLE [dbo].[SM_LinkedInPost]  WITH CHECK ADD  CONSTRAINT [FK_SM_LinkedInPost_CMS_Site] FOREIGN KEY([LinkedInPostSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[SM_LinkedInPost] CHECK CONSTRAINT [FK_SM_LinkedInPost_CMS_Site]
GO
ALTER TABLE [dbo].[SM_LinkedInPost]  WITH CHECK ADD  CONSTRAINT [FK_SM_LinkedInPost_SM_LinkedInAccount] FOREIGN KEY([LinkedInPostLinkedInAccountID])
REFERENCES [dbo].[SM_LinkedInAccount] ([LinkedInAccountID])
GO
ALTER TABLE [dbo].[SM_LinkedInPost] CHECK CONSTRAINT [FK_SM_LinkedInPost_SM_LinkedInAccount]
GO
