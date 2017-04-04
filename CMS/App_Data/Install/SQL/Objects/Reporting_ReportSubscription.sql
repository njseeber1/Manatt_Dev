SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporting_ReportSubscription](
	[ReportSubscriptionID] [int] IDENTITY(1,1) NOT NULL,
	[ReportSubscriptionReportID] [int] NOT NULL,
	[ReportSubscriptionInterval] [nvarchar](1000) NOT NULL,
	[ReportSubscriptionCondition] [nvarchar](max) NULL,
	[ReportSubscriptionEnabled] [bit] NOT NULL,
	[ReportSubscriptionParameters] [nvarchar](max) NULL,
	[ReportSubscriptionGUID] [uniqueidentifier] NOT NULL,
	[ReportSubscriptionLastModified] [datetime2](7) NOT NULL,
	[ReportSubscriptionSubject] [nvarchar](200) NULL,
	[ReportSubscriptionGraphID] [int] NULL,
	[ReportSubscriptionTableID] [int] NULL,
	[ReportSubscriptionValueID] [int] NULL,
	[ReportSubscriptionUserID] [int] NOT NULL,
	[ReportSubscriptionEmail] [nvarchar](400) NOT NULL,
	[ReportSubscriptionOnlyNonEmpty] [bit] NOT NULL,
	[ReportSubscriptionLastPostDate] [datetime2](7) NULL,
	[ReportSubscriptionNextPostDate] [datetime2](7) NULL,
	[ReportSubscriptionSiteID] [int] NOT NULL,
	[ReportSubscriptionSettings] [nvarchar](max) NULL,
 CONSTRAINT [PK_Reporting_ReportSubscription] PRIMARY KEY CLUSTERED 
(
	[ReportSubscriptionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Reporting_ReportSubscription_ReportSubscriptionGraphID] ON [dbo].[Reporting_ReportSubscription]
(
	[ReportSubscriptionGraphID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Reporting_ReportSubscription_ReportSubscriptionReportID] ON [dbo].[Reporting_ReportSubscription]
(
	[ReportSubscriptionReportID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Reporting_ReportSubscription_ReportSubscriptionSiteID] ON [dbo].[Reporting_ReportSubscription]
(
	[ReportSubscriptionSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Reporting_ReportSubscription_ReportSubscriptionTableID] ON [dbo].[Reporting_ReportSubscription]
(
	[ReportSubscriptionTableID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Reporting_ReportSubscription_ReportSubscriptionUserID] ON [dbo].[Reporting_ReportSubscription]
(
	[ReportSubscriptionUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Reporting_ReportSubscription_ReportSubscriptionValueID] ON [dbo].[Reporting_ReportSubscription]
(
	[ReportSubscriptionValueID] ASC
)
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription] ADD  CONSTRAINT [DEFAULT_Reporting_ReportSubscription_ReportSubscriptionInterval]  DEFAULT ('') FOR [ReportSubscriptionInterval]
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription] ADD  CONSTRAINT [DEFAULT_Reporting_ReportSubscription_ReportSubscriptionEnabled]  DEFAULT ((1)) FOR [ReportSubscriptionEnabled]
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription] ADD  CONSTRAINT [DEFAULT_Reporting_ReportSubscription_ReportSubscriptionLastModified]  DEFAULT ('3/9/2012 11:17:19 AM') FOR [ReportSubscriptionLastModified]
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription] ADD  CONSTRAINT [DEFAULT_Reporting_ReportSubscription_ReportSubscriptionOnlyNonEmpty]  DEFAULT ((1)) FOR [ReportSubscriptionOnlyNonEmpty]
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription]  WITH CHECK ADD  CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionGraphID_Reporting_ReportGraph] FOREIGN KEY([ReportSubscriptionGraphID])
REFERENCES [dbo].[Reporting_ReportGraph] ([GraphID])
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription] CHECK CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionGraphID_Reporting_ReportGraph]
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription]  WITH CHECK ADD  CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionReportID_Reporting_Report] FOREIGN KEY([ReportSubscriptionReportID])
REFERENCES [dbo].[Reporting_Report] ([ReportID])
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription] CHECK CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionReportID_Reporting_Report]
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription]  WITH CHECK ADD  CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionSiteID_CMS_Site] FOREIGN KEY([ReportSubscriptionSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription] CHECK CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription]  WITH CHECK ADD  CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionTableID_Reporting_ReportTable] FOREIGN KEY([ReportSubscriptionTableID])
REFERENCES [dbo].[Reporting_ReportTable] ([TableID])
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription] CHECK CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionTableID_Reporting_ReportTable]
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription]  WITH CHECK ADD  CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionUserID_CMS_User] FOREIGN KEY([ReportSubscriptionUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription] CHECK CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionUserID_CMS_User]
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription]  WITH CHECK ADD  CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionValueID_Reporting_ReportValue] FOREIGN KEY([ReportSubscriptionValueID])
REFERENCES [dbo].[Reporting_ReportValue] ([ValueID])
GO
ALTER TABLE [dbo].[Reporting_ReportSubscription] CHECK CONSTRAINT [FK_Reporting_ReportSubscription_ReportSubscriptionValueID_Reporting_ReportValue]
GO
