SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_Carrier](
	[CarrierID] [int] IDENTITY(1,1) NOT NULL,
	[CarrierDisplayName] [nvarchar](200) NOT NULL,
	[CarrierName] [nvarchar](200) NOT NULL,
	[CarrierSiteID] [int] NOT NULL,
	[CarrierGUID] [uniqueidentifier] NOT NULL,
	[CarrierAssemblyName] [nvarchar](200) NOT NULL,
	[CarrierClassName] [nvarchar](200) NOT NULL,
	[CarrierLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_COM_Carrier] PRIMARY KEY CLUSTERED 
(
	[CarrierID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_Carrier_CarrierSiteID] ON [dbo].[COM_Carrier]
(
	[CarrierSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_Carrier] ADD  CONSTRAINT [DEFAULT_COM_Carrier_CarrierDisplayName]  DEFAULT (N'') FOR [CarrierDisplayName]
GO
ALTER TABLE [dbo].[COM_Carrier] ADD  CONSTRAINT [DEFAULT_COM_Carrier_CarrierName]  DEFAULT (N'') FOR [CarrierName]
GO
ALTER TABLE [dbo].[COM_Carrier] ADD  CONSTRAINT [DEFAULT_COM_Carrier_CarrierSiteID]  DEFAULT ((0)) FOR [CarrierSiteID]
GO
ALTER TABLE [dbo].[COM_Carrier] ADD  CONSTRAINT [DEFAULT_COM_Carrier_CarrierGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CarrierGUID]
GO
ALTER TABLE [dbo].[COM_Carrier] ADD  CONSTRAINT [DEFAULT_COM_Carrier_CarrierAssemblyName]  DEFAULT (N'') FOR [CarrierAssemblyName]
GO
ALTER TABLE [dbo].[COM_Carrier] ADD  CONSTRAINT [DEFAULT_COM_Carrier_CarrierClassName]  DEFAULT (N'') FOR [CarrierClassName]
GO
ALTER TABLE [dbo].[COM_Carrier] ADD  CONSTRAINT [DEFAULT_COM_Carrier_CarrierLastModified]  DEFAULT ('9/22/2014 3:00:14 PM') FOR [CarrierLastModified]
GO
ALTER TABLE [dbo].[COM_Carrier]  WITH CHECK ADD  CONSTRAINT [FK_COM_Carrier_CarrierSiteID_CMS_Site] FOREIGN KEY([CarrierSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_Carrier] CHECK CONSTRAINT [FK_COM_Carrier_CarrierSiteID_CMS_Site]
GO
