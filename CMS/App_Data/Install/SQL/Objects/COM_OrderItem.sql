SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_OrderItem](
	[OrderItemID] [int] IDENTITY(1,1) NOT NULL,
	[OrderItemOrderID] [int] NOT NULL,
	[OrderItemSKUID] [int] NOT NULL,
	[OrderItemSKUName] [nvarchar](450) NOT NULL,
	[OrderItemUnitPrice] [float] NOT NULL,
	[OrderItemUnitCount] [int] NOT NULL,
	[OrderItemCustomData] [nvarchar](max) NULL,
	[OrderItemGuid] [uniqueidentifier] NOT NULL,
	[OrderItemParentGuid] [uniqueidentifier] NULL,
	[OrderItemLastModified] [datetime2](7) NOT NULL,
	[OrderItemIsPrivate] [bit] NULL,
	[OrderItemSKU] [nvarchar](max) NULL,
	[OrderItemValidTo] [datetime2](7) NULL,
	[OrderItemBundleGUID] [uniqueidentifier] NULL,
	[OrderItemTotalPriceInMainCurrency] [float] NULL,
	[OrderItemSendNotification] [bit] NULL,
	[OrderItemText] [nvarchar](max) NULL,
	[OrderItemPrice] [float] NULL,
	[OrderItemUnitTotalDiscountInMainCurrency] [float] NULL,
	[OrderItemUnitTotalTaxInMainCurrency] [float] NULL,
	[OrderItemProductDiscounts] [nvarchar](max) NULL,
 CONSTRAINT [PK_COM_OrderItem] PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_OrderItem_OrderItemOrderID] ON [dbo].[COM_OrderItem]
(
	[OrderItemOrderID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_OrderItem_OrderItemSKUID] ON [dbo].[COM_OrderItem]
(
	[OrderItemSKUID] ASC
)
GO
ALTER TABLE [dbo].[COM_OrderItem] ADD  CONSTRAINT [DEFAULT_COM_OrderItem_OrderItemGuid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [OrderItemGuid]
GO
ALTER TABLE [dbo].[COM_OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_COM_OrderItem_OrderItemOrderID_COM_Order] FOREIGN KEY([OrderItemOrderID])
REFERENCES [dbo].[COM_Order] ([OrderID])
GO
ALTER TABLE [dbo].[COM_OrderItem] CHECK CONSTRAINT [FK_COM_OrderItem_OrderItemOrderID_COM_Order]
GO
ALTER TABLE [dbo].[COM_OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_COM_OrderItem_OrderItemSKUID_COM_SKU] FOREIGN KEY([OrderItemSKUID])
REFERENCES [dbo].[COM_SKU] ([SKUID])
GO
ALTER TABLE [dbo].[COM_OrderItem] CHECK CONSTRAINT [FK_COM_OrderItem_OrderItemSKUID_COM_SKU]
GO
