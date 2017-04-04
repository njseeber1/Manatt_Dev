SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_CouponCode](
	[CouponCodeID] [int] IDENTITY(1,1) NOT NULL,
	[CouponCodeCode] [nvarchar](200) NOT NULL,
	[CouponCodeUseCount] [int] NULL,
	[CouponCodeUseLimit] [int] NULL,
	[CouponCodeDiscountID] [int] NOT NULL,
	[CouponCodeLastModified] [datetime2](7) NOT NULL,
	[CouponCodeGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_COM_CouponCode] PRIMARY KEY CLUSTERED 
(
	[CouponCodeID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_CouponCode_CouponCodeDiscountID] ON [dbo].[COM_CouponCode]
(
	[CouponCodeDiscountID] ASC
)
GO
ALTER TABLE [dbo].[COM_CouponCode] ADD  CONSTRAINT [DEFAULT_COM_CouponCode_CouponCodeCode]  DEFAULT ('') FOR [CouponCodeCode]
GO
ALTER TABLE [dbo].[COM_CouponCode] ADD  CONSTRAINT [DEFAULT_COM_CouponCode_CouponCodeDiscountID]  DEFAULT ((0)) FOR [CouponCodeDiscountID]
GO
ALTER TABLE [dbo].[COM_CouponCode]  WITH CHECK ADD  CONSTRAINT [FK_COM_CouponCode_CouponCodeDiscountID_COM_Discount] FOREIGN KEY([CouponCodeDiscountID])
REFERENCES [dbo].[COM_Discount] ([DiscountID])
GO
ALTER TABLE [dbo].[COM_CouponCode] CHECK CONSTRAINT [FK_COM_CouponCode_CouponCodeDiscountID_COM_Discount]
GO
