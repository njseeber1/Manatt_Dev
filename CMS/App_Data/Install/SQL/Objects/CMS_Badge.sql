SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Badge](
	[BadgeID] [int] IDENTITY(1,1) NOT NULL,
	[BadgeName] [nvarchar](100) NOT NULL,
	[BadgeDisplayName] [nvarchar](200) NOT NULL,
	[BadgeImageURL] [nvarchar](200) NULL,
	[BadgeIsAutomatic] [bit] NOT NULL,
	[BadgeTopLimit] [int] NULL,
	[BadgeGUID] [uniqueidentifier] NOT NULL,
	[BadgeLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CMS_Badge] PRIMARY KEY NONCLUSTERED 
(
	[BadgeID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_Badge_BadgeTopLimit] ON [dbo].[CMS_Badge]
(
	[BadgeTopLimit] DESC
)
GO
ALTER TABLE [dbo].[CMS_Badge] ADD  CONSTRAINT [DEFAULT_Community_Badge_BadgeName]  DEFAULT ('') FOR [BadgeName]
GO
ALTER TABLE [dbo].[CMS_Badge] ADD  CONSTRAINT [DEFAULT_Community_Badge_BadgeDisplayName]  DEFAULT ('') FOR [BadgeDisplayName]
GO
ALTER TABLE [dbo].[CMS_Badge] ADD  CONSTRAINT [DEFAULT_CMS_Badge_BadgeIsAutomatic]  DEFAULT ((0)) FOR [BadgeIsAutomatic]
GO
ALTER TABLE [dbo].[CMS_Badge] ADD  CONSTRAINT [DEFAULT_Community_Badge_BadgeGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [BadgeGUID]
GO
ALTER TABLE [dbo].[CMS_Badge] ADD  CONSTRAINT [DEFAULT_Community_Badge_BadgeLastModified]  DEFAULT ('9/25/2008 5:07:55 PM') FOR [BadgeLastModified]
GO
