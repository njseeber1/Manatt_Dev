SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerFirstName] [nvarchar](200) NOT NULL,
	[CustomerLastName] [nvarchar](200) NOT NULL,
	[CustomerEmail] [nvarchar](200) NULL,
	[CustomerPhone] [nvarchar](50) NULL,
	[CustomerFax] [nvarchar](50) NULL,
	[CustomerCompany] [nvarchar](200) NULL,
	[CustomerUserID] [int] NULL,
	[CustomerPreferredCurrencyID] [int] NULL,
	[CustomerPreferredShippingOptionID] [int] NULL,
	[CustomerCountryID] [int] NULL,
	[CustomerEnabled] [bit] NOT NULL,
	[CustomerPrefferedPaymentOptionID] [int] NULL,
	[CustomerStateID] [int] NULL,
	[CustomerGUID] [uniqueidentifier] NOT NULL,
	[CustomerTaxRegistrationID] [nvarchar](50) NULL,
	[CustomerOrganizationID] [nvarchar](50) NULL,
	[CustomerLastModified] [datetime2](7) NOT NULL,
	[CustomerSiteID] [int] NULL,
	[CustomerCreated] [datetime2](7) NULL,
 CONSTRAINT [PK_COM_Customer] PRIMARY KEY NONCLUSTERED 
(
	[CustomerID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_Customer_CustomerLastName_CustomerFirstName_CustomerEnabled] ON [dbo].[COM_Customer]
(
	[CustomerLastName] ASC,
	[CustomerFirstName] ASC,
	[CustomerEnabled] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_COM_Customer_CustomerCompany] ON [dbo].[COM_Customer]
(
	[CustomerCompany] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Customer_CustomerCountryID] ON [dbo].[COM_Customer]
(
	[CustomerCountryID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_COM_Customer_CustomerEmail] ON [dbo].[COM_Customer]
(
	[CustomerEmail] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Customer_CustomerPreferredCurrencyID] ON [dbo].[COM_Customer]
(
	[CustomerPreferredCurrencyID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Customer_CustomerPreferredShippingOptionID] ON [dbo].[COM_Customer]
(
	[CustomerPreferredShippingOptionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Customer_CustomerPrefferedPaymentOptionID] ON [dbo].[COM_Customer]
(
	[CustomerPrefferedPaymentOptionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Customer_CustomerSiteID] ON [dbo].[COM_Customer]
(
	[CustomerSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Customer_CustomerStateID] ON [dbo].[COM_Customer]
(
	[CustomerStateID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Customer_CustomerUserID] ON [dbo].[COM_Customer]
(
	[CustomerUserID] ASC
)
GO
ALTER TABLE [dbo].[COM_Customer] ADD  CONSTRAINT [DEFAULT_COM_Customer_CustomerGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CustomerGUID]
GO
ALTER TABLE [dbo].[COM_Customer]  WITH CHECK ADD  CONSTRAINT [FK_COM_Customer_CustomerCountryID_CMS_Country] FOREIGN KEY([CustomerCountryID])
REFERENCES [dbo].[CMS_Country] ([CountryID])
GO
ALTER TABLE [dbo].[COM_Customer] CHECK CONSTRAINT [FK_COM_Customer_CustomerCountryID_CMS_Country]
GO
ALTER TABLE [dbo].[COM_Customer]  WITH CHECK ADD  CONSTRAINT [FK_COM_Customer_CustomerSiteID_CMS_Site] FOREIGN KEY([CustomerSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_Customer] CHECK CONSTRAINT [FK_COM_Customer_CustomerSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[COM_Customer]  WITH CHECK ADD  CONSTRAINT [FK_COM_Customer_CustomerStateID_CMS_State] FOREIGN KEY([CustomerStateID])
REFERENCES [dbo].[CMS_State] ([StateID])
GO
ALTER TABLE [dbo].[COM_Customer] CHECK CONSTRAINT [FK_COM_Customer_CustomerStateID_CMS_State]
GO
ALTER TABLE [dbo].[COM_Customer]  WITH CHECK ADD  CONSTRAINT [FK_COM_Customer_CustomerUserID_CMS_User] FOREIGN KEY([CustomerUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[COM_Customer] CHECK CONSTRAINT [FK_COM_Customer_CustomerUserID_CMS_User]
GO
