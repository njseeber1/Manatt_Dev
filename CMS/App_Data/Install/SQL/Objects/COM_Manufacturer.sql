SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_Manufacturer](
	[ManufacturerID] [int] IDENTITY(1,1) NOT NULL,
	[ManufacturerDisplayName] [nvarchar](200) NOT NULL,
	[ManufactureHomepage] [nvarchar](400) NULL,
	[ManufacturerEnabled] [bit] NOT NULL,
	[ManufacturerGUID] [uniqueidentifier] NOT NULL,
	[ManufacturerLastModified] [datetime2](7) NOT NULL,
	[ManufacturerSiteID] [int] NULL,
	[ManufacturerThumbnailGUID] [uniqueidentifier] NULL,
	[ManufacturerDescription] [nvarchar](max) NULL,
	[ManufacturerName] [nvarchar](200) NULL,
 CONSTRAINT [PK_COM_Manufacturer] PRIMARY KEY NONCLUSTERED 
(
	[ManufacturerID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_Manufacturer_ManufacturerDisplayName_ManufacturerEnabled] ON [dbo].[COM_Manufacturer]
(
	[ManufacturerDisplayName] ASC,
	[ManufacturerEnabled] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Manufacturer_ManufacturerSiteID] ON [dbo].[COM_Manufacturer]
(
	[ManufacturerSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_Manufacturer] ADD  CONSTRAINT [DEFAULT_COM_Manufacturer_ManufacturerDisplayName]  DEFAULT (N'') FOR [ManufacturerDisplayName]
GO
ALTER TABLE [dbo].[COM_Manufacturer] ADD  CONSTRAINT [DEFAULT_COM_Manufacturer_ManufacturerEnabled]  DEFAULT ((1)) FOR [ManufacturerEnabled]
GO
ALTER TABLE [dbo].[COM_Manufacturer]  WITH CHECK ADD  CONSTRAINT [FK_COM_Manufacturer_ManufacturerSiteID_CMS_Site] FOREIGN KEY([ManufacturerSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_Manufacturer] CHECK CONSTRAINT [FK_COM_Manufacturer_ManufacturerSiteID_CMS_Site]
GO
