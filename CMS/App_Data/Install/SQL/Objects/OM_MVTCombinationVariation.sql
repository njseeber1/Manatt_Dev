SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_MVTCombinationVariation](
	[MVTCombinationID] [int] NOT NULL,
	[MVTVariantID] [int] NOT NULL,
 CONSTRAINT [PK_OM_MVTCombinationVariation] PRIMARY KEY CLUSTERED 
(
	[MVTCombinationID] ASC,
	[MVTVariantID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_MVTCombinationVariation_MVTVariantID] ON [dbo].[OM_MVTCombinationVariation]
(
	[MVTVariantID] ASC
)
GO
ALTER TABLE [dbo].[OM_MVTCombinationVariation]  WITH CHECK ADD  CONSTRAINT [FK_OM_MVTCombinationVariation_OM_MVTCombination] FOREIGN KEY([MVTCombinationID])
REFERENCES [dbo].[OM_MVTCombination] ([MVTCombinationID])
GO
ALTER TABLE [dbo].[OM_MVTCombinationVariation] CHECK CONSTRAINT [FK_OM_MVTCombinationVariation_OM_MVTCombination]
GO
ALTER TABLE [dbo].[OM_MVTCombinationVariation]  WITH CHECK ADD  CONSTRAINT [FK_OM_MVTCombinationVariation_OM_MVTVariant] FOREIGN KEY([MVTVariantID])
REFERENCES [dbo].[OM_MVTVariant] ([MVTVariantID])
GO
ALTER TABLE [dbo].[OM_MVTCombinationVariation] CHECK CONSTRAINT [FK_OM_MVTCombinationVariation_OM_MVTVariant]
GO
