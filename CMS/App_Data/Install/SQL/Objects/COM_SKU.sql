SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_SKU](
	[SKUID] [int] IDENTITY(1,1) NOT NULL,
	[SKUNumber] [nvarchar](200) NULL,
	[SKUName] [nvarchar](440) NOT NULL,
	[SKUDescription] [nvarchar](max) NULL,
	[SKUPrice] [float] NOT NULL,
	[SKUEnabled] [bit] NOT NULL,
	[SKUDepartmentID] [int] NULL,
	[SKUManufacturerID] [int] NULL,
	[SKUInternalStatusID] [int] NULL,
	[SKUPublicStatusID] [int] NULL,
	[SKUSupplierID] [int] NULL,
	[SKUAvailableInDays] [int] NULL,
	[SKUGUID] [uniqueidentifier] NOT NULL,
	[SKUImagePath] [nvarchar](450) NULL,
	[SKUWeight] [float] NULL,
	[SKUWidth] [float] NULL,
	[SKUDepth] [float] NULL,
	[SKUHeight] [float] NULL,
	[SKUAvailableItems] [int] NULL,
	[SKUSellOnlyAvailable] [bit] NULL,
	[SKUCustomData] [nvarchar](max) NULL,
	[SKUOptionCategoryID] [int] NULL,
	[SKUOrder] [int] NULL,
	[SKULastModified] [datetime2](7) NOT NULL,
	[SKUCreated] [datetime2](7) NULL,
	[SKUSiteID] [int] NULL,
	[SKUPrivateDonation] [bit] NULL,
	[SKUNeedsShipping] [bit] NULL,
	[SKUMaxDownloads] [int] NULL,
	[SKUValidUntil] [datetime2](7) NULL,
	[SKUProductType] [nvarchar](50) NULL,
	[SKUMaxItemsInOrder] [int] NULL,
	[SKUMaxPrice] [float] NULL,
	[SKUValidity] [nvarchar](50) NULL,
	[SKUValidFor] [int] NULL,
	[SKUMinPrice] [float] NULL,
	[SKUMembershipGUID] [uniqueidentifier] NULL,
	[SKUConversionName] [nvarchar](100) NULL,
	[SKUConversionValue] [nvarchar](200) NULL,
	[SKUBundleInventoryType] [nvarchar](50) NULL,
	[SKUMinItemsInOrder] [int] NULL,
	[SKURetailPrice] [float] NULL,
	[SKUParentSKUID] [int] NULL,
	[SKUShortDescription] [nvarchar](max) NULL,
	[SKUEproductFilesCount] [int] NULL,
	[SKUBundleItemsCount] [int] NULL,
	[SKUInStoreFrom] [datetime2](7) NULL,
	[SKUReorderAt] [int] NULL,
	[SKUTrackInventory] [nvarchar](50) NULL,
 CONSTRAINT [PK_COM_SKU] PRIMARY KEY NONCLUSTERED 
(
	[SKUID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_SKU_SKUName] ON [dbo].[COM_SKU]
(
	[SKUName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKU_SKUDepartmentID] ON [dbo].[COM_SKU]
(
	[SKUDepartmentID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKU_SKUEnabled_SKUAvailableItems] ON [dbo].[COM_SKU]
(
	[SKUEnabled] ASC,
	[SKUAvailableItems] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKU_SKUInternalStatusID] ON [dbo].[COM_SKU]
(
	[SKUInternalStatusID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKU_SKUManufacturerID] ON [dbo].[COM_SKU]
(
	[SKUManufacturerID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKU_SKUName_SKUEnabled] ON [dbo].[COM_SKU]
(
	[SKUDepartmentID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKU_SKUOptionCategoryID] ON [dbo].[COM_SKU]
(
	[SKUOptionCategoryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKU_SKUParentSKUID] ON [dbo].[COM_SKU]
(
	[SKUParentSKUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKU_SKUPrice] ON [dbo].[COM_SKU]
(
	[SKUPrice] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKU_SKUPublicStatusID] ON [dbo].[COM_SKU]
(
	[SKUPublicStatusID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKU_SKUSiteID] ON [dbo].[COM_SKU]
(
	[SKUSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKU_SKUSupplierID] ON [dbo].[COM_SKU]
(
	[SKUSupplierID] ASC
)
GO
ALTER TABLE [dbo].[COM_SKU] ADD  CONSTRAINT [DEFAULT_COM_SKU_SKUName]  DEFAULT ('') FOR [SKUName]
GO
ALTER TABLE [dbo].[COM_SKU] ADD  CONSTRAINT [DEFAULT_COM_SKU_SKUPrice]  DEFAULT ((0)) FOR [SKUPrice]
GO
ALTER TABLE [dbo].[COM_SKU] ADD  CONSTRAINT [DEFAULT_COM_SKU_SKUEnabled]  DEFAULT ((1)) FOR [SKUEnabled]
GO
ALTER TABLE [dbo].[COM_SKU] ADD  CONSTRAINT [DEFAULT_COM_SKU_SKUGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [SKUGUID]
GO
ALTER TABLE [dbo].[COM_SKU] ADD  CONSTRAINT [DEFAULT_COM_SKU_SKUSellOnlyAvailable]  DEFAULT ((0)) FOR [SKUSellOnlyAvailable]
GO
ALTER TABLE [dbo].[COM_SKU] ADD  CONSTRAINT [DEFAULT_COM_SKU_SKUConversionValue]  DEFAULT ('0') FOR [SKUConversionValue]
GO
ALTER TABLE [dbo].[COM_SKU] ADD  CONSTRAINT [DEFAULT_COM_SKU_SKUBundleInventoryType]  DEFAULT ('REMOVEBUNDLE') FOR [SKUBundleInventoryType]
GO
ALTER TABLE [dbo].[COM_SKU] ADD  CONSTRAINT [DEFAULT_COM_SKU_SKUTrackInventory]  DEFAULT (N'ByProduct') FOR [SKUTrackInventory]
GO
ALTER TABLE [dbo].[COM_SKU]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKU_SKUDepartmentID_COM_Department] FOREIGN KEY([SKUDepartmentID])
REFERENCES [dbo].[COM_Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[COM_SKU] CHECK CONSTRAINT [FK_COM_SKU_SKUDepartmentID_COM_Department]
GO
ALTER TABLE [dbo].[COM_SKU]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKU_SKUInternalStatusID_COM_InternalStatus] FOREIGN KEY([SKUInternalStatusID])
REFERENCES [dbo].[COM_InternalStatus] ([InternalStatusID])
GO
ALTER TABLE [dbo].[COM_SKU] CHECK CONSTRAINT [FK_COM_SKU_SKUInternalStatusID_COM_InternalStatus]
GO
ALTER TABLE [dbo].[COM_SKU]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKU_SKUManufacturerID_COM_Manifacturer] FOREIGN KEY([SKUManufacturerID])
REFERENCES [dbo].[COM_Manufacturer] ([ManufacturerID])
GO
ALTER TABLE [dbo].[COM_SKU] CHECK CONSTRAINT [FK_COM_SKU_SKUManufacturerID_COM_Manifacturer]
GO
ALTER TABLE [dbo].[COM_SKU]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKU_SKUOptionCategoryID_COM_OptionCategory] FOREIGN KEY([SKUOptionCategoryID])
REFERENCES [dbo].[COM_OptionCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[COM_SKU] CHECK CONSTRAINT [FK_COM_SKU_SKUOptionCategoryID_COM_OptionCategory]
GO
ALTER TABLE [dbo].[COM_SKU]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKU_SKUParentSKUID_COM_SKU] FOREIGN KEY([SKUParentSKUID])
REFERENCES [dbo].[COM_SKU] ([SKUID])
GO
ALTER TABLE [dbo].[COM_SKU] CHECK CONSTRAINT [FK_COM_SKU_SKUParentSKUID_COM_SKU]
GO
ALTER TABLE [dbo].[COM_SKU]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKU_SKUPublicStatusID_COM_PublicStatus] FOREIGN KEY([SKUPublicStatusID])
REFERENCES [dbo].[COM_PublicStatus] ([PublicStatusID])
GO
ALTER TABLE [dbo].[COM_SKU] CHECK CONSTRAINT [FK_COM_SKU_SKUPublicStatusID_COM_PublicStatus]
GO
ALTER TABLE [dbo].[COM_SKU]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKU_SKUSiteID_CMS_Site] FOREIGN KEY([SKUSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_SKU] CHECK CONSTRAINT [FK_COM_SKU_SKUSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[COM_SKU]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKU_SKUSupplierID_COM_Supplier] FOREIGN KEY([SKUSupplierID])
REFERENCES [dbo].[COM_Supplier] ([SupplierID])
GO
ALTER TABLE [dbo].[COM_SKU] CHECK CONSTRAINT [FK_COM_SKU_SKUSupplierID_COM_Supplier]
GO
