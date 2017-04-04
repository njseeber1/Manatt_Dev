SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_Address](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[AddressName] [nvarchar](200) NOT NULL,
	[AddressLine1] [nvarchar](100) NOT NULL,
	[AddressLine2] [nvarchar](100) NULL,
	[AddressCity] [nvarchar](100) NOT NULL,
	[AddressZip] [nvarchar](20) NOT NULL,
	[AddressPhone] [nvarchar](100) NULL,
	[AddressCustomerID] [int] NOT NULL,
	[AddressCountryID] [int] NOT NULL,
	[AddressStateID] [int] NULL,
	[AddressIsBilling] [bit] NOT NULL,
	[AddressEnabled] [bit] NOT NULL,
	[AddressPersonalName] [nvarchar](200) NOT NULL,
	[AddressIsShipping] [bit] NOT NULL,
	[AddressIsCompany] [bit] NOT NULL,
	[AddressGUID] [uniqueidentifier] NULL,
	[AddressLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_COM_CustomerAdress] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_Address_AddressCountryID] ON [dbo].[COM_Address]
(
	[AddressCountryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Address_AddressCustomerID] ON [dbo].[COM_Address]
(
	[AddressCustomerID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Address_AddressEnabled_AddressIsBilling_AddressIsShipping_AddressIsCompany] ON [dbo].[COM_Address]
(
	[AddressEnabled] ASC,
	[AddressIsBilling] ASC,
	[AddressIsShipping] ASC,
	[AddressIsCompany] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Address_AddressStateID] ON [dbo].[COM_Address]
(
	[AddressStateID] ASC
)
GO
ALTER TABLE [dbo].[COM_Address] ADD  CONSTRAINT [DEFAULT_COM_Address_AddressName]  DEFAULT ('') FOR [AddressName]
GO
ALTER TABLE [dbo].[COM_Address] ADD  CONSTRAINT [DEFAULT_COM_Address_AddressLine1]  DEFAULT (N'') FOR [AddressLine1]
GO
ALTER TABLE [dbo].[COM_Address] ADD  CONSTRAINT [DEFAULT_COM_Address_AddressCity]  DEFAULT ('') FOR [AddressCity]
GO
ALTER TABLE [dbo].[COM_Address] ADD  CONSTRAINT [DEFAULT_COM_Address_AddressZip]  DEFAULT (N'') FOR [AddressZip]
GO
ALTER TABLE [dbo].[COM_Address] ADD  CONSTRAINT [DEFAULT_COM_Address_AddressIsBilling]  DEFAULT ((1)) FOR [AddressIsBilling]
GO
ALTER TABLE [dbo].[COM_Address] ADD  CONSTRAINT [DEFAULT_COM_Address_AddressEnabled]  DEFAULT ((1)) FOR [AddressEnabled]
GO
ALTER TABLE [dbo].[COM_Address] ADD  CONSTRAINT [DEFAULT_COM_Address_AddressPersonalName]  DEFAULT (N'') FOR [AddressPersonalName]
GO
ALTER TABLE [dbo].[COM_Address] ADD  CONSTRAINT [DEFAULT_COM_Address_AddressIsShipping]  DEFAULT ((1)) FOR [AddressIsShipping]
GO
ALTER TABLE [dbo].[COM_Address] ADD  CONSTRAINT [DEFAULT_COM_Address_AddressIsCompany]  DEFAULT ((1)) FOR [AddressIsCompany]
GO
ALTER TABLE [dbo].[COM_Address] ADD  CONSTRAINT [DEFAULT_COM_Address_AddressLastModified]  DEFAULT ('10/18/2012 3:39:07 PM') FOR [AddressLastModified]
GO
ALTER TABLE [dbo].[COM_Address]  WITH CHECK ADD  CONSTRAINT [FK_COM_Address_AddressCountryID_CMS_Country] FOREIGN KEY([AddressCountryID])
REFERENCES [dbo].[CMS_Country] ([CountryID])
GO
ALTER TABLE [dbo].[COM_Address] CHECK CONSTRAINT [FK_COM_Address_AddressCountryID_CMS_Country]
GO
ALTER TABLE [dbo].[COM_Address]  WITH CHECK ADD  CONSTRAINT [FK_COM_Address_AddressCustomerID_COM_Customer] FOREIGN KEY([AddressCustomerID])
REFERENCES [dbo].[COM_Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[COM_Address] CHECK CONSTRAINT [FK_COM_Address_AddressCustomerID_COM_Customer]
GO
ALTER TABLE [dbo].[COM_Address]  WITH CHECK ADD  CONSTRAINT [FK_COM_Address_AddressStateID_CMS_State] FOREIGN KEY([AddressStateID])
REFERENCES [dbo].[CMS_State] ([StateID])
GO
ALTER TABLE [dbo].[COM_Address] CHECK CONSTRAINT [FK_COM_Address_AddressStateID_CMS_State]
GO
