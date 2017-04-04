SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WebTemplate](
	[WebTemplateID] [int] IDENTITY(1,1) NOT NULL,
	[WebTemplateDisplayName] [nvarchar](200) NOT NULL,
	[WebTemplateFileName] [nvarchar](100) NOT NULL,
	[WebTemplateDescription] [nvarchar](max) NOT NULL,
	[WebTemplateGUID] [uniqueidentifier] NOT NULL,
	[WebTemplateLastModified] [datetime2](7) NOT NULL,
	[WebTemplateName] [nvarchar](100) NOT NULL,
	[WebTemplateOrder] [int] NOT NULL,
	[WebTemplateLicenses] [nvarchar](200) NOT NULL,
	[WebTemplatePackages] [nvarchar](200) NULL,
	[WebTemplateThumbnailGUID] [uniqueidentifier] NULL,
	[WebTemplateShortDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_WebTemplate] PRIMARY KEY NONCLUSTERED 
(
	[WebTemplateID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_WebTemplate_WebTemplateOrder] ON [dbo].[CMS_WebTemplate]
(
	[WebTemplateOrder] ASC
)
GO
ALTER TABLE [dbo].[CMS_WebTemplate] ADD  CONSTRAINT [DEFAULT_CMS_WebTemplate_WebTemplateDisplayName]  DEFAULT ('') FOR [WebTemplateDisplayName]
GO
ALTER TABLE [dbo].[CMS_WebTemplate] ADD  CONSTRAINT [DEFAULT_CMS_WebTemplate_WebTemplateFileName]  DEFAULT ('') FOR [WebTemplateFileName]
GO
ALTER TABLE [dbo].[CMS_WebTemplate] ADD  CONSTRAINT [DEFAULT_CMS_WebTemplate_WebTemplateName]  DEFAULT ('') FOR [WebTemplateName]
GO
ALTER TABLE [dbo].[CMS_WebTemplate] ADD  CONSTRAINT [DEFAULT_CMS_WebTemplate_WebTemplateOrder]  DEFAULT ((99999)) FOR [WebTemplateOrder]
GO
ALTER TABLE [dbo].[CMS_WebTemplate] ADD  CONSTRAINT [DEFAULT_CMS_WebTemplate_WebTemplateLicenses]  DEFAULT ('') FOR [WebTemplateLicenses]
GO
