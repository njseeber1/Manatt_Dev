SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_Currency](
	[CurrencyID] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyName] [nvarchar](200) NOT NULL,
	[CurrencyDisplayName] [nvarchar](200) NOT NULL,
	[CurrencyCode] [nvarchar](200) NOT NULL,
	[CurrencyRoundTo] [int] NULL,
	[CurrencyEnabled] [bit] NOT NULL,
	[CurrencyFormatString] [nvarchar](200) NOT NULL,
	[CurrencyIsMain] [bit] NOT NULL,
	[CurrencyGUID] [uniqueidentifier] NULL,
	[CurrencyLastModified] [datetime2](7) NOT NULL,
	[CurrencySiteID] [int] NULL,
 CONSTRAINT [PK_COM_Currency] PRIMARY KEY NONCLUSTERED 
(
	[CurrencyID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_Currency_CurrencyDisplayName] ON [dbo].[COM_Currency]
(
	[CurrencyDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Currency_CurrencyEnabled_CurrencyIsMain] ON [dbo].[COM_Currency]
(
	[CurrencyEnabled] ASC,
	[CurrencyIsMain] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Currency_CurrencySiteID] ON [dbo].[COM_Currency]
(
	[CurrencySiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_Currency] ADD  CONSTRAINT [DEFAULT_COM_Currency_CurrencyName]  DEFAULT (N'') FOR [CurrencyName]
GO
ALTER TABLE [dbo].[COM_Currency] ADD  CONSTRAINT [DEFAULT_COM_Currency_CurrencyDisplayName]  DEFAULT (N'') FOR [CurrencyDisplayName]
GO
ALTER TABLE [dbo].[COM_Currency] ADD  CONSTRAINT [DEFAULT_COM_Currency_CurrencyCode]  DEFAULT (N'') FOR [CurrencyCode]
GO
ALTER TABLE [dbo].[COM_Currency] ADD  CONSTRAINT [DEFAULT_COM_Currency_CurrencyFormatString]  DEFAULT (N'') FOR [CurrencyFormatString]
GO
ALTER TABLE [dbo].[COM_Currency]  WITH CHECK ADD  CONSTRAINT [FK_COM_Currency_CurrencySiteID_CMS_Site] FOREIGN KEY([CurrencySiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_Currency] CHECK CONSTRAINT [FK_COM_Currency_CurrencySiteID_CMS_Site]
GO
