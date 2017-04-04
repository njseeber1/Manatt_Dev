SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_Subscriber](
	[SubscriberID] [int] IDENTITY(1,1) NOT NULL,
	[SubscriberEmail] [nvarchar](400) NULL,
	[SubscriberFirstName] [nvarchar](200) NULL,
	[SubscriberLastName] [nvarchar](200) NULL,
	[SubscriberSiteID] [int] NOT NULL,
	[SubscriberGUID] [uniqueidentifier] NOT NULL,
	[SubscriberCustomData] [nvarchar](max) NULL,
	[SubscriberType] [nvarchar](100) NULL,
	[SubscriberRelatedID] [int] NULL,
	[SubscriberLastModified] [datetime2](7) NOT NULL,
	[SubscriberFullName] [nvarchar](440) NULL,
	[SubscriberBounces] [int] NULL,
 CONSTRAINT [PK_Newsletter_Subscriber] PRIMARY KEY NONCLUSTERED 
(
	[SubscriberID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Newsletter_Subscriber_SubscriberSiteID_SubscriberFullName] ON [dbo].[Newsletter_Subscriber]
(
	[SubscriberSiteID] ASC,
	[SubscriberFullName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Subscriber_SubscriberEmail] ON [dbo].[Newsletter_Subscriber]
(
	[SubscriberEmail] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Subscriber_SubscriberType_SubscriberRelatedID] ON [dbo].[Newsletter_Subscriber]
(
	[SubscriberType] ASC,
	[SubscriberRelatedID] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_Subscriber] ADD  CONSTRAINT [DEFAULT_Newsletter_Subscriber_SubscriberSiteID]  DEFAULT ((0)) FOR [SubscriberSiteID]
GO
ALTER TABLE [dbo].[Newsletter_Subscriber] ADD  CONSTRAINT [DEFAULT_Newsletter_Subscriber_SubscriberGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [SubscriberGUID]
GO
ALTER TABLE [dbo].[Newsletter_Subscriber] ADD  CONSTRAINT [DEFAULT_Newsletter_Subscriber_SubscriberType]  DEFAULT (N'') FOR [SubscriberType]
GO
ALTER TABLE [dbo].[Newsletter_Subscriber]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_Subscriber_SubscriberSiteID_CMS_Site] FOREIGN KEY([SubscriberSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Newsletter_Subscriber] CHECK CONSTRAINT [FK_Newsletter_Subscriber_SubscriberSiteID_CMS_Site]
GO
