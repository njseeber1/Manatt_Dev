SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_MultiBuyCouponCode](
	[MultiBuyCouponCodeID] [int] IDENTITY(1,1) NOT NULL,
	[MultiBuyCouponCodeCode] [nvarchar](200) NOT NULL,
	[MultiBuyCouponCodeUseLimit] [int] NULL,
	[MultiBuyCouponCodeUseCount] [int] NULL,
	[MultiBuyCouponCodeMultiBuyDiscountID] [int] NOT NULL,
	[MultiBuyCouponCodeLastModified] [datetime2](7) NOT NULL,
	[MultiBuyCouponCodeGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_COM_MultiBuyCouponCode] PRIMARY KEY CLUSTERED 
(
	[MultiBuyCouponCodeID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_MultiBuyCouponCode_MultiBuyCouponCodeMultiBuyDiscountID] ON [dbo].[COM_MultiBuyCouponCode]
(
	[MultiBuyCouponCodeMultiBuyDiscountID] ASC
)
GO
ALTER TABLE [dbo].[COM_MultiBuyCouponCode] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyCouponCode_MultiBuyCouponCodeCode]  DEFAULT (N'') FOR [MultiBuyCouponCodeCode]
GO
ALTER TABLE [dbo].[COM_MultiBuyCouponCode] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyCouponCode_MultiBuyCouponCodeUseCount]  DEFAULT ((0)) FOR [MultiBuyCouponCodeUseCount]
GO
ALTER TABLE [dbo].[COM_MultiBuyCouponCode] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyCouponCode_MultiBuyCouponCodeMultiBuyDiscountID]  DEFAULT ((0)) FOR [MultiBuyCouponCodeMultiBuyDiscountID]
GO
ALTER TABLE [dbo].[COM_MultiBuyCouponCode] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyCouponCode_MultiBuyCouponCodeGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [MultiBuyCouponCodeGUID]
GO
ALTER TABLE [dbo].[COM_MultiBuyCouponCode]  WITH CHECK ADD  CONSTRAINT [FK_COM_MultiBuyCouponCode_MultiBuyCouponCodeMultiBuyDiscountID_COM_MultiBuyDiscount] FOREIGN KEY([MultiBuyCouponCodeMultiBuyDiscountID])
REFERENCES [dbo].[COM_MultiBuyDiscount] ([MultiBuyDiscountID])
GO
ALTER TABLE [dbo].[COM_MultiBuyCouponCode] CHECK CONSTRAINT [FK_COM_MultiBuyCouponCode_MultiBuyCouponCodeMultiBuyDiscountID_COM_MultiBuyDiscount]
GO
