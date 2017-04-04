SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification_Gateway](
	[GatewayID] [int] IDENTITY(1,1) NOT NULL,
	[GatewayName] [nvarchar](200) NOT NULL,
	[GatewayDisplayName] [nvarchar](200) NOT NULL,
	[GatewayAssemblyName] [nvarchar](200) NOT NULL,
	[GatewayClassName] [nvarchar](200) NOT NULL,
	[GatewayDescription] [nvarchar](max) NULL,
	[GatewaySupportsEmail] [bit] NULL,
	[GatewaySupportsPlainText] [bit] NULL,
	[GatewaySupportsHTMLText] [bit] NULL,
	[GatewayLastModified] [datetime2](7) NOT NULL,
	[GatewayGUID] [uniqueidentifier] NOT NULL,
	[GatewayEnabled] [bit] NULL,
 CONSTRAINT [PK_Notification_Gateway] PRIMARY KEY NONCLUSTERED 
(
	[GatewayID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Notification_Gateway_GatewayDisplayName] ON [dbo].[Notification_Gateway]
(
	[GatewayDisplayName] ASC
)
GO
ALTER TABLE [dbo].[Notification_Gateway] ADD  CONSTRAINT [DEFAULT_Notification_Gateway_GatewayName]  DEFAULT ('') FOR [GatewayName]
GO
ALTER TABLE [dbo].[Notification_Gateway] ADD  CONSTRAINT [DEFAULT_Notification_Gateway_GatewayDisplayName]  DEFAULT ('') FOR [GatewayDisplayName]
GO
ALTER TABLE [dbo].[Notification_Gateway] ADD  CONSTRAINT [DEFAULT_Notification_Gateway_GatewayAssemblyName]  DEFAULT ('') FOR [GatewayAssemblyName]
GO
ALTER TABLE [dbo].[Notification_Gateway] ADD  CONSTRAINT [DEFAULT_Notification_Gateway_GatewayClassName]  DEFAULT ('') FOR [GatewayClassName]
GO
ALTER TABLE [dbo].[Notification_Gateway] ADD  CONSTRAINT [DEFAULT_Notification_Gateway_GatewaySupportsEmail]  DEFAULT ((0)) FOR [GatewaySupportsEmail]
GO
ALTER TABLE [dbo].[Notification_Gateway] ADD  CONSTRAINT [DEFAULT_Notification_Gateway_GatewaySupportsPlainText]  DEFAULT ((0)) FOR [GatewaySupportsPlainText]
GO
ALTER TABLE [dbo].[Notification_Gateway] ADD  CONSTRAINT [DEFAULT_Notification_Gateway_GatewaySupportsHTMLText]  DEFAULT ((0)) FOR [GatewaySupportsHTMLText]
GO
ALTER TABLE [dbo].[Notification_Gateway] ADD  CONSTRAINT [DEFAULT_Notification_Gateway_GatewayEnabled]  DEFAULT ((0)) FOR [GatewayEnabled]
GO
