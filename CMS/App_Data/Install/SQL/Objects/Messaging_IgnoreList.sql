SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messaging_IgnoreList](
	[IgnoreListUserID] [int] NOT NULL,
	[IgnoreListIgnoredUserID] [int] NOT NULL,
 CONSTRAINT [PK_Messaging_IgnoreList] PRIMARY KEY CLUSTERED 
(
	[IgnoreListUserID] ASC,
	[IgnoreListIgnoredUserID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Messaging_IgnoreList_IgnoreListIgnoredUserID] ON [dbo].[Messaging_IgnoreList]
(
	[IgnoreListIgnoredUserID] ASC
)
GO
ALTER TABLE [dbo].[Messaging_IgnoreList]  WITH CHECK ADD  CONSTRAINT [FK_Messaging_IgnoreList_IgnoreListIgnoredUserID_CMS_User] FOREIGN KEY([IgnoreListIgnoredUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Messaging_IgnoreList] CHECK CONSTRAINT [FK_Messaging_IgnoreList_IgnoreListIgnoredUserID_CMS_User]
GO
ALTER TABLE [dbo].[Messaging_IgnoreList]  WITH CHECK ADD  CONSTRAINT [FK_Messaging_IgnoreList_IgnoreListUserID_CMS_User] FOREIGN KEY([IgnoreListUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Messaging_IgnoreList] CHECK CONSTRAINT [FK_Messaging_IgnoreList_IgnoreListUserID_CMS_User]
GO
