SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Board_Moderator](
	[BoardID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Board_Moderator] PRIMARY KEY CLUSTERED 
(
	[BoardID] ASC,
	[UserID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Board_Moderator_UserID] ON [dbo].[Board_Moderator]
(
	[UserID] ASC
)
GO
ALTER TABLE [dbo].[Board_Moderator]  WITH CHECK ADD  CONSTRAINT [FK_Board_Moderator_BoardID_Board_Board] FOREIGN KEY([BoardID])
REFERENCES [dbo].[Board_Board] ([BoardID])
GO
ALTER TABLE [dbo].[Board_Moderator] CHECK CONSTRAINT [FK_Board_Moderator_BoardID_Board_Board]
GO
ALTER TABLE [dbo].[Board_Moderator]  WITH CHECK ADD  CONSTRAINT [FK_Board_Moderator_UserID_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Board_Moderator] CHECK CONSTRAINT [FK_Board_Moderator_UserID_CMS_User]
GO
