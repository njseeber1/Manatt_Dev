SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_ABTest](
	[TestID] [int] IDENTITY(1,1) NOT NULL,
	[TestIssueID] [int] NOT NULL,
	[TestWinnerOption] [int] NOT NULL,
	[TestSelectWinnerAfter] [int] NULL,
	[TestWinnerIssueID] [int] NULL,
	[TestWinnerSelected] [datetime2](7) NULL,
	[TestLastModified] [datetime2](7) NOT NULL,
	[TestGUID] [uniqueidentifier] NOT NULL,
	[TestWinnerScheduledTaskID] [int] NULL,
	[TestSizePercentage] [int] NOT NULL,
	[TestNumberPerVariantEmails] [int] NULL,
 CONSTRAINT [PK_Newsletter_ABTest] PRIMARY KEY CLUSTERED 
(
	[TestID] ASC
)
)

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Newsletter_ABTest_TestIssueID] ON [dbo].[Newsletter_ABTest]
(
	[TestIssueID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_ABTest_TestWinnerIssueID] ON [dbo].[Newsletter_ABTest]
(
	[TestWinnerIssueID] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_ABTest] ADD  CONSTRAINT [DEFAULT_Newsletter_ABTest_TestLastModified]  DEFAULT ('12/5/2011 4:56:38 PM') FOR [TestLastModified]
GO
ALTER TABLE [dbo].[Newsletter_ABTest] ADD  CONSTRAINT [DEFAULT_Newsletter_ABTest_TestSizePercentage]  DEFAULT ((0)) FOR [TestSizePercentage]
GO
ALTER TABLE [dbo].[Newsletter_ABTest]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_ABTest_Newsletter_NewsletterIssue] FOREIGN KEY([TestIssueID])
REFERENCES [dbo].[Newsletter_NewsletterIssue] ([IssueID])
GO
ALTER TABLE [dbo].[Newsletter_ABTest] CHECK CONSTRAINT [FK_Newsletter_ABTest_Newsletter_NewsletterIssue]
GO
