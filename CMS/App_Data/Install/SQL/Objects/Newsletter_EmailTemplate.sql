SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_EmailTemplate](
	[TemplateID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateDisplayName] [nvarchar](250) NOT NULL,
	[TemplateName] [nvarchar](250) NOT NULL,
	[TemplateBody] [nvarchar](max) NOT NULL,
	[TemplateSiteID] [int] NOT NULL,
	[TemplateHeader] [nvarchar](max) NOT NULL,
	[TemplateFooter] [nvarchar](max) NOT NULL,
	[TemplateType] [nvarchar](50) NOT NULL,
	[TemplateStylesheetText] [nvarchar](max) NULL,
	[TemplateGUID] [uniqueidentifier] NOT NULL,
	[TemplateLastModified] [datetime2](7) NOT NULL,
	[TemplateSubject] [nvarchar](450) NULL,
	[TemplateThumbnailGUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Newsletter_EmailTemplate] PRIMARY KEY NONCLUSTERED 
(
	[TemplateID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateDisplayName] ON [dbo].[Newsletter_EmailTemplate]
(
	[TemplateSiteID] ASC,
	[TemplateDisplayName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Newsletter_EmailTemplate_TemplateSiteID_TemplateName] ON [dbo].[Newsletter_EmailTemplate]
(
	[TemplateSiteID] ASC,
	[TemplateName] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_EmailTemplate] ADD  CONSTRAINT [DEFAULT_Newsletter_EmailTemplate_TemplateDisplayName]  DEFAULT ('') FOR [TemplateDisplayName]
GO
ALTER TABLE [dbo].[Newsletter_EmailTemplate] ADD  CONSTRAINT [DEFAULT_Newsletter_EmailTemplate_TemplateName]  DEFAULT ('') FOR [TemplateName]
GO
ALTER TABLE [dbo].[Newsletter_EmailTemplate] ADD  CONSTRAINT [DEFAULT_Newsletter_EmailTemplate_TemplateType]  DEFAULT ('') FOR [TemplateType]
GO
ALTER TABLE [dbo].[Newsletter_EmailTemplate]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_EmailTemplate_TemplateSiteID_CMS_Site] FOREIGN KEY([TemplateSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Newsletter_EmailTemplate] CHECK CONSTRAINT [FK_Newsletter_EmailTemplate_TemplateSiteID_CMS_Site]
GO
