SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Polls_PollAnswer](
	[AnswerID] [int] IDENTITY(1,1) NOT NULL,
	[AnswerText] [nvarchar](200) NOT NULL,
	[AnswerOrder] [int] NULL,
	[AnswerCount] [int] NULL,
	[AnswerEnabled] [bit] NULL,
	[AnswerPollID] [int] NOT NULL,
	[AnswerGUID] [uniqueidentifier] NOT NULL,
	[AnswerLastModified] [datetime2](7) NOT NULL,
	[AnswerForm] [nvarchar](100) NULL,
	[AnswerAlternativeForm] [nvarchar](100) NULL,
	[AnswerHideForm] [bit] NULL,
 CONSTRAINT [PK_Polls_PollAnswer] PRIMARY KEY NONCLUSTERED 
(
	[AnswerID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_Polls_PollAnswer_AnswerPollID_AnswerOrder_AnswerEnabled] ON [dbo].[Polls_PollAnswer]
(
	[AnswerOrder] ASC,
	[AnswerPollID] ASC,
	[AnswerEnabled] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Polls_PollAnswer_AnswerPollID] ON [dbo].[Polls_PollAnswer]
(
	[AnswerPollID] ASC
)
GO
ALTER TABLE [dbo].[Polls_PollAnswer] ADD  CONSTRAINT [DEFAULT_Polls_PollAnswer_AnswerText]  DEFAULT (N'') FOR [AnswerText]
GO
ALTER TABLE [dbo].[Polls_PollAnswer] ADD  CONSTRAINT [DEFAULT_Polls_PollAnswer_AnswerHideForm]  DEFAULT ((0)) FOR [AnswerHideForm]
GO
ALTER TABLE [dbo].[Polls_PollAnswer]  WITH CHECK ADD  CONSTRAINT [FK_Polls_PollAnswer_AnswerPollID_Polls_Poll] FOREIGN KEY([AnswerPollID])
REFERENCES [dbo].[Polls_Poll] ([PollID])
GO
ALTER TABLE [dbo].[Polls_PollAnswer] CHECK CONSTRAINT [FK_Polls_PollAnswer_AnswerPollID_Polls_Poll]
GO
