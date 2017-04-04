SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_Link](
	[LinkID] [int] IDENTITY(1,1) NOT NULL,
	[LinkIssueID] [int] NOT NULL,
	[LinkTarget] [nvarchar](max) NOT NULL,
	[LinkDescription] [nvarchar](450) NOT NULL,
	[LinkOutdated] [bit] NOT NULL,
	[LinkGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Newsletter_Link] PRIMARY KEY CLUSTERED 
(
	[LinkID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_Link_LinkIssueID] ON [dbo].[Newsletter_Link]
(
	[LinkIssueID] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_Link] ADD  CONSTRAINT [DF_Newsletter_Link_LinkOutdated]  DEFAULT ((0)) FOR [LinkOutdated]
GO
ALTER TABLE [dbo].[Newsletter_Link]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_Link_Newsletter_NewsletterIssue] FOREIGN KEY([LinkIssueID])
REFERENCES [dbo].[Newsletter_NewsletterIssue] ([IssueID])
GO
ALTER TABLE [dbo].[Newsletter_Link] CHECK CONSTRAINT [FK_Newsletter_Link_Newsletter_NewsletterIssue]
GO
