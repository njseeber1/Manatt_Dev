SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_BannedIP](
	[IPAddressID] [int] IDENTITY(1,1) NOT NULL,
	[IPAddress] [nvarchar](100) NOT NULL,
	[IPAddressRegular] [nvarchar](200) NOT NULL,
	[IPAddressAllowed] [bit] NOT NULL,
	[IPAddressAllowOverride] [bit] NOT NULL,
	[IPAddressBanReason] [nvarchar](450) NULL,
	[IPAddressBanType] [nvarchar](100) NOT NULL,
	[IPAddressBanEnabled] [bit] NULL,
	[IPAddressSiteID] [int] NULL,
	[IPAddressGUID] [uniqueidentifier] NOT NULL,
	[IPAddressLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CMS_BannedIP] PRIMARY KEY NONCLUSTERED 
(
	[IPAddressID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_BannedIP_IPAddressSiteID_IPAddress] ON [dbo].[CMS_BannedIP]
(
	[IPAddress] ASC,
	[IPAddressSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_BannedIP_IPAddressSiteID] ON [dbo].[CMS_BannedIP]
(
	[IPAddressSiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_BannedIP] ADD  CONSTRAINT [DEFAULT_CMS_BannedIP_IPAddressAllowed]  DEFAULT ((0)) FOR [IPAddressAllowed]
GO
ALTER TABLE [dbo].[CMS_BannedIP] ADD  CONSTRAINT [DEFAULT_CMS_BannedIP_IPAddressAllowOverride]  DEFAULT ((0)) FOR [IPAddressAllowOverride]
GO
ALTER TABLE [dbo].[CMS_BannedIP] ADD  CONSTRAINT [DEFAULT_CMS_BannedIP_IPAddressBanEnabled]  DEFAULT ((0)) FOR [IPAddressBanEnabled]
GO
ALTER TABLE [dbo].[CMS_BannedIP]  WITH CHECK ADD  CONSTRAINT [FK_CMS_BannedIP_IPAddressSiteID_CMS_Site] FOREIGN KEY([IPAddressSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_BannedIP] CHECK CONSTRAINT [FK_CMS_BannedIP_IPAddressSiteID_CMS_Site]
GO
