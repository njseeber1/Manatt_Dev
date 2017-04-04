SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_EventLog](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[EventType] [nvarchar](5) NOT NULL,
	[EventTime] [datetime2](7) NOT NULL,
	[Source] [nvarchar](100) NOT NULL,
	[EventCode] [nvarchar](100) NOT NULL,
	[UserID] [int] NULL,
	[UserName] [nvarchar](250) NULL,
	[IPAddress] [nvarchar](100) NULL,
	[NodeID] [int] NULL,
	[DocumentName] [nvarchar](100) NULL,
	[EventDescription] [nvarchar](max) NULL,
	[SiteID] [int] NULL,
	[EventUrl] [nvarchar](max) NULL,
	[EventMachineName] [nvarchar](100) NULL,
	[EventUserAgent] [nvarchar](max) NULL,
	[EventUrlReferrer] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_EventLog] PRIMARY KEY NONCLUSTERED 
(
	[EventID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_EventLog_EventTime] ON [dbo].[CMS_EventLog]
(
	[EventTime] DESC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_EventLog_EventID_SiteID] ON [dbo].[CMS_EventLog]
(
	[EventID] ASC
)
INCLUDE ( 	[SiteID])
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_EventLog_SiteID_EventType_Source_EventCode] ON [dbo].[CMS_EventLog]
(
	[SiteID] ASC,
	[EventType] ASC,
	[Source] ASC,
	[EventCode] ASC
)
GO
ALTER TABLE [dbo].[CMS_EventLog] ADD  CONSTRAINT [DEFAULT_CMS_EventLog_EventType]  DEFAULT (N'') FOR [EventType]
GO
ALTER TABLE [dbo].[CMS_EventLog] ADD  CONSTRAINT [DEFAULT_CMS_EventLog_EventTime]  DEFAULT ('4/21/2015 8:21:43 AM') FOR [EventTime]
GO
ALTER TABLE [dbo].[CMS_EventLog] ADD  CONSTRAINT [DEFAULT_CMS_EventLog_Source]  DEFAULT (N'') FOR [Source]
GO
ALTER TABLE [dbo].[CMS_EventLog] ADD  CONSTRAINT [DEFAULT_CMS_EventLog_EventCode]  DEFAULT (N'') FOR [EventCode]
GO
ALTER TABLE [dbo].[CMS_EventLog] ADD  CONSTRAINT [DEFAULT_CMS_EventLog_IPAddress]  DEFAULT (N'') FOR [IPAddress]
GO
ALTER TABLE [dbo].[CMS_EventLog] ADD  CONSTRAINT [DEFAULT_CMS_EventLog_DocumentName]  DEFAULT (N'') FOR [DocumentName]
GO
ALTER TABLE [dbo].[CMS_EventLog] ADD  CONSTRAINT [DEFAULT_CMS_EventLog_EventUrl]  DEFAULT (N'') FOR [EventUrl]
GO
ALTER TABLE [dbo].[CMS_EventLog] ADD  CONSTRAINT [DEFAULT_CMS_EventLog_EventMachineName]  DEFAULT (N'') FOR [EventMachineName]
GO
ALTER TABLE [dbo].[CMS_EventLog] ADD  CONSTRAINT [DEFAULT_CMS_EventLog_EventUrlReferrer]  DEFAULT (N'') FOR [EventUrlReferrer]
GO
ALTER TABLE [dbo].[CMS_EventLog]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Event_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_EventLog] CHECK CONSTRAINT [FK_CMS_Event_SiteID_CMS_Site]
GO
