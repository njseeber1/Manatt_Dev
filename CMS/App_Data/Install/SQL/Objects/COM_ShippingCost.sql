SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_ShippingCost](
	[ShippingCostID] [int] IDENTITY(1,1) NOT NULL,
	[ShippingCostShippingOptionID] [int] NOT NULL,
	[ShippingCostMinWeight] [float] NOT NULL,
	[ShippingCostValue] [float] NOT NULL,
	[ShippingCostGUID] [uniqueidentifier] NOT NULL,
	[ShippingCostLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK__COM_ShippingCost] PRIMARY KEY CLUSTERED 
(
	[ShippingCostID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_ShippingCost_ShippingCostShippingOptionID] ON [dbo].[COM_ShippingCost]
(
	[ShippingCostShippingOptionID] ASC
)
GO
ALTER TABLE [dbo].[COM_ShippingCost] ADD  CONSTRAINT [DEFAULT_COM_ShippingCost_ShippingCostMinWeight]  DEFAULT ((0)) FOR [ShippingCostMinWeight]
GO
ALTER TABLE [dbo].[COM_ShippingCost] ADD  CONSTRAINT [DEFAULT_COM_ShippingCost_ShippingCostValue]  DEFAULT ((0)) FOR [ShippingCostValue]
GO
ALTER TABLE [dbo].[COM_ShippingCost]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShippingCost_ShippingCostShippingOptionID_COM_ShippingOption] FOREIGN KEY([ShippingCostShippingOptionID])
REFERENCES [dbo].[COM_ShippingOption] ([ShippingOptionID])
GO
ALTER TABLE [dbo].[COM_ShippingCost] CHECK CONSTRAINT [FK_COM_ShippingCost_ShippingCostShippingOptionID_COM_ShippingOption]
GO
