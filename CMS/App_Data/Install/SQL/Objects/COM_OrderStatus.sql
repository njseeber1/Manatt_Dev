SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_OrderStatus](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](200) NOT NULL,
	[StatusDisplayName] [nvarchar](200) NOT NULL,
	[StatusOrder] [int] NULL,
	[StatusEnabled] [bit] NOT NULL,
	[StatusColor] [nvarchar](7) NULL,
	[StatusGUID] [uniqueidentifier] NOT NULL,
	[StatusLastModified] [datetime2](7) NOT NULL,
	[StatusSendNotification] [bit] NULL,
	[StatusSiteID] [int] NULL,
	[StatusOrderIsPaid] [bit] NULL,
 CONSTRAINT [PK_COM_OrderStatus] PRIMARY KEY NONCLUSTERED 
(
	[StatusID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_OrderStatus_StatusOrder_StatusDisplayName_StatusEnabled] ON [dbo].[COM_OrderStatus]
(
	[StatusOrder] ASC,
	[StatusDisplayName] ASC,
	[StatusEnabled] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_OrderStatus_StatusSiteID] ON [dbo].[COM_OrderStatus]
(
	[StatusSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_OrderStatus] ADD  CONSTRAINT [DEFAULT_COM_OrderStatus_StatusName]  DEFAULT (N'') FOR [StatusName]
GO
ALTER TABLE [dbo].[COM_OrderStatus] ADD  CONSTRAINT [DEFAULT_COM_OrderStatus_StatusDisplayName]  DEFAULT (N'') FOR [StatusDisplayName]
GO
ALTER TABLE [dbo].[COM_OrderStatus] ADD  CONSTRAINT [DEFAULT_COM_OrderStatus_StatusEnabled]  DEFAULT ((1)) FOR [StatusEnabled]
GO
ALTER TABLE [dbo].[COM_OrderStatus] ADD  CONSTRAINT [DEFAULT_COM_OrderStatus_StatusGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [StatusGUID]
GO
ALTER TABLE [dbo].[COM_OrderStatus] ADD  CONSTRAINT [DEFAULT_COM_OrderStatus_StatusSendNotification]  DEFAULT ((0)) FOR [StatusSendNotification]
GO
ALTER TABLE [dbo].[COM_OrderStatus]  WITH CHECK ADD  CONSTRAINT [FK_COM_OrderStatus_StatusSiteID_CMS_Site] FOREIGN KEY([StatusSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_OrderStatus] CHECK CONSTRAINT [FK_COM_OrderStatus_StatusSiteID_CMS_Site]
GO
