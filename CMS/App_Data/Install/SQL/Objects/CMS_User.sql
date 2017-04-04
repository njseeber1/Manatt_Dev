SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[MiddleName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[FullName] [nvarchar](450) NULL,
	[Email] [nvarchar](100) NULL,
	[UserPassword] [nvarchar](100) NOT NULL,
	[PreferredCultureCode] [nvarchar](10) NULL,
	[PreferredUICultureCode] [nvarchar](10) NULL,
	[UserEnabled] [bit] NOT NULL,
	[UserIsEditor] [bit] NOT NULL,
	[UserIsGlobalAdministrator] [bit] NOT NULL,
	[UserIsExternal] [bit] NULL,
	[UserPasswordFormat] [nvarchar](10) NULL,
	[UserCreated] [datetime2](7) NULL,
	[LastLogon] [datetime2](7) NULL,
	[UserStartingAliasPath] [nvarchar](200) NULL,
	[UserGUID] [uniqueidentifier] NOT NULL,
	[UserLastModified] [datetime2](7) NOT NULL,
	[UserLastLogonInfo] [nvarchar](max) NULL,
	[UserIsHidden] [bit] NULL,
	[UserVisibility] [nvarchar](max) NULL,
	[UserIsDomain] [bit] NULL,
	[UserHasAllowedCultures] [bit] NULL,
	[UserSiteManagerDisabled] [bit] NULL,
	[UserTokenID] [uniqueidentifier] NULL,
	[UserMFRequired] [bit] NULL,
	[UserTokenIteration] [int] NULL,
 CONSTRAINT [PK_CMS_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_User_Email] ON [dbo].[CMS_User]
(
	[Email] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_User_FullName] ON [dbo].[CMS_User]
(
	[FullName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_User_UserEnabled_UserIsHidden] ON [dbo].[CMS_User]
(
	[UserEnabled] ASC,
	[UserIsHidden] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_User_UserGUID] ON [dbo].[CMS_User]
(
	[UserGUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_User_UserIsEditor] ON [dbo].[CMS_User]
(
	[UserIsEditor] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_User_UserIsGlobalAdministrator] ON [dbo].[CMS_User]
(
	[UserIsGlobalAdministrator] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_User_UserName] ON [dbo].[CMS_User]
(
	[UserName] ASC
)
GO
ALTER TABLE [dbo].[CMS_User] ADD  CONSTRAINT [DEFAULT_CMS_User_UserName]  DEFAULT ('') FOR [UserName]
GO
ALTER TABLE [dbo].[CMS_User] ADD  CONSTRAINT [DEFAULT_CMS_User_UserPassword]  DEFAULT (N'') FOR [UserPassword]
GO
ALTER TABLE [dbo].[CMS_User] ADD  CONSTRAINT [DEFAULT_CMS_User_UserEnabled]  DEFAULT ((0)) FOR [UserEnabled]
GO
ALTER TABLE [dbo].[CMS_User] ADD  CONSTRAINT [DEFAULT_CMS_User_UserIsEditor]  DEFAULT ((0)) FOR [UserIsEditor]
GO
ALTER TABLE [dbo].[CMS_User] ADD  CONSTRAINT [DEFAULT_CMS_User_UserIsGlobalAdministrator]  DEFAULT ((0)) FOR [UserIsGlobalAdministrator]
GO
ALTER TABLE [dbo].[CMS_User] ADD  CONSTRAINT [DEFAULT_CMS_User_UserIsExternal]  DEFAULT ((0)) FOR [UserIsExternal]
GO
ALTER TABLE [dbo].[CMS_User] ADD  CONSTRAINT [DEFAULT_CMS_User_UserIsHidden]  DEFAULT ((0)) FOR [UserIsHidden]
GO
ALTER TABLE [dbo].[CMS_User] ADD  CONSTRAINT [DEFAULT_CMS_User_UserIsDomain]  DEFAULT ((0)) FOR [UserIsDomain]
GO
ALTER TABLE [dbo].[CMS_User] ADD  CONSTRAINT [DEFAULT_CMS_User_UserSiteManagerDisabled]  DEFAULT ((0)) FOR [UserSiteManagerDisabled]
GO
