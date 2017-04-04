SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_CurrencyExchangeRate](
	[ExchagneRateID] [int] IDENTITY(1,1) NOT NULL,
	[ExchangeRateToCurrencyID] [int] NOT NULL,
	[ExchangeRateValue] [float] NOT NULL,
	[ExchangeTableID] [int] NOT NULL,
	[ExchangeRateGUID] [uniqueidentifier] NOT NULL,
	[ExchangeRateLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_COM_CurrencyExchangeRate] PRIMARY KEY CLUSTERED 
(
	[ExchagneRateID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID] ON [dbo].[COM_CurrencyExchangeRate]
(
	[ExchangeRateToCurrencyID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_CurrencyExchangeRate_ExchangeTableID] ON [dbo].[COM_CurrencyExchangeRate]
(
	[ExchangeTableID] ASC
)
GO
ALTER TABLE [dbo].[COM_CurrencyExchangeRate]  WITH CHECK ADD  CONSTRAINT [FK_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID_COM_Currency] FOREIGN KEY([ExchangeRateToCurrencyID])
REFERENCES [dbo].[COM_Currency] ([CurrencyID])
GO
ALTER TABLE [dbo].[COM_CurrencyExchangeRate] CHECK CONSTRAINT [FK_COM_CurrencyExchangeRate_ExchangeRateToCurrencyID_COM_Currency]
GO
ALTER TABLE [dbo].[COM_CurrencyExchangeRate]  WITH CHECK ADD  CONSTRAINT [FK_COM_CurrencyExchangeRate_ExchangeTableID_COM_ExchangeTable] FOREIGN KEY([ExchangeTableID])
REFERENCES [dbo].[COM_ExchangeTable] ([ExchangeTableID])
GO
ALTER TABLE [dbo].[COM_CurrencyExchangeRate] CHECK CONSTRAINT [FK_COM_CurrencyExchangeRate_ExchangeTableID_COM_ExchangeTable]
GO
