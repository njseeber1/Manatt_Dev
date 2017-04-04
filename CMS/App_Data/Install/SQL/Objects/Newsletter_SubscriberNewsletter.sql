SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_SubscriberNewsletter](
	[SubscriberID] [int] NOT NULL,
	[NewsletterID] [int] NOT NULL,
	[SubscribedWhen] [datetime2](7) NOT NULL,
	[SubscriptionApproved] [bit] NULL,
	[SubscriptionApprovedWhen] [datetime2](7) NULL,
	[SubscriptionApprovalHash] [nvarchar](100) NULL,
	[SubscriberNewsletterID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Newsletter_SubscriberNewsletter] PRIMARY KEY CLUSTERED 
(
	[SubscriberNewsletterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
 CONSTRAINT [UQ_Newsletter_SubscriberNewsletter] UNIQUE NONCLUSTERED 
(
	[SubscriberID] ASC,
	[NewsletterID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_SubscriberNewsletter_NewsletterID] ON [dbo].[Newsletter_SubscriberNewsletter]
(
	[NewsletterID] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_SubscriberNewsletter] ADD  CONSTRAINT [DEFAULT_Newsletter_SubscriberNewsletter_SubscriptionApproved]  DEFAULT ((1)) FOR [SubscriptionApproved]
GO
ALTER TABLE [dbo].[Newsletter_SubscriberNewsletter]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_SubscriberNewsletter_NewsletterID_Newsletter_Newsletter] FOREIGN KEY([NewsletterID])
REFERENCES [dbo].[Newsletter_Newsletter] ([NewsletterID])
GO
ALTER TABLE [dbo].[Newsletter_SubscriberNewsletter] CHECK CONSTRAINT [FK_Newsletter_SubscriberNewsletter_NewsletterID_Newsletter_Newsletter]
GO
ALTER TABLE [dbo].[Newsletter_SubscriberNewsletter]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_SubscriberNewsletter_SubscriberID_Newsletter_Subscriber] FOREIGN KEY([SubscriberID])
REFERENCES [dbo].[Newsletter_Subscriber] ([SubscriberID])
GO
ALTER TABLE [dbo].[Newsletter_SubscriberNewsletter] CHECK CONSTRAINT [FK_Newsletter_SubscriberNewsletter_SubscriberID_Newsletter_Subscriber]
GO
