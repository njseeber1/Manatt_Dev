SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_TaxClassCountry](
	[TaxClassCountryID] [int] IDENTITY(1,1) NOT NULL,
	[TaxClassID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[TaxValue] [float] NOT NULL,
 CONSTRAINT [PK_COM_TaxClassCountry] PRIMARY KEY CLUSTERED 
(
	[TaxClassCountryID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_TaxClassCountry_CountryID] ON [dbo].[COM_TaxClassCountry]
(
	[CountryID] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_COM_TaxClassCountry_TaxClassID_CountryID] ON [dbo].[COM_TaxClassCountry]
(
	[TaxClassID] ASC,
	[CountryID] ASC
)
GO
ALTER TABLE [dbo].[COM_TaxClassCountry]  WITH CHECK ADD  CONSTRAINT [FK_COM_TaxCategoryCountry_CountryID_CMS_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CMS_Country] ([CountryID])
GO
ALTER TABLE [dbo].[COM_TaxClassCountry] CHECK CONSTRAINT [FK_COM_TaxCategoryCountry_CountryID_CMS_Country]
GO
ALTER TABLE [dbo].[COM_TaxClassCountry]  WITH CHECK ADD  CONSTRAINT [FK_COM_TaxCategoryCountry_TaxClassID_COM_TaxClass] FOREIGN KEY([TaxClassID])
REFERENCES [dbo].[COM_TaxClass] ([TaxClassID])
GO
ALTER TABLE [dbo].[COM_TaxClassCountry] CHECK CONSTRAINT [FK_COM_TaxCategoryCountry_TaxClassID_COM_TaxClass]
GO
