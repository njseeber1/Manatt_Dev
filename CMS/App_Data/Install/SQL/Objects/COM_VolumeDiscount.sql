SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_VolumeDiscount](
	[VolumeDiscountID] [int] IDENTITY(1,1) NOT NULL,
	[VolumeDiscountSKUID] [int] NOT NULL,
	[VolumeDiscountMinCount] [int] NOT NULL,
	[VolumeDiscountValue] [float] NOT NULL,
	[VolumeDiscountIsFlatValue] [bit] NOT NULL,
	[VolumeDiscountGUID] [uniqueidentifier] NOT NULL,
	[VolumeDiscountLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_COM_VolumeDiscount] PRIMARY KEY CLUSTERED 
(
	[VolumeDiscountID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_VolumeDiscount_VolumeDiscountSKUID] ON [dbo].[COM_VolumeDiscount]
(
	[VolumeDiscountSKUID] ASC
)
GO
ALTER TABLE [dbo].[COM_VolumeDiscount] ADD  CONSTRAINT [DEFAULT_COM_VolumeDiscount_VolumeDiscountMinCount]  DEFAULT ((0)) FOR [VolumeDiscountMinCount]
GO
ALTER TABLE [dbo].[COM_VolumeDiscount] ADD  CONSTRAINT [DEFAULT_COM_VolumeDiscount_VolumeDiscountValue]  DEFAULT ((0)) FOR [VolumeDiscountValue]
GO
ALTER TABLE [dbo].[COM_VolumeDiscount]  WITH CHECK ADD  CONSTRAINT [FK_COM_VolumeDiscount_VolumeDiscountSKUID_COM_SKU] FOREIGN KEY([VolumeDiscountSKUID])
REFERENCES [dbo].[COM_SKU] ([SKUID])
GO
ALTER TABLE [dbo].[COM_VolumeDiscount] CHECK CONSTRAINT [FK_COM_VolumeDiscount_VolumeDiscountSKUID_COM_SKU]
GO
