SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_ShippingOption](
	[ShippingOptionID] [int] IDENTITY(1,1) NOT NULL,
	[ShippingOptionName] [nvarchar](200) NOT NULL,
	[ShippingOptionDisplayName] [nvarchar](200) NOT NULL,
	[ShippingOptionCharge] [float] NOT NULL,
	[ShippingOptionEnabled] [bit] NOT NULL,
	[ShippingOptionSiteID] [int] NULL,
	[ShippingOptionGUID] [uniqueidentifier] NOT NULL,
	[ShippingOptionLastModified] [datetime2](7) NOT NULL,
	[ShippingOptionThumbnailGUID] [uniqueidentifier] NULL,
	[ShippingOptionDescription] [nvarchar](max) NULL,
	[ShippingOptionCarrierID] [int] NULL,
	[ShippingOptionCarrierServiceName] [nvarchar](200) NULL,
 CONSTRAINT [PK_COM_ShippingOption] PRIMARY KEY NONCLUSTERED 
(
	[ShippingOptionID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_ShippingOptionDisplayName] ON [dbo].[COM_ShippingOption]
(
	[ShippingOptionDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShippingOption_ShippingOptionCarrierID] ON [dbo].[COM_ShippingOption]
(
	[ShippingOptionCarrierID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_ShippingOption_ShippingOptionSiteID_ShippingOptionDisplayName_ShippingOptionEnabled] ON [dbo].[COM_ShippingOption]
(
	[ShippingOptionSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_ShippingOption] ADD  CONSTRAINT [DEFAULT_COM_ShippingOption_ShippingOptionName]  DEFAULT (N'') FOR [ShippingOptionName]
GO
ALTER TABLE [dbo].[COM_ShippingOption] ADD  CONSTRAINT [DEFAULT_COM_ShippingOption_ShippingOptionDisplayName]  DEFAULT (N'') FOR [ShippingOptionDisplayName]
GO
ALTER TABLE [dbo].[COM_ShippingOption] ADD  CONSTRAINT [DEFAULT_COM_ShippingOption_ShippingOptionCharge]  DEFAULT ((0)) FOR [ShippingOptionCharge]
GO
ALTER TABLE [dbo].[COM_ShippingOption] ADD  CONSTRAINT [DEFAULT_COM_ShippingOption_ShippingOptionEnabled]  DEFAULT ((1)) FOR [ShippingOptionEnabled]
GO
ALTER TABLE [dbo].[COM_ShippingOption] ADD  CONSTRAINT [DEFAULT_COM_ShippingOption_ShippingOptionGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ShippingOptionGUID]
GO
ALTER TABLE [dbo].[COM_ShippingOption] ADD  CONSTRAINT [DEFAULT_COM_ShippingOption_ShippingOptionLastModified]  DEFAULT ('9/26/2012 12:44:18 PM') FOR [ShippingOptionLastModified]
GO
ALTER TABLE [dbo].[COM_ShippingOption]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShippingOption_ShippingOptionCarrierID_COM_Carrier] FOREIGN KEY([ShippingOptionCarrierID])
REFERENCES [dbo].[COM_Carrier] ([CarrierID])
GO
ALTER TABLE [dbo].[COM_ShippingOption] CHECK CONSTRAINT [FK_COM_ShippingOption_ShippingOptionCarrierID_COM_Carrier]
GO
ALTER TABLE [dbo].[COM_ShippingOption]  WITH CHECK ADD  CONSTRAINT [FK_COM_ShippingOption_ShippingOptionSiteID_CMS_Site] FOREIGN KEY([ShippingOptionSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_ShippingOption] CHECK CONSTRAINT [FK_COM_ShippingOption_ShippingOptionSiteID_CMS_Site]
GO
