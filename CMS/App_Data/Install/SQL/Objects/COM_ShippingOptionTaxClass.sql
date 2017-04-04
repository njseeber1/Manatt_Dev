SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_ShippingOptionTaxClass](
	[ShippingOptionID] [int] NOT NULL,
	[TaxClassID] [int] NOT NULL,
 CONSTRAINT [PK_COM_ShippingOptionTaxClass] PRIMARY KEY CLUSTERED 
(
	[ShippingOptionID] ASC,
	[TaxClassID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_ShippingOptionTaxClass_TaxClassID] ON [dbo].[COM_ShippingOptionTaxClass]
(
	[TaxClassID] ASC
)
GO
ALTER TABLE [dbo].[COM_ShippingOptionTaxClass]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShippingOptionTaxClass_ShippingOptionID_COM_ShippingOption] FOREIGN KEY([ShippingOptionID])
REFERENCES [dbo].[COM_ShippingOption] ([ShippingOptionID])
GO
ALTER TABLE [dbo].[COM_ShippingOptionTaxClass] CHECK CONSTRAINT [FK_COM_ShippingOptionTaxClass_ShippingOptionID_COM_ShippingOption]
GO
ALTER TABLE [dbo].[COM_ShippingOptionTaxClass]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShippingOptionTaxClass_TaxClassID_COM_TaxClass] FOREIGN KEY([TaxClassID])
REFERENCES [dbo].[COM_TaxClass] ([TaxClassID])
GO
ALTER TABLE [dbo].[COM_ShippingOptionTaxClass] CHECK CONSTRAINT [FK_COM_ShippingOptionTaxClass_TaxClassID_COM_TaxClass]
GO
