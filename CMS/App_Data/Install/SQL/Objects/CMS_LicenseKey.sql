SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_LicenseKey](
	[LicenseKeyID] [int] IDENTITY(1,1) NOT NULL,
	[LicenseDomain] [nvarchar](255) NULL,
	[LicenseKey] [nvarchar](max) NULL,
	[LicenseEdition] [nvarchar](200) NULL,
	[LicenseExpiration] [nvarchar](200) NULL,
	[LicensePackages] [nvarchar](100) NULL,
	[LicenseServers] [int] NULL,
 CONSTRAINT [PK_CMS_LicenseKey] PRIMARY KEY NONCLUSTERED 
(
	[LicenseKeyID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_LicenseKey_LicenseDomain] ON [dbo].[CMS_LicenseKey]
(
	[LicenseDomain] ASC
)
GO
