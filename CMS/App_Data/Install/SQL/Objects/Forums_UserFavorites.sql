SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_UserFavorites](
	[FavoriteID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[PostID] [int] NULL,
	[ForumID] [int] NULL,
	[FavoriteName] [nvarchar](100) NULL,
	[SiteID] [int] NOT NULL,
	[FavoriteGUID] [uniqueidentifier] NOT NULL,
	[FavoriteLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Forums_UserFavorites] PRIMARY KEY CLUSTERED 
(
	[FavoriteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Forums_UserFavorites_ForumID] ON [dbo].[Forums_UserFavorites]
(
	[ForumID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_UserFavorites_PostID] ON [dbo].[Forums_UserFavorites]
(
	[PostID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_UserFavorites_SiteID] ON [dbo].[Forums_UserFavorites]
(
	[SiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Forums_UserFavorites_UserID] ON [dbo].[Forums_UserFavorites]
(
	[UserID] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Forums_UserFavorites_UserID_PostID_ForumID] ON [dbo].[Forums_UserFavorites]
(
	[UserID] ASC,
	[PostID] ASC,
	[ForumID] ASC
)
GO
ALTER TABLE [dbo].[Forums_UserFavorites] ADD  CONSTRAINT [DEFAULT_Forums_UserFavorites_SiteID]  DEFAULT ((0)) FOR [SiteID]
GO
ALTER TABLE [dbo].[Forums_UserFavorites] ADD  CONSTRAINT [DEFAULT_Forums_UserFavorites_FavoriteGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [FavoriteGUID]
GO
ALTER TABLE [dbo].[Forums_UserFavorites] ADD  CONSTRAINT [DEFAULT_Forums_UserFavorites_FavoriteLastModified]  DEFAULT ('12/4/2008 3:23:57 PM') FOR [FavoriteLastModified]
GO
ALTER TABLE [dbo].[Forums_UserFavorites]  WITH CHECK ADD  CONSTRAINT [FK_Forums_UserFavorites_ForumID_Forums_Forum] FOREIGN KEY([ForumID])
REFERENCES [dbo].[Forums_Forum] ([ForumID])
GO
ALTER TABLE [dbo].[Forums_UserFavorites] CHECK CONSTRAINT [FK_Forums_UserFavorites_ForumID_Forums_Forum]
GO
ALTER TABLE [dbo].[Forums_UserFavorites]  WITH CHECK ADD  CONSTRAINT [FK_Forums_UserFavorites_PostID_Forums_ForumPost] FOREIGN KEY([PostID])
REFERENCES [dbo].[Forums_ForumPost] ([PostId])
GO
ALTER TABLE [dbo].[Forums_UserFavorites] CHECK CONSTRAINT [FK_Forums_UserFavorites_PostID_Forums_ForumPost]
GO
ALTER TABLE [dbo].[Forums_UserFavorites]  WITH CHECK ADD  CONSTRAINT [FK_Forums_UserFavorites_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Forums_UserFavorites] CHECK CONSTRAINT [FK_Forums_UserFavorites_SiteID_CMS_Site]
GO
ALTER TABLE [dbo].[Forums_UserFavorites]  WITH CHECK ADD  CONSTRAINT [FK_Forums_UserFavorites_UserID_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Forums_UserFavorites] CHECK CONSTRAINT [FK_Forums_UserFavorites_UserID_CMS_User]
GO
