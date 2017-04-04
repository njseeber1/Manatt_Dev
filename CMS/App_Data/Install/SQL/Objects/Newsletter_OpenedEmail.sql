SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_OpenedEmail](
	[OpenedEmailID] [int] IDENTITY(1,1) NOT NULL,
	[OpenedEmailEmail] [nvarchar](400) NOT NULL,
	[OpenedEmailGuid] [uniqueidentifier] NOT NULL,
	[OpenedEmailTime] [datetime2](7) NULL,
	[OpenedEmailIssueID] [int] NOT NULL,
 CONSTRAINT [PK_Newsletter_OpenedEmail] PRIMARY KEY CLUSTERED 
(
	[OpenedEmailID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_OpenedEmail_OpenedEmailIssueID] ON [dbo].[Newsletter_OpenedEmail]
(
	[OpenedEmailIssueID] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_OpenedEmail] ADD  CONSTRAINT [DEFAULT_Newsletter_OpenedEmail_OpenedEmailEmail]  DEFAULT (N'') FOR [OpenedEmailEmail]
GO
ALTER TABLE [dbo].[Newsletter_OpenedEmail] ADD  CONSTRAINT [DEFAULT_Newsletter_OpenedEmail_OpenedEmailGuid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [OpenedEmailGuid]
GO
ALTER TABLE [dbo].[Newsletter_OpenedEmail] ADD  CONSTRAINT [DEFAULT_Newsletter_OpenedEmail_OpenedEmailIssueID]  DEFAULT ((0)) FOR [OpenedEmailIssueID]
GO
ALTER TABLE [dbo].[Newsletter_OpenedEmail]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_OpenedEmail_OpenedEmailIssueID_Newsletter_NewsletterIssue] FOREIGN KEY([OpenedEmailIssueID])
REFERENCES [dbo].[Newsletter_NewsletterIssue] ([IssueID])
GO
ALTER TABLE [dbo].[Newsletter_OpenedEmail] CHECK CONSTRAINT [FK_Newsletter_OpenedEmail_OpenedEmailIssueID_Newsletter_NewsletterIssue]
GO
