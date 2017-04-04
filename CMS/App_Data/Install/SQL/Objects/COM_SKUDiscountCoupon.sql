SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_SKUDiscountCoupon](
	[SKUID] [int] NOT NULL,
	[DiscountCouponID] [int] NOT NULL,
 CONSTRAINT [PK_COM_SKUDiscountCoupon] PRIMARY KEY CLUSTERED 
(
	[SKUID] ASC,
	[DiscountCouponID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_SKUDiscountCoupon_DiscountCouponID] ON [dbo].[COM_SKUDiscountCoupon]
(
	[DiscountCouponID] ASC
)
GO
ALTER TABLE [dbo].[COM_SKUDiscountCoupon]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKUDiscountCoupon_DiscountCouponID_COM_DiscountCoupon] FOREIGN KEY([DiscountCouponID])
REFERENCES [dbo].[COM_DiscountCoupon] ([DiscountCouponID])
GO
ALTER TABLE [dbo].[COM_SKUDiscountCoupon] CHECK CONSTRAINT [FK_COM_SKUDiscountCoupon_DiscountCouponID_COM_DiscountCoupon]
GO
ALTER TABLE [dbo].[COM_SKUDiscountCoupon]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKUDiscountCoupon_SKUID_COM_SKU] FOREIGN KEY([SKUID])
REFERENCES [dbo].[COM_SKU] ([SKUID])
GO
ALTER TABLE [dbo].[COM_SKUDiscountCoupon] CHECK CONSTRAINT [FK_COM_SKUDiscountCoupon_SKUID_COM_SKU]
GO
