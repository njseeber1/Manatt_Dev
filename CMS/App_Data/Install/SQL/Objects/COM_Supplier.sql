SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_Supplier](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierDisplayName] [nvarchar](200) NOT NULL,
	[SupplierPhone] [nvarchar](50) NULL,
	[SupplierEmail] [nvarchar](200) NULL,
	[SupplierFax] [nvarchar](50) NULL,
	[SupplierEnabled] [bit] NOT NULL,
	[SupplierGUID] [uniqueidentifier] NOT NULL,
	[SupplierLastModified] [datetime2](7) NOT NULL,
	[SupplierSiteID] [int] NULL,
	[SupplierName] [nvarchar](200) NULL,
 CONSTRAINT [PK_COM_Supplier] PRIMARY KEY NONCLUSTERED 
(
	[SupplierID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_Supplier_SupplierDisplayName_SupplierEnabled] ON [dbo].[COM_Supplier]
(
	[SupplierDisplayName] ASC,
	[SupplierEnabled] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Supplier_SupplierSiteID] ON [dbo].[COM_Supplier]
(
	[SupplierSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_Supplier] ADD  CONSTRAINT [DEFAULT_COM_Supplier_SupplierDisplayName]  DEFAULT ('') FOR [SupplierDisplayName]
GO
ALTER TABLE [dbo].[COM_Supplier] ADD  CONSTRAINT [DEFAULT_COM_Supplier_SupplierEnabled]  DEFAULT ((1)) FOR [SupplierEnabled]
GO
ALTER TABLE [dbo].[COM_Supplier] ADD  CONSTRAINT [DEFAULT_COM_Supplier_SupplierGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [SupplierGUID]
GO
ALTER TABLE [dbo].[COM_Supplier] ADD  CONSTRAINT [DEFAULT_COM_Supplier_SupplierLastModified]  DEFAULT ('9/21/2012 12:34:09 PM') FOR [SupplierLastModified]
GO
ALTER TABLE [dbo].[COM_Supplier]  WITH CHECK ADD  CONSTRAINT [FK_COM_Supplier_SupplierSiteID_CMS_Site] FOREIGN KEY([SupplierSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_Supplier] CHECK CONSTRAINT [FK_COM_Supplier_SupplierSiteID_CMS_Site]
GO
