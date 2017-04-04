SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_UserSettings](
	[UserSettingsID] [int] IDENTITY(1,1) NOT NULL,
	[UserNickName] [nvarchar](200) NULL,
	[UserPicture] [nvarchar](200) NULL,
	[UserSignature] [nvarchar](max) NULL,
	[UserURLReferrer] [nvarchar](450) NULL,
	[UserCampaign] [nvarchar](200) NULL,
	[UserMessagingNotificationEmail] [nvarchar](200) NULL,
	[UserCustomData] [nvarchar](max) NULL,
	[UserRegistrationInfo] [nvarchar](max) NULL,
	[UserPreferences] [nvarchar](max) NULL,
	[UserActivationDate] [datetime2](7) NULL,
	[UserActivatedByUserID] [int] NULL,
	[UserTimeZoneID] [int] NULL,
	[UserAvatarID] [int] NULL,
	[UserBadgeID] [int] NULL,
	[UserActivityPoints] [int] NULL,
	[UserForumPosts] [int] NULL,
	[UserBlogComments] [int] NULL,
	[UserGender] [int] NULL,
	[UserDateOfBirth] [datetime2](7) NULL,
	[UserMessageBoardPosts] [int] NULL,
	[UserSettingsUserGUID] [uniqueidentifier] NOT NULL,
	[UserSettingsUserID] [int] NOT NULL,
	[WindowsLiveID] [nvarchar](50) NULL,
	[UserBlogPosts] [int] NULL,
	[UserWaitingForApproval] [bit] NULL,
	[UserDialogsConfiguration] [nvarchar](max) NULL,
	[UserDescription] [nvarchar](max) NULL,
	[UserUsedWebParts] [nvarchar](1000) NULL,
	[UserUsedWidgets] [nvarchar](1000) NULL,
	[UserFacebookID] [nvarchar](100) NULL,
	[UserAuthenticationGUID] [uniqueidentifier] NULL,
	[UserSkype] [nvarchar](100) NULL,
	[UserIM] [nvarchar](100) NULL,
	[UserPhone] [nvarchar](26) NULL,
	[UserPosition] [nvarchar](200) NULL,
	[UserBounces] [int] NULL,
	[UserLinkedInID] [nvarchar](100) NULL,
	[UserLogActivities] [bit] NULL,
	[UserPasswordRequestHash] [nvarchar](100) NULL,
	[UserInvalidLogOnAttempts] [int] NULL,
	[UserInvalidLogOnAttemptsHash] [nvarchar](100) NULL,
	[UserAvatarType] [nvarchar](200) NULL,
	[UserAccountLockReason] [int] NULL,
	[UserPasswordLastChanged] [datetime2](7) NULL,
	[UserDataComUser] [nvarchar](200) NULL,
	[UserDataComPassword] [nvarchar](200) NULL,
	[UserShowIntroductionTile] [bit] NULL,
	[UserDashboardApplications] [nvarchar](max) NULL,
	[UserDismissedSmartTips] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_UserSettings] PRIMARY KEY CLUSTERED 
(
	[UserSettingsID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserActivatedByUserID] ON [dbo].[CMS_UserSettings]
(
	[UserActivatedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserAuthenticationGUID] ON [dbo].[CMS_UserSettings]
(
	[UserAuthenticationGUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserAvatarID] ON [dbo].[CMS_UserSettings]
(
	[UserAvatarID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserBadgeID] ON [dbo].[CMS_UserSettings]
(
	[UserBadgeID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserFacebookID] ON [dbo].[CMS_UserSettings]
(
	[UserFacebookID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserGender] ON [dbo].[CMS_UserSettings]
(
	[UserGender] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserNickName] ON [dbo].[CMS_UserSettings]
(
	[UserNickName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserPasswordRequestHash] ON [dbo].[CMS_UserSettings]
(
	[UserPasswordRequestHash] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserSettingsUserGUID] ON [dbo].[CMS_UserSettings]
(
	[UserSettingsUserGUID] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserSettingsUserID] ON [dbo].[CMS_UserSettings]
(
	[UserSettingsUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserTimeZoneID] ON [dbo].[CMS_UserSettings]
(
	[UserTimeZoneID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_UserWaitingForApproval] ON [dbo].[CMS_UserSettings]
(
	[UserWaitingForApproval] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSettings_WindowsLiveID] ON [dbo].[CMS_UserSettings]
(
	[WindowsLiveID] ASC
)
GO
ALTER TABLE [dbo].[CMS_UserSettings] ADD  CONSTRAINT [DEFAULT_CMS_UserSettings_UserSettingsUserGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [UserSettingsUserGUID]
GO
ALTER TABLE [dbo].[CMS_UserSettings] ADD  CONSTRAINT [DEFAULT_CMS_UserSettings_UserSettingsUserID]  DEFAULT ((0)) FOR [UserSettingsUserID]
GO
ALTER TABLE [dbo].[CMS_UserSettings] ADD  CONSTRAINT [DEFAULT_CMS_UserSettings_UserWaitingForApproval]  DEFAULT ((0)) FOR [UserWaitingForApproval]
GO
ALTER TABLE [dbo].[CMS_UserSettings] ADD  CONSTRAINT [DEFAULT_CMS_UserSettings_UserInvalidLogOnAttempts]  DEFAULT ((0)) FOR [UserInvalidLogOnAttempts]
GO
ALTER TABLE [dbo].[CMS_UserSettings] ADD  CONSTRAINT [DEFAULT_CMS_UserSettings_UserAccountLockReason]  DEFAULT ((0)) FOR [UserAccountLockReason]
GO
ALTER TABLE [dbo].[CMS_UserSettings]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_UserSettings_UserActivatedByUserID_CMS_User] FOREIGN KEY([UserActivatedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_UserSettings] CHECK CONSTRAINT [FK_CMS_UserSettings_UserActivatedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_UserSettings]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_UserSettings_UserAvatarID_CMS_Avatar] FOREIGN KEY([UserAvatarID])
REFERENCES [dbo].[CMS_Avatar] ([AvatarID])
GO
ALTER TABLE [dbo].[CMS_UserSettings] CHECK CONSTRAINT [FK_CMS_UserSettings_UserAvatarID_CMS_Avatar]
GO
ALTER TABLE [dbo].[CMS_UserSettings]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_UserSettings_UserBadgeID_CMS_Badge] FOREIGN KEY([UserBadgeID])
REFERENCES [dbo].[CMS_Badge] ([BadgeID])
GO
ALTER TABLE [dbo].[CMS_UserSettings] CHECK CONSTRAINT [FK_CMS_UserSettings_UserBadgeID_CMS_Badge]
GO
ALTER TABLE [dbo].[CMS_UserSettings]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_UserSettings_UserSettingsUserGUID_CMS_User] FOREIGN KEY([UserSettingsUserGUID])
REFERENCES [dbo].[CMS_User] ([UserGUID])
GO
ALTER TABLE [dbo].[CMS_UserSettings] CHECK CONSTRAINT [FK_CMS_UserSettings_UserSettingsUserGUID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_UserSettings]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_UserSettings_UserSettingsUserID_CMS_User] FOREIGN KEY([UserSettingsUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_UserSettings] CHECK CONSTRAINT [FK_CMS_UserSettings_UserSettingsUserID_CMS_User]
GO
ALTER TABLE [dbo].[CMS_UserSettings]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_UserSettings_UserTimeZoneID_CMS_TimeZone] FOREIGN KEY([UserTimeZoneID])
REFERENCES [dbo].[CMS_TimeZone] ([TimeZoneID])
GO
ALTER TABLE [dbo].[CMS_UserSettings] CHECK CONSTRAINT [FK_CMS_UserSettings_UserTimeZoneID_CMS_TimeZone]
GO
