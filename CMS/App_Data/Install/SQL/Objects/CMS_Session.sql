SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Session](
	[SessionIdentificator] [nvarchar](200) NOT NULL,
	[SessionUserID] [int] NULL,
	[SessionLocation] [nvarchar](450) NULL,
	[SessionLastActive] [datetime2](7) NOT NULL,
	[SessionLastLogon] [datetime2](7) NULL,
	[SessionExpires] [datetime2](7) NOT NULL,
	[SessionExpired] [bit] NOT NULL,
	[SessionSiteID] [int] NULL,
	[SessionUserIsHidden] [bit] NOT NULL,
	[SessionFullName] [nvarchar](450) NULL,
	[SessionEmail] [nvarchar](100) NULL,
	[SessionUserName] [nvarchar](100) NULL,
	[SessionNickName] [nvarchar](200) NULL,
	[SessionUserCreated] [datetime2](7) NULL,
	[SessionContactID] [int] NULL,
 CONSTRAINT [PK_CMS_Session] PRIMARY KEY NONCLUSTERED 
(
	[SessionIdentificator] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Session_SessionLocation] ON [dbo].[CMS_Session]
(
	[SessionLocation] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Session_SessionSiteID] ON [dbo].[CMS_Session]
(
	[SessionSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Session_SessionUserID] ON [dbo].[CMS_Session]
(
	[SessionUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Session_SessionUserIsHidden] ON [dbo].[CMS_Session]
(
	[SessionUserIsHidden] ASC
)
GO
ALTER TABLE [dbo].[CMS_Session] ADD  CONSTRAINT [DEFAULT_CMS_Session_SessionLastActive]  DEFAULT ('9/9/2008 3:44:26 PM') FOR [SessionLastActive]
GO
ALTER TABLE [dbo].[CMS_Session] ADD  CONSTRAINT [DEFAULT_CMS_Session_SessionExpires]  DEFAULT ('9/9/2008 3:45:44 PM') FOR [SessionExpires]
GO
ALTER TABLE [dbo].[CMS_Session] ADD  CONSTRAINT [DEFAULT_CMS_Session_SessionExpired]  DEFAULT ((0)) FOR [SessionExpired]
GO
ALTER TABLE [dbo].[CMS_Session]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Session_SessionSiteID_CMS_Site] FOREIGN KEY([SessionSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_Session] CHECK CONSTRAINT [FK_CMS_Session_SessionSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_Session]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Session_SessionUserID_CMS_User] FOREIGN KEY([SessionUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_Session] CHECK CONSTRAINT [FK_CMS_Session_SessionUserID_CMS_User]
GO
