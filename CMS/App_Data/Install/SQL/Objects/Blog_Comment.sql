SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog_Comment](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[CommentUserName] [nvarchar](200) NOT NULL,
	[CommentUserID] [int] NULL,
	[CommentUrl] [nvarchar](450) NULL,
	[CommentText] [nvarchar](max) NOT NULL,
	[CommentApprovedByUserID] [int] NULL,
	[CommentPostDocumentID] [int] NOT NULL,
	[CommentDate] [datetime2](7) NOT NULL,
	[CommentIsSpam] [bit] NULL,
	[CommentApproved] [bit] NULL,
	[CommentEmail] [nvarchar](250) NULL,
	[CommentInfo] [nvarchar](max) NULL,
 CONSTRAINT [PK_Blog_Comment] PRIMARY KEY NONCLUSTERED 
(
	[CommentID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_Blog_Comment_CommentDate] ON [dbo].[Blog_Comment]
(
	[CommentDate] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_Blog_Comment_CommentApprovedByUserID] ON [dbo].[Blog_Comment]
(
	[CommentApprovedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Blog_Comment_CommentPostDocumentID] ON [dbo].[Blog_Comment]
(
	[CommentPostDocumentID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Blog_Comment_CommentUserID] ON [dbo].[Blog_Comment]
(
	[CommentUserID] ASC
)
GO
ALTER TABLE [dbo].[Blog_Comment] ADD  CONSTRAINT [DEFAULT_Blog_Comment_CommentIsSpam]  DEFAULT ((0)) FOR [CommentIsSpam]
GO
ALTER TABLE [dbo].[Blog_Comment] ADD  CONSTRAINT [DEFAULT_Blog_Comment_CommentApproved]  DEFAULT ((0)) FOR [CommentApproved]
GO
ALTER TABLE [dbo].[Blog_Comment]  WITH CHECK ADD  CONSTRAINT [FK_Blog_Comment_CommentApprovedByUserID_CMS_User] FOREIGN KEY([CommentApprovedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Blog_Comment] CHECK CONSTRAINT [FK_Blog_Comment_CommentApprovedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[Blog_Comment]  WITH CHECK ADD  CONSTRAINT [FK_Blog_Comment_CommentPostDocumentID_CMS_Document] FOREIGN KEY([CommentPostDocumentID])
REFERENCES [dbo].[CMS_Document] ([DocumentID])
GO
ALTER TABLE [dbo].[Blog_Comment] CHECK CONSTRAINT [FK_Blog_Comment_CommentPostDocumentID_CMS_Document]
GO
ALTER TABLE [dbo].[Blog_Comment]  WITH CHECK ADD  CONSTRAINT [FK_Blog_Comment_CommentUserID_CMS_User] FOREIGN KEY([CommentUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Blog_Comment] CHECK CONSTRAINT [FK_Blog_Comment_CommentUserID_CMS_User]
GO
