SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_EmailTemplate](
	[EmailTemplateID] [int] IDENTITY(1,1) NOT NULL,
	[EmailTemplateName] [nvarchar](200) NOT NULL,
	[EmailTemplateDisplayName] [nvarchar](200) NOT NULL,
	[EmailTemplateText] [nvarchar](max) NULL,
	[EmailTemplateSiteID] [int] NULL,
	[EmailTemplateGUID] [uniqueidentifier] NOT NULL,
	[EmailTemplateLastModified] [datetime2](7) NOT NULL,
	[EmailTemplatePlainText] [nvarchar](max) NULL,
	[EmailTemplateSubject] [nvarchar](250) NULL,
	[EmailTemplateFrom] [nvarchar](250) NULL,
	[EmailTemplateCc] [nvarchar](4000) NULL,
	[EmailTemplateBcc] [nvarchar](4000) NULL,
	[EmailTemplateType] [nvarchar](100) NULL,
 CONSTRAINT [PK_CMS_EmailTemplate] PRIMARY KEY NONCLUSTERED 
(
	[EmailTemplateID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_EmailTemplate_EmailTemplateDisplayName] ON [dbo].[CMS_EmailTemplate]
(
	[EmailTemplateDisplayName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_EmailTemplate_EmailTemplateName_EmailTemplateSiteID] ON [dbo].[CMS_EmailTemplate]
(
	[EmailTemplateName] ASC,
	[EmailTemplateSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_EmailTemplate_EmailTemplateSiteID] ON [dbo].[CMS_EmailTemplate]
(
	[EmailTemplateSiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_EmailTemplate] ADD  CONSTRAINT [DEFAULT_CMS_EmailTemplate_EmailTemplateName]  DEFAULT (N'') FOR [EmailTemplateName]
GO
ALTER TABLE [dbo].[CMS_EmailTemplate] ADD  CONSTRAINT [DEFAULT_CMS_EmailTemplate_EmailTemplateDisplayName]  DEFAULT ('') FOR [EmailTemplateDisplayName]
GO
ALTER TABLE [dbo].[CMS_EmailTemplate]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_Email_EmailTemplateSiteID_CMS_Site] FOREIGN KEY([EmailTemplateSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_EmailTemplate] CHECK CONSTRAINT [FK_CMS_Email_EmailTemplateSiteID_CMS_Site]
GO
