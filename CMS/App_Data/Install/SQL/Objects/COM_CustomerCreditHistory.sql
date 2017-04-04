SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_CustomerCreditHistory](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [nvarchar](200) NOT NULL,
	[EventCreditChange] [float] NOT NULL,
	[EventDate] [datetime2](7) NOT NULL,
	[EventDescription] [nvarchar](max) NULL,
	[EventCustomerID] [int] NOT NULL,
	[EventCreditGUID] [uniqueidentifier] NULL,
	[EventCreditLastModified] [datetime2](7) NOT NULL,
	[EventSiteID] [int] NULL,
 CONSTRAINT [PK_COM_CustomerCreditHistory] PRIMARY KEY NONCLUSTERED 
(
	[EventID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_COM_CustomerCreditHistory_EventCustomerID_EventDate] ON [dbo].[COM_CustomerCreditHistory]
(
	[EventCustomerID] ASC,
	[EventDate] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_CustomerCreditHistory_EventCustomerID] ON [dbo].[COM_CustomerCreditHistory]
(
	[EventCustomerID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_CustomerCreditHistory_EventSiteID] ON [dbo].[COM_CustomerCreditHistory]
(
	[EventSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_CustomerCreditHistory] ADD  CONSTRAINT [DEFAULT_COM_CustomerCreditHistory_EventName]  DEFAULT ('') FOR [EventName]
GO
ALTER TABLE [dbo].[COM_CustomerCreditHistory] ADD  CONSTRAINT [DEFAULT_COM_CustomerCreditHistory_EventCreditChange]  DEFAULT ((0)) FOR [EventCreditChange]
GO
ALTER TABLE [dbo].[COM_CustomerCreditHistory] ADD  CONSTRAINT [DEFAULT_COM_CustomerCreditHistory_EventDate]  DEFAULT ('9/27/2012 2:48:56 PM') FOR [EventDate]
GO
ALTER TABLE [dbo].[COM_CustomerCreditHistory] ADD  CONSTRAINT [DEFAULT_COM_CustomerCreditHistory_EventCreditLastModified]  DEFAULT ('9/26/2012 12:21:38 PM') FOR [EventCreditLastModified]
GO
ALTER TABLE [dbo].[COM_CustomerCreditHistory]  WITH CHECK ADD  CONSTRAINT [FK_COM_CustomerCreditHistory_EventCustomerID_COM_Customer] FOREIGN KEY([EventCustomerID])
REFERENCES [dbo].[COM_Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[COM_CustomerCreditHistory] CHECK CONSTRAINT [FK_COM_CustomerCreditHistory_EventCustomerID_COM_Customer]
GO
ALTER TABLE [dbo].[COM_CustomerCreditHistory]  WITH CHECK ADD  CONSTRAINT [FK_COM_CustomerCreditHistory_EventSiteID_CMS_Site] FOREIGN KEY([EventSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_CustomerCreditHistory] CHECK CONSTRAINT [FK_COM_CustomerCreditHistory_EventSiteID_CMS_Site]
GO
