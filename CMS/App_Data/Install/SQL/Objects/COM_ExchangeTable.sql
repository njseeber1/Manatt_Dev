SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_ExchangeTable](
	[ExchangeTableID] [int] IDENTITY(1,1) NOT NULL,
	[ExchangeTableDisplayName] [nvarchar](200) NOT NULL,
	[ExchangeTableValidFrom] [datetime2](7) NULL,
	[ExchangeTableValidTo] [datetime2](7) NULL,
	[ExchangeTableGUID] [uniqueidentifier] NOT NULL,
	[ExchangeTableLastModified] [datetime2](7) NOT NULL,
	[ExchangeTableSiteID] [int] NULL,
	[ExchangeTableRateFromGlobalCurrency] [float] NULL,
 CONSTRAINT [PK_COM_ExchangeTable] PRIMARY KEY NONCLUSTERED 
(
	[ExchangeTableID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_COM_ExchangeTable_ExchangeTableValidFrom_ExchangeTableValidTo] ON [dbo].[COM_ExchangeTable]
(
	[ExchangeTableValidFrom] DESC,
	[ExchangeTableValidTo] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ExchangeTable_ExchangeTableSiteID] ON [dbo].[COM_ExchangeTable]
(
	[ExchangeTableSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_ExchangeTable] ADD  CONSTRAINT [DEFAULT_COM_ExchangeTable_ExchangeTableDisplayName]  DEFAULT (N'') FOR [ExchangeTableDisplayName]
GO
ALTER TABLE [dbo].[COM_ExchangeTable]  WITH CHECK ADD  CONSTRAINT [FK_COM_ExchangeTable_ExchangeTableSiteID_CMS_Site] FOREIGN KEY([ExchangeTableSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_ExchangeTable] CHECK CONSTRAINT [FK_COM_ExchangeTable_ExchangeTableSiteID_CMS_Site]
GO
