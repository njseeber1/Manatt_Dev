SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_ForumModerators](
	[UserID] [int] NOT NULL,
	[ForumID] [int] NOT NULL,
 CONSTRAINT [PK_Forums_ForumModerators] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[ForumID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Forums_ForumModerators_ForumID] ON [dbo].[Forums_ForumModerators]
(
	[ForumID] ASC
)
GO
ALTER TABLE [dbo].[Forums_ForumModerators]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumModerators_ForumID_Forums_Forum] FOREIGN KEY([ForumID])
REFERENCES [dbo].[Forums_Forum] ([ForumID])
GO
ALTER TABLE [dbo].[Forums_ForumModerators] CHECK CONSTRAINT [FK_Forums_ForumModerators_ForumID_Forums_Forum]
GO
ALTER TABLE [dbo].[Forums_ForumModerators]  WITH CHECK ADD  CONSTRAINT [FK_Forums_ForumModerators_UserID_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Forums_ForumModerators] CHECK CONSTRAINT [FK_Forums_ForumModerators_UserID_CMS_User]
GO
