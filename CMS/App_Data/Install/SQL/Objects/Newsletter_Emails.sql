SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_Emails](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[EmailNewsletterIssueID] [int] NOT NULL,
	[EmailSubscriberID] [int] NOT NULL,
	[EmailSiteID] [int] NOT NULL,
	[EmailLastSendResult] [nvarchar](max) NULL,
	[EmailLastSendAttempt] [datetime2](7) NULL,
	[EmailSending] [bit] NULL,
	[EmailGUID] [uniqueidentifier] NOT NULL,
	[EmailUserID] [int] NULL,
	[EmailContactID] [int] NULL,
	[EmailAddress] [nvarchar](200) NULL,
 CONSTRAINT [PK_Newsletter_Emails] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)
)

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Newsletter_Emails_EmailGUID] ON [dbo].[Newsletter_Emails]
(
	[EmailGUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Emails_EmailNewsletterIssueID] ON [dbo].[Newsletter_Emails]
(
	[EmailNewsletterIssueID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Emails_EmailSending] ON [dbo].[Newsletter_Emails]
(
	[EmailSending] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Emails_EmailSiteID] ON [dbo].[Newsletter_Emails]
(
	[EmailSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Emails_EmailSubscriberID] ON [dbo].[Newsletter_Emails]
(
	[EmailSubscriberID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Emails_EmailUserID] ON [dbo].[Newsletter_Emails]
(
	[EmailUserID] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_Emails] ADD  CONSTRAINT [DEFAULT_Newsletter_Emails_EmailSiteID]  DEFAULT ((0)) FOR [EmailSiteID]
GO
ALTER TABLE [dbo].[Newsletter_Emails]  WITH NOCHECK ADD  CONSTRAINT [FK_Newsletter_Emails_CMS_User] FOREIGN KEY([EmailUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Newsletter_Emails] CHECK CONSTRAINT [FK_Newsletter_Emails_CMS_User]
GO
ALTER TABLE [dbo].[Newsletter_Emails]  WITH NOCHECK ADD  CONSTRAINT [FK_Newsletter_Emails_EmailNewsletterIssueID_Newsletter_NewsletterIssue] FOREIGN KEY([EmailNewsletterIssueID])
REFERENCES [dbo].[Newsletter_NewsletterIssue] ([IssueID])
GO
ALTER TABLE [dbo].[Newsletter_Emails] CHECK CONSTRAINT [FK_Newsletter_Emails_EmailNewsletterIssueID_Newsletter_NewsletterIssue]
GO
ALTER TABLE [dbo].[Newsletter_Emails]  WITH NOCHECK ADD  CONSTRAINT [FK_Newsletter_Emails_EmailSiteID_CMS_Site] FOREIGN KEY([EmailSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Newsletter_Emails] CHECK CONSTRAINT [FK_Newsletter_Emails_EmailSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[Newsletter_Emails]  WITH NOCHECK ADD  CONSTRAINT [FK_Newsletter_Emails_EmailSubscriberID_Newsletter_Subscriber] FOREIGN KEY([EmailSubscriberID])
REFERENCES [dbo].[Newsletter_Subscriber] ([SubscriberID])
GO
ALTER TABLE [dbo].[Newsletter_Emails] CHECK CONSTRAINT [FK_Newsletter_Emails_EmailSubscriberID_Newsletter_Subscriber]
GO
