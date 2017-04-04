SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Analytics_Conversion](
	[ConversionID] [int] IDENTITY(1,1) NOT NULL,
	[ConversionName] [nvarchar](200) NOT NULL,
	[ConversionDisplayName] [nvarchar](200) NOT NULL,
	[ConversionDescription] [nvarchar](max) NULL,
	[ConversionGUID] [uniqueidentifier] NOT NULL,
	[ConversionLastModified] [datetime2](7) NOT NULL,
	[ConversionSiteID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_Conversion] PRIMARY KEY CLUSTERED 
(
	[ConversionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Analytics_Conversion_ConversionSiteID] ON [dbo].[Analytics_Conversion]
(
	[ConversionSiteID] ASC
)
GO
ALTER TABLE [dbo].[Analytics_Conversion]  WITH CHECK ADD  CONSTRAINT [FK_Analytics_Conversion_ConversionSiteID_CMS_Site] FOREIGN KEY([ConversionSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Analytics_Conversion] CHECK CONSTRAINT [FK_Analytics_Conversion_ConversionSiteID_CMS_Site]
GO
