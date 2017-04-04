SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_Unsubscription](
	[UnsubscriptionID] [int] IDENTITY(1,1) NOT NULL,
	[UnsubscriptionEmail] [nvarchar](400) NOT NULL,
	[UnsubscriptionSiteID] [int] NULL,
	[UnsubscriptionCreated] [datetime2](7) NOT NULL,
	[UnsubscriptionNewsletterID] [int] NULL,
	[UnsubscriptionFromIssueID] [int] NULL,
	[UnsubscriptionGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Newsletter_Unsubscription] PRIMARY KEY CLUSTERED 
(
	[UnsubscriptionID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Unsubscription_Email_NewsletterID_SiteID] ON [dbo].[Newsletter_Unsubscription]
(
	[UnsubscriptionEmail] ASC,
	[UnsubscriptionNewsletterID] ASC,
	[UnsubscriptionSiteID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Unsubscription_NewsletterID_SiteID] ON [dbo].[Newsletter_Unsubscription]
(
	[UnsubscriptionEmail] ASC,
	[UnsubscriptionNewsletterID] ASC,
	[UnsubscriptionSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Unsubscription_UnsubscriptionFromIssueID] ON [dbo].[Newsletter_Unsubscription]
(
	[UnsubscriptionFromIssueID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Unsubscription_UnsubscriptionSiteID] ON [dbo].[Newsletter_Unsubscription]
(
	[UnsubscriptionSiteID] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_Unsubscription] ADD  CONSTRAINT [DEFAULT_Newsletter_Unsubscription_UnsubscriptionSiteID]  DEFAULT ((0)) FOR [UnsubscriptionSiteID]
GO
ALTER TABLE [dbo].[Newsletter_Unsubscription]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_Unsubscription_UnsubscriptionFromIssueID_Newsletter_NewsletterIssue] FOREIGN KEY([UnsubscriptionFromIssueID])
REFERENCES [dbo].[Newsletter_NewsletterIssue] ([IssueID])
GO
ALTER TABLE [dbo].[Newsletter_Unsubscription] CHECK CONSTRAINT [FK_Newsletter_Unsubscription_UnsubscriptionFromIssueID_Newsletter_NewsletterIssue]
GO
ALTER TABLE [dbo].[Newsletter_Unsubscription]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_Unsubscription_UnsubscriptionNewsletterID_Newsletter_Newsletter] FOREIGN KEY([UnsubscriptionNewsletterID])
REFERENCES [dbo].[Newsletter_Newsletter] ([NewsletterID])
GO
ALTER TABLE [dbo].[Newsletter_Unsubscription] CHECK CONSTRAINT [FK_Newsletter_Unsubscription_UnsubscriptionNewsletterID_Newsletter_Newsletter]
GO
ALTER TABLE [dbo].[Newsletter_Unsubscription]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_Unsubscription_UnsubscriptionSiteID_CMS_Site] FOREIGN KEY([UnsubscriptionSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Newsletter_Unsubscription] CHECK CONSTRAINT [FK_Newsletter_Unsubscription_UnsubscriptionSiteID_CMS_Site]
GO
