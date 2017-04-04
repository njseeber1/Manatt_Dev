SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_NewsletterIssue](
	[IssueID] [int] IDENTITY(1,1) NOT NULL,
	[IssueSubject] [nvarchar](450) NOT NULL,
	[IssueText] [nvarchar](max) NOT NULL,
	[IssueUnsubscribed] [int] NOT NULL,
	[IssueNewsletterID] [int] NOT NULL,
	[IssueTemplateID] [int] NULL,
	[IssueSentEmails] [int] NOT NULL,
	[IssueMailoutTime] [datetime2](7) NULL,
	[IssueShowInNewsletterArchive] [bit] NULL,
	[IssueGUID] [uniqueidentifier] NOT NULL,
	[IssueLastModified] [datetime2](7) NOT NULL,
	[IssueSiteID] [int] NOT NULL,
	[IssueOpenedEmails] [int] NULL,
	[IssueBounces] [int] NULL,
	[IssueStatus] [int] NULL,
	[IssueIsABTest] [bit] NULL,
	[IssueVariantOfIssueID] [int] NULL,
	[IssueVariantName] [nvarchar](200) NULL,
	[IssueSenderName] [nvarchar](200) NULL,
	[IssueSenderEmail] [nvarchar](200) NULL,
	[IssueScheduledTaskID] [int] NULL,
	[IssueUTMSource] [nvarchar](200) NULL,
	[IssueUseUTM] [bit] NOT NULL,
	[IssueUTMCampaign] [nvarchar](200) NULL,
 CONSTRAINT [PK_Newsletter_NewsletterIssue] PRIMARY KEY CLUSTERED 
(
	[IssueID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_NewsletterIssue_IssueNewsletterID] ON [dbo].[Newsletter_NewsletterIssue]
(
	[IssueNewsletterID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_NewsletterIssue_IssueSiteID] ON [dbo].[Newsletter_NewsletterIssue]
(
	[IssueSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_NewsletterIssue_IssueTemplateID] ON [dbo].[Newsletter_NewsletterIssue]
(
	[IssueTemplateID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_NewsletterIssue_IssueVariantOfIssueID] ON [dbo].[Newsletter_NewsletterIssue]
(
	[IssueVariantOfIssueID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newslettes_NewsletterIssue_IssueShowInNewsletterArchive] ON [dbo].[Newsletter_NewsletterIssue]
(
	[IssueShowInNewsletterArchive] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue] ADD  CONSTRAINT [DEFAULT_Newsletter_NewsletterIssue_IssueSubject]  DEFAULT ('') FOR [IssueSubject]
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue] ADD  CONSTRAINT [DEFAULT_Newsletter_NewsletterIssue_IssueSiteID]  DEFAULT ((0)) FOR [IssueSiteID]
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue] ADD  CONSTRAINT [DEFAULT_Newsletter_NewsletterIssue_IssueUseUTM]  DEFAULT ((0)) FOR [IssueUseUTM]
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_NewsletterIssue_IssueNewsletterID_Newsletter_Newsletter] FOREIGN KEY([IssueNewsletterID])
REFERENCES [dbo].[Newsletter_Newsletter] ([NewsletterID])
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue] CHECK CONSTRAINT [FK_Newsletter_NewsletterIssue_IssueNewsletterID_Newsletter_Newsletter]
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_NewsletterIssue_IssueSiteID_CMS_Site] FOREIGN KEY([IssueSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue] CHECK CONSTRAINT [FK_Newsletter_NewsletterIssue_IssueSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_NewsletterIssue_IssueTemplateID_Newsletter_EmailTemplate] FOREIGN KEY([IssueTemplateID])
REFERENCES [dbo].[Newsletter_EmailTemplate] ([TemplateID])
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue] CHECK CONSTRAINT [FK_Newsletter_NewsletterIssue_IssueTemplateID_Newsletter_EmailTemplate]
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_NewsletterIssue_IssueVariantOfIssue_NewsletterIssue] FOREIGN KEY([IssueVariantOfIssueID])
REFERENCES [dbo].[Newsletter_NewsletterIssue] ([IssueID])
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue] CHECK CONSTRAINT [FK_Newsletter_NewsletterIssue_IssueVariantOfIssue_NewsletterIssue]
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_NewsletterIssue_Newsletter_NewsletterIssue] FOREIGN KEY([IssueID])
REFERENCES [dbo].[Newsletter_NewsletterIssue] ([IssueID])
GO
ALTER TABLE [dbo].[Newsletter_NewsletterIssue] CHECK CONSTRAINT [FK_Newsletter_NewsletterIssue_Newsletter_NewsletterIssue]
GO
