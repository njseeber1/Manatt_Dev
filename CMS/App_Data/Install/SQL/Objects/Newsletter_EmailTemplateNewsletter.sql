SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_EmailTemplateNewsletter](
	[TemplateID] [int] NOT NULL,
	[NewsletterID] [int] NOT NULL,
 CONSTRAINT [PK_Newsletter_EmailTemplateNewsletter] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC,
	[NewsletterID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_EmailTemplateNewsletter_NewsletterID] ON [dbo].[Newsletter_EmailTemplateNewsletter]
(
	[NewsletterID] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_EmailTemplateNewsletter]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_EmailTemplateNewsletter_Newsletter_EmailTemplate] FOREIGN KEY([TemplateID])
REFERENCES [dbo].[Newsletter_EmailTemplate] ([TemplateID])
GO
ALTER TABLE [dbo].[Newsletter_EmailTemplateNewsletter] CHECK CONSTRAINT [FK_Newsletter_EmailTemplateNewsletter_Newsletter_EmailTemplate]
GO
ALTER TABLE [dbo].[Newsletter_EmailTemplateNewsletter]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_EmailTemplateNewsletter_Newsletter_Newsletter] FOREIGN KEY([NewsletterID])
REFERENCES [dbo].[Newsletter_Newsletter] ([NewsletterID])
GO
ALTER TABLE [dbo].[Newsletter_EmailTemplateNewsletter] CHECK CONSTRAINT [FK_Newsletter_EmailTemplateNewsletter_Newsletter_Newsletter]
GO
