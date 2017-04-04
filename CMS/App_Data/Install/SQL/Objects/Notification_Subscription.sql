SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification_Subscription](
	[SubscriptionID] [int] IDENTITY(1,1) NOT NULL,
	[SubscriptionGatewayID] [int] NOT NULL,
	[SubscriptionTemplateID] [int] NOT NULL,
	[SubscriptionEventSource] [nvarchar](100) NULL,
	[SubscriptionEventCode] [nvarchar](100) NULL,
	[SubscriptionEventDisplayName] [nvarchar](250) NOT NULL,
	[SubscriptionEventObjectID] [int] NULL,
	[SubscriptionTime] [datetime2](7) NOT NULL,
	[SubscriptionUserID] [int] NOT NULL,
	[SubscriptionTarget] [nvarchar](250) NOT NULL,
	[SubscriptionLastModified] [datetime2](7) NOT NULL,
	[SubscriptionGUID] [uniqueidentifier] NOT NULL,
	[SubscriptionEventData1] [nvarchar](max) NULL,
	[SubscriptionEventData2] [nvarchar](max) NULL,
	[SubscriptionUseHTML] [bit] NULL,
	[SubscriptionSiteID] [int] NULL,
 CONSTRAINT [PK_Notification_Subscription] PRIMARY KEY CLUSTERED 
(
	[SubscriptionID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Notification_Subscription_SubscriptionEventSource_SubscriptionEventCode_SubscriptionEventObjectID] ON [dbo].[Notification_Subscription]
(
	[SubscriptionEventSource] ASC,
	[SubscriptionEventCode] ASC,
	[SubscriptionEventObjectID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Notification_Subscription_SubscriptionGatewayID] ON [dbo].[Notification_Subscription]
(
	[SubscriptionGatewayID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Notification_Subscription_SubscriptionSiteID] ON [dbo].[Notification_Subscription]
(
	[SubscriptionSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Notification_Subscription_SubscriptionTemplateID] ON [dbo].[Notification_Subscription]
(
	[SubscriptionTemplateID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Notification_Subscription_SubscriptionUserID] ON [dbo].[Notification_Subscription]
(
	[SubscriptionUserID] ASC
)
GO
ALTER TABLE [dbo].[Notification_Subscription] ADD  CONSTRAINT [DEFAULT_Notification_Subscription_SubscriptionEventDisplayName]  DEFAULT ('') FOR [SubscriptionEventDisplayName]
GO
ALTER TABLE [dbo].[Notification_Subscription] ADD  CONSTRAINT [DEFAULT_Notification_Subscription_SubscriptionUseHTML]  DEFAULT ((0)) FOR [SubscriptionUseHTML]
GO
ALTER TABLE [dbo].[Notification_Subscription] ADD  CONSTRAINT [DEFAULT_Notification_Subscription_SubscriptionSiteID]  DEFAULT ((0)) FOR [SubscriptionSiteID]
GO
ALTER TABLE [dbo].[Notification_Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Subscription_SubscriptionGatewayID_Notification_Gateway] FOREIGN KEY([SubscriptionGatewayID])
REFERENCES [dbo].[Notification_Gateway] ([GatewayID])
GO
ALTER TABLE [dbo].[Notification_Subscription] CHECK CONSTRAINT [FK_Notification_Subscription_SubscriptionGatewayID_Notification_Gateway]
GO
ALTER TABLE [dbo].[Notification_Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Subscription_SubscriptionSiteID_CMS_Site] FOREIGN KEY([SubscriptionSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Notification_Subscription] CHECK CONSTRAINT [FK_Notification_Subscription_SubscriptionSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[Notification_Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Subscription_SubscriptionTemplateID_Notification_Template] FOREIGN KEY([SubscriptionTemplateID])
REFERENCES [dbo].[Notification_Template] ([TemplateID])
GO
ALTER TABLE [dbo].[Notification_Subscription] CHECK CONSTRAINT [FK_Notification_Subscription_SubscriptionTemplateID_Notification_Template]
GO
ALTER TABLE [dbo].[Notification_Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Subscription_SubscriptionUserID_CMS_User] FOREIGN KEY([SubscriptionUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Notification_Subscription] CHECK CONSTRAINT [FK_Notification_Subscription_SubscriptionUserID_CMS_User]
GO
