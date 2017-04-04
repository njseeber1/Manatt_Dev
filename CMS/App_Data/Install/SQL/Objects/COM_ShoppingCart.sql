SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_ShoppingCart](
	[ShoppingCartID] [int] IDENTITY(1,1) NOT NULL,
	[ShoppingCartGUID] [uniqueidentifier] NOT NULL,
	[ShoppingCartUserID] [int] NULL,
	[ShoppingCartSiteID] [int] NOT NULL,
	[ShoppingCartLastUpdate] [datetime2](7) NOT NULL,
	[ShoppingCartCurrencyID] [int] NULL,
	[ShoppingCartPaymentOptionID] [int] NULL,
	[ShoppingCartShippingOptionID] [int] NULL,
	[ShoppingCartDiscountCouponID] [int] NULL,
	[ShoppingCartBillingAddressID] [int] NULL,
	[ShoppingCartShippingAddressID] [int] NULL,
	[ShoppingCartCustomerID] [int] NULL,
	[ShoppingCartNote] [nvarchar](max) NULL,
	[ShoppingCartCompanyAddressID] [int] NULL,
	[ShoppingCartCustomData] [nvarchar](max) NULL,
	[ShoppingCartCouponCode] [nvarchar](200) NULL,
	[ShoppingCartContactID] [int] NULL,
 CONSTRAINT [PK_COM_ShoppingCart] PRIMARY KEY CLUSTERED 
(
	[ShoppingCartID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartBillingAddressID] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartBillingAddressID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartCompanyAddressID] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartCompanyAddressID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartCurrencyID] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartCurrencyID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartCustomerID] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartCustomerID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartDiscountCouponID] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartDiscountCouponID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartLastUpdate] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartLastUpdate] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartPaymentOptionID] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartPaymentOptionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartShippingAddressID] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartShippingAddressID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartShippingOptionID] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartShippingOptionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartSiteID] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartSiteID_ShoppingCartGUID] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartGUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCart_ShoppingCartUserID] ON [dbo].[COM_ShoppingCart]
(
	[ShoppingCartUserID] ASC
)
GO
ALTER TABLE [dbo].[COM_ShoppingCart] ADD  CONSTRAINT [DEFAULT_COM_ShoppingCart_ShoppingCartGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ShoppingCartGUID]
GO
ALTER TABLE [dbo].[COM_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartBillingAddressID_COM_Address] FOREIGN KEY([ShoppingCartBillingAddressID])
REFERENCES [dbo].[COM_Address] ([AddressID])
GO
ALTER TABLE [dbo].[COM_ShoppingCart] CHECK CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartBillingAddressID_COM_Address]
GO
ALTER TABLE [dbo].[COM_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartCompanyAddressID_COM_Address] FOREIGN KEY([ShoppingCartCompanyAddressID])
REFERENCES [dbo].[COM_Address] ([AddressID])
GO
ALTER TABLE [dbo].[COM_ShoppingCart] CHECK CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartCompanyAddressID_COM_Address]
GO
ALTER TABLE [dbo].[COM_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartCurrencyID_COM_Currency] FOREIGN KEY([ShoppingCartCurrencyID])
REFERENCES [dbo].[COM_Currency] ([CurrencyID])
GO
ALTER TABLE [dbo].[COM_ShoppingCart] CHECK CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartCurrencyID_COM_Currency]
GO
ALTER TABLE [dbo].[COM_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartCustomerID_COM_Customer] FOREIGN KEY([ShoppingCartCustomerID])
REFERENCES [dbo].[COM_Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[COM_ShoppingCart] CHECK CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartCustomerID_COM_Customer]
GO
ALTER TABLE [dbo].[COM_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartDiscountCouponID_COM_DiscountCoupon] FOREIGN KEY([ShoppingCartDiscountCouponID])
REFERENCES [dbo].[COM_DiscountCoupon] ([DiscountCouponID])
GO
ALTER TABLE [dbo].[COM_ShoppingCart] CHECK CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartDiscountCouponID_COM_DiscountCoupon]
GO
ALTER TABLE [dbo].[COM_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartPaymentOptionID_COM_PaymentOption] FOREIGN KEY([ShoppingCartPaymentOptionID])
REFERENCES [dbo].[COM_PaymentOption] ([PaymentOptionID])
GO
ALTER TABLE [dbo].[COM_ShoppingCart] CHECK CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartPaymentOptionID_COM_PaymentOption]
GO
ALTER TABLE [dbo].[COM_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartShippingAddressID_COM_Address] FOREIGN KEY([ShoppingCartShippingAddressID])
REFERENCES [dbo].[COM_Address] ([AddressID])
GO
ALTER TABLE [dbo].[COM_ShoppingCart] CHECK CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartShippingAddressID_COM_Address]
GO
ALTER TABLE [dbo].[COM_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartShippingOptionID_COM_ShippingOption] FOREIGN KEY([ShoppingCartShippingOptionID])
REFERENCES [dbo].[COM_ShippingOption] ([ShippingOptionID])
GO
ALTER TABLE [dbo].[COM_ShoppingCart] CHECK CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartShippingOptionID_COM_ShippingOption]
GO
ALTER TABLE [dbo].[COM_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartSiteID_CMS_Site] FOREIGN KEY([ShoppingCartSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_ShoppingCart] CHECK CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[COM_ShoppingCart]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartUserID_CMS_User] FOREIGN KEY([ShoppingCartUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[COM_ShoppingCart] CHECK CONSTRAINT [FK_COM_ShoppingCart_ShoppingCartUserID_CMS_User]
GO
