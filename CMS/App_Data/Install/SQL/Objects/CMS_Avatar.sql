SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Avatar](
	[AvatarID] [int] IDENTITY(1,1) NOT NULL,
	[AvatarName] [nvarchar](200) NULL,
	[AvatarFileName] [nvarchar](200) NOT NULL,
	[AvatarFileExtension] [nvarchar](10) NOT NULL,
	[AvatarBinary] [varbinary](max) NULL,
	[AvatarType] [nvarchar](50) NOT NULL,
	[AvatarIsCustom] [bit] NOT NULL,
	[AvatarGUID] [uniqueidentifier] NOT NULL,
	[AvatarLastModified] [datetime2](7) NOT NULL,
	[AvatarMimeType] [nvarchar](100) NOT NULL,
	[AvatarFileSize] [int] NOT NULL,
	[AvatarImageHeight] [int] NULL,
	[AvatarImageWidth] [int] NULL,
	[DefaultMaleUserAvatar] [bit] NULL,
	[DefaultFemaleUserAvatar] [bit] NULL,
	[DefaultGroupAvatar] [bit] NULL,
	[DefaultUserAvatar] [bit] NULL,
 CONSTRAINT [PK_CMS_Avatar] PRIMARY KEY NONCLUSTERED 
(
	[AvatarID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Avatar_AvatarName] ON [dbo].[CMS_Avatar]
(
	[AvatarName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Avatar_AvatarGUID] ON [dbo].[CMS_Avatar]
(
	[AvatarGUID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Avatar_AvatarType_AvatarIsCustom] ON [dbo].[CMS_Avatar]
(
	[AvatarType] ASC,
	[AvatarIsCustom] ASC
)
GO
ALTER TABLE [dbo].[CMS_Avatar] ADD  CONSTRAINT [DEFAULT_CMS_Avatar_DefaultMaleUserAvatar]  DEFAULT ((0)) FOR [DefaultMaleUserAvatar]
GO
ALTER TABLE [dbo].[CMS_Avatar] ADD  CONSTRAINT [DEFAULT_CMS_Avatar_DefaultFemaleUserAvatar]  DEFAULT ((0)) FOR [DefaultFemaleUserAvatar]
GO
ALTER TABLE [dbo].[CMS_Avatar] ADD  CONSTRAINT [DEFAULT_CMS_Avatar_DefaultGroupAvatar]  DEFAULT ((0)) FOR [DefaultGroupAvatar]
GO
ALTER TABLE [dbo].[CMS_Avatar] ADD  CONSTRAINT [DEFAULT_CMS_Avatar_DefaultUserAvatar]  DEFAULT ((0)) FOR [DefaultUserAvatar]
GO
