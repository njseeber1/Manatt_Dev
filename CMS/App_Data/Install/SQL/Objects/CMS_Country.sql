SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Country](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryDisplayName] [nvarchar](200) NOT NULL,
	[CountryName] [nvarchar](200) NOT NULL,
	[CountryGUID] [uniqueidentifier] NOT NULL,
	[CountryLastModified] [datetime2](7) NOT NULL,
	[CountryTwoLetterCode] [nvarchar](2) NULL,
	[CountryThreeLetterCode] [nvarchar](3) NULL,
 CONSTRAINT [PK_CMS_Country] PRIMARY KEY NONCLUSTERED 
(
	[CountryID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Country_CountryDisplayName] ON [dbo].[CMS_Country]
(
	[CountryDisplayName] ASC
)
GO
ALTER TABLE [dbo].[CMS_Country] ADD  CONSTRAINT [DEFAULT_cms_country_CountryDisplayName]  DEFAULT ('') FOR [CountryDisplayName]
GO
ALTER TABLE [dbo].[CMS_Country] ADD  CONSTRAINT [DEFAULT_cms_country_CountryName]  DEFAULT ('') FOR [CountryName]
GO
ALTER TABLE [dbo].[CMS_Country] ADD  CONSTRAINT [DEFAULT_cms_country_CountryGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CountryGUID]
GO
ALTER TABLE [dbo].[CMS_Country] ADD  CONSTRAINT [DEFAULT_cms_country_CountryLastModified]  DEFAULT ('11/14/2013 1:43:04 PM') FOR [CountryLastModified]
GO
