SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_ShoppingCartSKU](
	[CartItemID] [int] IDENTITY(1,1) NOT NULL,
	[ShoppingCartID] [int] NOT NULL,
	[SKUID] [int] NOT NULL,
	[SKUUnits] [int] NOT NULL,
	[CartItemCustomData] [nvarchar](max) NULL,
	[CartItemGuid] [uniqueidentifier] NULL,
	[CartItemParentGuid] [uniqueidentifier] NULL,
	[CartItemPrice] [float] NULL,
	[CartItemIsPrivate] [bit] NULL,
	[CartItemValidTo] [datetime2](7) NULL,
	[CartItemBundleGUID] [uniqueidentifier] NULL,
	[CartItemText] [nvarchar](max) NULL,
	[CartItemAutoAddedUnits] [int] NULL,
 CONSTRAINT [PK_COM_ShoppingCartSKU] PRIMARY KEY CLUSTERED 
(
	[CartItemID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCartSKU_ShoppingCartID] ON [dbo].[COM_ShoppingCartSKU]
(
	[ShoppingCartID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCartSKU_SKUID] ON [dbo].[COM_ShoppingCartSKU]
(
	[SKUID] ASC
)
GO
ALTER TABLE [dbo].[COM_ShoppingCartSKU] ADD  CONSTRAINT [DEFAULT_COM_ShoppingCartSKU_CartItemAutoAddedUnits]  DEFAULT ((0)) FOR [CartItemAutoAddedUnits]
GO
ALTER TABLE [dbo].[COM_ShoppingCartSKU]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCartSKU_ShoppingCartID_COM_ShoppingCart] FOREIGN KEY([ShoppingCartID])
REFERENCES [dbo].[COM_ShoppingCart] ([ShoppingCartID])
GO
ALTER TABLE [dbo].[COM_ShoppingCartSKU] CHECK CONSTRAINT [FK_COM_ShoppingCartSKU_ShoppingCartID_COM_ShoppingCart]
GO
ALTER TABLE [dbo].[COM_ShoppingCartSKU]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShoppingCartSKU_SKUID_COM_SKU] FOREIGN KEY([SKUID])
REFERENCES [dbo].[COM_SKU] ([SKUID])
GO
ALTER TABLE [dbo].[COM_ShoppingCartSKU] CHECK CONSTRAINT [FK_COM_ShoppingCartSKU_SKUID_COM_SKU]
GO
