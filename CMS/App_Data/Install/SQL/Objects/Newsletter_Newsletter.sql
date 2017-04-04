SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_Newsletter](
	[NewsletterID] [int] IDENTITY(1,1) NOT NULL,
	[NewsletterDisplayName] [nvarchar](250) NOT NULL,
	[NewsletterName] [nvarchar](250) NOT NULL,
	[NewsletterType] [nvarchar](5) NOT NULL,
	[NewsletterSubscriptionTemplateID] [int] NOT NULL,
	[NewsletterUnsubscriptionTemplateID] [int] NOT NULL,
	[NewsletterSenderName] [nvarchar](200) NOT NULL,
	[NewsletterSenderEmail] [nvarchar](200) NOT NULL,
	[NewsletterDynamicSubject] [nvarchar](100) NULL,
	[NewsletterDynamicURL] [nvarchar](500) NULL,
	[NewsletterDynamicScheduledTaskID] [int] NULL,
	[NewsletterTemplateID] [int] NULL,
	[NewsletterSiteID] [int] NOT NULL,
	[NewsletterGUID] [uniqueidentifier] NOT NULL,
	[NewsletterUnsubscribeUrl] [nvarchar](1000) NULL,
	[NewsletterBaseUrl] [nvarchar](500) NULL,
	[NewsletterLastModified] [datetime2](7) NOT NULL,
	[NewsletterEnableOptIn] [bit] NULL,
	[NewsletterOptInTemplateID] [int] NULL,
	[NewsletterSendOptInConfirmation] [bit] NULL,
	[NewsletterOptInApprovalURL] [nvarchar](450) NULL,
	[NewsletterTrackOpenEmails] [bit] NULL,
	[NewsletterTrackClickedLinks] [bit] NULL,
	[NewsletterDraftEmails] [nvarchar](450) NULL,
	[NewsletterLogActivity] [bit] NULL,
	[NewsletterEnableResending] [bit] NULL,
 CONSTRAINT [PK_Newsletter_Newsletter] PRIMARY KEY NONCLUSTERED 
(
	[NewsletterID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterDisplayName] ON [dbo].[Newsletter_Newsletter]
(
	[NewsletterSiteID] ASC,
	[NewsletterDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Newsletter_NewsletterOptInTemplateID] ON [dbo].[Newsletter_Newsletter]
(
	[NewsletterOptInTemplateID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Newsletter_Newsletter_NewsletterSiteID_NewsletterName] ON [dbo].[Newsletter_Newsletter]
(
	[NewsletterSiteID] ASC,
	[NewsletterName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Newsletter_NewsletterSubscriptionTemplateID] ON [dbo].[Newsletter_Newsletter]
(
	[NewsletterSubscriptionTemplateID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Newsletter_NewsletterTemplateID] ON [dbo].[Newsletter_Newsletter]
(
	[NewsletterTemplateID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID] ON [dbo].[Newsletter_Newsletter]
(
	[NewsletterUnsubscriptionTemplateID] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterDisplayName]  DEFAULT ('') FOR [NewsletterDisplayName]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterName]  DEFAULT ('') FOR [NewsletterName]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterType]  DEFAULT ('T') FOR [NewsletterType]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterSenderName]  DEFAULT ('') FOR [NewsletterSenderName]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterSenderEmail]  DEFAULT ('') FOR [NewsletterSenderEmail]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterLastModified]  DEFAULT ('3/13/2015 2:53:28 PM') FOR [NewsletterLastModified]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterEnableOptIn]  DEFAULT ((0)) FOR [NewsletterEnableOptIn]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterSendOptInConfirmation]  DEFAULT ((0)) FOR [NewsletterSendOptInConfirmation]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterTrackOpenEmails]  DEFAULT ((1)) FOR [NewsletterTrackOpenEmails]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterTrackClickedLinks]  DEFAULT ((1)) FOR [NewsletterTrackClickedLinks]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterLogActivity]  DEFAULT ((1)) FOR [NewsletterLogActivity]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_Newsletter_NewsletterEnableResending]  DEFAULT ((1)) FOR [NewsletterEnableResending]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter]  WITH NOCHECK ADD  CONSTRAINT [FK_Newsletter_Newsletter_NewsletterOptInTemplateID_EmailTemplate] FOREIGN KEY([NewsletterOptInTemplateID])
REFERENCES [dbo].[Newsletter_EmailTemplate] ([TemplateID])
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] CHECK CONSTRAINT [FK_Newsletter_Newsletter_NewsletterOptInTemplateID_EmailTemplate]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_Newsletter_NewsletterSiteID_CMS_Site] FOREIGN KEY([NewsletterSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] CHECK CONSTRAINT [FK_Newsletter_Newsletter_NewsletterSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_Newsletter_NewsletterSubscriptionTemplateID_Newsletter_EmailTemplate] FOREIGN KEY([NewsletterSubscriptionTemplateID])
REFERENCES [dbo].[Newsletter_EmailTemplate] ([TemplateID])
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] CHECK CONSTRAINT [FK_Newsletter_Newsletter_NewsletterSubscriptionTemplateID_Newsletter_EmailTemplate]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_Newsletter_NewsletterTemplateID_Newsletter_EmailTemplate] FOREIGN KEY([NewsletterTemplateID])
REFERENCES [dbo].[Newsletter_EmailTemplate] ([TemplateID])
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] CHECK CONSTRAINT [FK_Newsletter_Newsletter_NewsletterTemplateID_Newsletter_EmailTemplate]
GO
ALTER TABLE [dbo].[Newsletter_Newsletter]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID_Newsletter_EmailTemplate] FOREIGN KEY([NewsletterUnsubscriptionTemplateID])
REFERENCES [dbo].[Newsletter_EmailTemplate] ([TemplateID])
GO
ALTER TABLE [dbo].[Newsletter_Newsletter] CHECK CONSTRAINT [FK_Newsletter_Newsletter_NewsletterUnsubscriptionTemplateID_Newsletter_EmailTemplate]
GO
