SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderBillingAddressID] [int] NOT NULL,
	[OrderShippingAddressID] [int] NULL,
	[OrderShippingOptionID] [int] NULL,
	[OrderTotalShipping] [float] NULL,
	[OrderTotalPrice] [float] NOT NULL,
	[OrderTotalTax] [float] NOT NULL,
	[OrderDate] [datetime2](7) NOT NULL,
	[OrderStatusID] [int] NULL,
	[OrderCurrencyID] [int] NULL,
	[OrderCustomerID] [int] NOT NULL,
	[OrderCreatedByUserID] [int] NULL,
	[OrderNote] [nvarchar](max) NULL,
	[OrderSiteID] [int] NOT NULL,
	[OrderPaymentOptionID] [int] NULL,
	[OrderInvoice] [nvarchar](max) NULL,
	[OrderInvoiceNumber] [nvarchar](200) NULL,
	[OrderDiscountCouponID] [int] NULL,
	[OrderCompanyAddressID] [int] NULL,
	[OrderTrackingNumber] [nvarchar](100) NULL,
	[OrderCustomData] [nvarchar](max) NULL,
	[OrderPaymentResult] [nvarchar](max) NULL,
	[OrderGUID] [uniqueidentifier] NOT NULL,
	[OrderLastModified] [datetime2](7) NOT NULL,
	[OrderTotalPriceInMainCurrency] [float] NULL,
	[OrderIsPaid] [bit] NULL,
	[OrderCulture] [nvarchar](10) NULL,
	[OrderCouponCode] [nvarchar](200) NULL,
	[OrderTotalDiscountInMainCurrency] [float] NULL,
	[OrderTotalShippingInMainCurrency] [float] NULL,
	[OrderTotalTaxInMainCurrency] [float] NULL,
	[OrderExchangeRate] [float] NULL,
	[OrderShippingTaxes] [nvarchar](max) NULL,
	[OrderDiscounts] [nvarchar](max) NULL,
 CONSTRAINT [PK_COM_Order] PRIMARY KEY NONCLUSTERED 
(
	[OrderID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_COM_Order_OrderSiteID_OrderDate] ON [dbo].[COM_Order]
(
	[OrderSiteID] ASC,
	[OrderDate] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Order_OrderBillingAddressID] ON [dbo].[COM_Order]
(
	[OrderBillingAddressID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Order_OrderCompanyAddressID] ON [dbo].[COM_Order]
(
	[OrderCompanyAddressID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Order_OrderCreatedByUserID] ON [dbo].[COM_Order]
(
	[OrderCreatedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Order_OrderCurrencyID] ON [dbo].[COM_Order]
(
	[OrderCurrencyID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Order_OrderCustomerID] ON [dbo].[COM_Order]
(
	[OrderCustomerID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Order_OrderDiscountCouponID] ON [dbo].[COM_Order]
(
	[OrderDiscountCouponID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Order_OrderPaymentOptionID] ON [dbo].[COM_Order]
(
	[OrderPaymentOptionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Order_OrderShippingAddressID] ON [dbo].[COM_Order]
(
	[OrderShippingAddressID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Order_OrderShippingOptionID] ON [dbo].[COM_Order]
(
	[OrderShippingOptionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Order_OrderSiteID] ON [dbo].[COM_Order]
(
	[OrderSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Order_OrderStatusID] ON [dbo].[COM_Order]
(
	[OrderStatusID] ASC
)
GO
ALTER TABLE [dbo].[COM_Order] ADD  CONSTRAINT [DEFAULT_COM_Order_OrderBillingAddressID]  DEFAULT ((0)) FOR [OrderBillingAddressID]
GO
ALTER TABLE [dbo].[COM_Order] ADD  CONSTRAINT [DEFAULT_COM_Order_OrderGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [OrderGUID]
GO
ALTER TABLE [dbo].[COM_Order]  WITH CHECK ADD  CONSTRAINT [FK_COM_Order_OrderBillingAddressID_COM_OrderAdress] FOREIGN KEY([OrderBillingAddressID])
REFERENCES [dbo].[COM_OrderAddress] ([AddressID])
GO
ALTER TABLE [dbo].[COM_Order] CHECK CONSTRAINT [FK_COM_Order_OrderBillingAddressID_COM_OrderAdress]
GO
ALTER TABLE [dbo].[COM_Order]  WITH CHECK ADD  CONSTRAINT [FK_COM_Order_OrderCompanyAddressID_COM_OrderAddress] FOREIGN KEY([OrderCompanyAddressID])
REFERENCES [dbo].[COM_OrderAddress] ([AddressID])
GO
ALTER TABLE [dbo].[COM_Order] CHECK CONSTRAINT [FK_COM_Order_OrderCompanyAddressID_COM_OrderAddress]
GO
ALTER TABLE [dbo].[COM_Order]  WITH CHECK ADD  CONSTRAINT [FK_COM_Order_OrderCreatedByUserID_CMS_User] FOREIGN KEY([OrderCreatedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[COM_Order] CHECK CONSTRAINT [FK_COM_Order_OrderCreatedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[COM_Order]  WITH CHECK ADD  CONSTRAINT [FK_COM_Order_OrderCurrencyID_COM_Currency] FOREIGN KEY([OrderCurrencyID])
REFERENCES [dbo].[COM_Currency] ([CurrencyID])
GO
ALTER TABLE [dbo].[COM_Order] CHECK CONSTRAINT [FK_COM_Order_OrderCurrencyID_COM_Currency]
GO
ALTER TABLE [dbo].[COM_Order]  WITH CHECK ADD  CONSTRAINT [FK_COM_Order_OrderCustomerID_COM_Customer] FOREIGN KEY([OrderCustomerID])
REFERENCES [dbo].[COM_Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[COM_Order] CHECK CONSTRAINT [FK_COM_Order_OrderCustomerID_COM_Customer]
GO
ALTER TABLE [dbo].[COM_Order]  WITH CHECK ADD  CONSTRAINT [FK_COM_Order_OrderDiscountCouponID_COM_DiscountCoupon] FOREIGN KEY([OrderDiscountCouponID])
REFERENCES [dbo].[COM_DiscountCoupon] ([DiscountCouponID])
GO
ALTER TABLE [dbo].[COM_Order] CHECK CONSTRAINT [FK_COM_Order_OrderDiscountCouponID_COM_DiscountCoupon]
GO
ALTER TABLE [dbo].[COM_Order]  WITH CHECK ADD  CONSTRAINT [FK_COM_Order_OrderPaymentOptionID_COM_PaymentOption] FOREIGN KEY([OrderPaymentOptionID])
REFERENCES [dbo].[COM_PaymentOption] ([PaymentOptionID])
GO
ALTER TABLE [dbo].[COM_Order] CHECK CONSTRAINT [FK_COM_Order_OrderPaymentOptionID_COM_PaymentOption]
GO
ALTER TABLE [dbo].[COM_Order]  WITH CHECK ADD  CONSTRAINT [FK_COM_Order_OrderShippingAddressID_COM_OrderAddress] FOREIGN KEY([OrderShippingAddressID])
REFERENCES [dbo].[COM_OrderAddress] ([AddressID])
GO
ALTER TABLE [dbo].[COM_Order] CHECK CONSTRAINT [FK_COM_Order_OrderShippingAddressID_COM_OrderAddress]
GO
ALTER TABLE [dbo].[COM_Order]  WITH CHECK ADD  CONSTRAINT [FK_COM_Order_OrderShippingOptionID_COM_ShippingOption] FOREIGN KEY([OrderShippingOptionID])
REFERENCES [dbo].[COM_ShippingOption] ([ShippingOptionID])
GO
ALTER TABLE [dbo].[COM_Order] CHECK CONSTRAINT [FK_COM_Order_OrderShippingOptionID_COM_ShippingOption]
GO
ALTER TABLE [dbo].[COM_Order]  WITH CHECK ADD  CONSTRAINT [FK_COM_Order_OrderSiteID_CMS_Site] FOREIGN KEY([OrderSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_Order] CHECK CONSTRAINT [FK_COM_Order_OrderSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[COM_Order]  WITH CHECK ADD  CONSTRAINT [FK_COM_Order_OrderStatusID_COM_Status] FOREIGN KEY([OrderStatusID])
REFERENCES [dbo].[COM_OrderStatus] ([StatusID])
GO
ALTER TABLE [dbo].[COM_Order] CHECK CONSTRAINT [FK_COM_Order_OrderStatusID_COM_Status]
GO
