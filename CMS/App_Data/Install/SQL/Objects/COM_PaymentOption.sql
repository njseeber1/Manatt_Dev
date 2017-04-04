SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_PaymentOption](
	[PaymentOptionID] [int] IDENTITY(1,1) NOT NULL,
	[PaymentOptionName] [nvarchar](200) NOT NULL,
	[PaymentOptionDisplayName] [nvarchar](200) NOT NULL,
	[PaymentOptionEnabled] [bit] NOT NULL,
	[PaymentOptionSiteID] [int] NULL,
	[PaymentOptionPaymentGateUrl] [nvarchar](500) NULL,
	[PaymentOptionAssemblyName] [nvarchar](200) NULL,
	[PaymentOptionClassName] [nvarchar](200) NULL,
	[PaymentOptionSucceededOrderStatusID] [int] NULL,
	[PaymentOptionFailedOrderStatusID] [int] NULL,
	[PaymentOptionGUID] [uniqueidentifier] NOT NULL,
	[PaymentOptionLastModified] [datetime2](7) NOT NULL,
	[PaymentOptionAllowIfNoShipping] [bit] NULL,
	[PaymentOptionThumbnailGUID] [uniqueidentifier] NULL,
	[PaymentOptionDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_COM_PaymentOption] PRIMARY KEY NONCLUSTERED 
(
	[PaymentOptionID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_PaymentOption_PaymentOptionSiteID_PaymentOptionDisplayName_PaymentOptionEnabled] ON [dbo].[COM_PaymentOption]
(
	[PaymentOptionSiteID] ASC,
	[PaymentOptionDisplayName] ASC,
	[PaymentOptionEnabled] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_PaymentOption_PaymentOptionFailedOrderStatusID] ON [dbo].[COM_PaymentOption]
(
	[PaymentOptionFailedOrderStatusID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_PaymentOption_PaymentOptionSiteID] ON [dbo].[COM_PaymentOption]
(
	[PaymentOptionSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_PaymentOption_PaymentOptionSucceededOrderStatusID] ON [dbo].[COM_PaymentOption]
(
	[PaymentOptionSucceededOrderStatusID] ASC
)
GO
ALTER TABLE [dbo].[COM_PaymentOption] ADD  CONSTRAINT [DEFAULT_COM_PaymentOption_PaymentOptionName]  DEFAULT (N'') FOR [PaymentOptionName]
GO
ALTER TABLE [dbo].[COM_PaymentOption] ADD  CONSTRAINT [DEFAULT_COM_PaymentOption_PaymentOptionDisplayName]  DEFAULT (N'') FOR [PaymentOptionDisplayName]
GO
ALTER TABLE [dbo].[COM_PaymentOption] ADD  CONSTRAINT [DEFAULT_COM_PaymentOption_PaymentOptionEnabled]  DEFAULT ((1)) FOR [PaymentOptionEnabled]
GO
ALTER TABLE [dbo].[COM_PaymentOption] ADD  CONSTRAINT [DEFAULT_COM_PaymentOption_PaymentOptionGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [PaymentOptionGUID]
GO
ALTER TABLE [dbo].[COM_PaymentOption] ADD  CONSTRAINT [DEFAULT_COM_PaymentOption_PaymentOptionLastModified]  DEFAULT ('9/27/2012 4:18:26 PM') FOR [PaymentOptionLastModified]
GO
ALTER TABLE [dbo].[COM_PaymentOption] ADD  CONSTRAINT [DEFAULT_COM_PaymentOption_PaymentOptionAllowIfNoShipping]  DEFAULT ((0)) FOR [PaymentOptionAllowIfNoShipping]
GO
ALTER TABLE [dbo].[COM_PaymentOption]  WITH CHECK ADD  CONSTRAINT [FK_COM_PaymentOption_PaymentOptionFailedOrderStatusID_COM_OrderStatus] FOREIGN KEY([PaymentOptionFailedOrderStatusID])
REFERENCES [dbo].[COM_OrderStatus] ([StatusID])
GO
ALTER TABLE [dbo].[COM_PaymentOption] CHECK CONSTRAINT [FK_COM_PaymentOption_PaymentOptionFailedOrderStatusID_COM_OrderStatus]
GO
ALTER TABLE [dbo].[COM_PaymentOption]  WITH CHECK ADD  CONSTRAINT [FK_COM_PaymentOption_PaymentOptionSiteID_CMS_Site] FOREIGN KEY([PaymentOptionSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_PaymentOption] CHECK CONSTRAINT [FK_COM_PaymentOption_PaymentOptionSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[COM_PaymentOption]  WITH CHECK ADD  CONSTRAINT [FK_COM_PaymentOption_PaymentOptionSucceededOrderStatusID_COM_OrderStatus] FOREIGN KEY([PaymentOptionSucceededOrderStatusID])
REFERENCES [dbo].[COM_OrderStatus] ([StatusID])
GO
ALTER TABLE [dbo].[COM_PaymentOption] CHECK CONSTRAINT [FK_COM_PaymentOption_PaymentOptionSucceededOrderStatusID_COM_OrderStatus]
GO
