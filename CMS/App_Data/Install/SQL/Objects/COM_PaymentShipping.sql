SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_PaymentShipping](
	[PaymentOptionID] [int] NOT NULL,
	[ShippingOptionID] [int] NOT NULL,
 CONSTRAINT [PK_COM_PaymentShipping] PRIMARY KEY CLUSTERED 
(
	[PaymentOptionID] ASC,
	[ShippingOptionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_PaymentShipping_ShippingOptionID] ON [dbo].[COM_PaymentShipping]
(
	[ShippingOptionID] ASC
)
GO
ALTER TABLE [dbo].[COM_PaymentShipping]  WITH CHECK ADD  CONSTRAINT [FK_COM_PaymentShipping_PaymentOptionID_COM_PaymentOption] FOREIGN KEY([PaymentOptionID])
REFERENCES [dbo].[COM_PaymentOption] ([PaymentOptionID])
GO
ALTER TABLE [dbo].[COM_PaymentShipping] CHECK CONSTRAINT [FK_COM_PaymentShipping_PaymentOptionID_COM_PaymentOption]
GO
ALTER TABLE [dbo].[COM_PaymentShipping]  WITH CHECK ADD  CONSTRAINT [FK_COM_PaymentShipping_ShippingOptionID_COM_ShippingOption] FOREIGN KEY([ShippingOptionID])
REFERENCES [dbo].[COM_ShippingOption] ([ShippingOptionID])
GO
ALTER TABLE [dbo].[COM_PaymentShipping] CHECK CONSTRAINT [FK_COM_PaymentShipping_ShippingOptionID_COM_ShippingOption]
GO
