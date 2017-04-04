SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_OrderAddress](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[AddressLine1] [nvarchar](100) NOT NULL,
	[AddressLine2] [nvarchar](100) NULL,
	[AddressCity] [nvarchar](100) NOT NULL,
	[AddressZip] [nvarchar](20) NOT NULL,
	[AddressPhone] [nvarchar](100) NULL,
	[AddressCountryID] [int] NOT NULL,
	[AddressStateID] [int] NULL,
	[AddressPersonalName] [nvarchar](200) NOT NULL,
	[AddressGUID] [uniqueidentifier] NULL,
	[AddressLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_COM_OrderAddress] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_OrderAddress_AddressCountryID] ON [dbo].[COM_OrderAddress]
(
	[AddressCountryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_OrderAddress_AddressStateID] ON [dbo].[COM_OrderAddress]
(
	[AddressStateID] ASC
)
GO
ALTER TABLE [dbo].[COM_OrderAddress]  WITH CHECK ADD  CONSTRAINT [FK_COM_OrderAddress_AddressCountryID_CMS_Country] FOREIGN KEY([AddressCountryID])
REFERENCES [dbo].[CMS_Country] ([CountryID])
GO
ALTER TABLE [dbo].[COM_OrderAddress] CHECK CONSTRAINT [FK_COM_OrderAddress_AddressCountryID_CMS_Country]
GO
ALTER TABLE [dbo].[COM_OrderAddress]  WITH CHECK ADD  CONSTRAINT [FK_COM_OrderAddress_AddressStateID_CMS_State] FOREIGN KEY([AddressStateID])
REFERENCES [dbo].[CMS_State] ([StateID])
GO
ALTER TABLE [dbo].[COM_OrderAddress] CHECK CONSTRAINT [FK_COM_OrderAddress_AddressStateID_CMS_State]
GO
