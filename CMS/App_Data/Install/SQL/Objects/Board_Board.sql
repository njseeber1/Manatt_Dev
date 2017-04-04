SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Board_Board](
	[BoardID] [int] IDENTITY(1,1) NOT NULL,
	[BoardName] [nvarchar](250) NOT NULL,
	[BoardDisplayName] [nvarchar](250) NOT NULL,
	[BoardDescription] [nvarchar](max) NOT NULL,
	[BoardOpened] [bit] NOT NULL,
	[BoardOpenedFrom] [datetime2](7) NULL,
	[BoardOpenedTo] [datetime2](7) NULL,
	[BoardEnabled] [bit] NOT NULL,
	[BoardAccess] [int] NOT NULL,
	[BoardModerated] [bit] NOT NULL,
	[BoardUseCaptcha] [bit] NOT NULL,
	[BoardMessages] [int] NOT NULL,
	[BoardLastModified] [datetime2](7) NOT NULL,
	[BoardGUID] [uniqueidentifier] NOT NULL,
	[BoardDocumentID] [int] NOT NULL,
	[BoardUserID] [int] NULL,
	[BoardGroupID] [int] NULL,
	[BoardLastMessageTime] [datetime2](7) NULL,
	[BoardLastMessageUserName] [nvarchar](250) NULL,
	[BoardUnsubscriptionURL] [nvarchar](450) NULL,
	[BoardRequireEmails] [bit] NULL,
	[BoardSiteID] [int] NOT NULL,
	[BoardEnableSubscriptions] [bit] NOT NULL,
	[BoardBaseURL] [nvarchar](450) NULL,
	[BoardLogActivity] [bit] NULL,
	[BoardEnableOptIn] [bit] NULL,
	[BoardSendOptInConfirmation] [bit] NULL,
	[BoardOptInApprovalURL] [nvarchar](450) NULL,
 CONSTRAINT [PK_Board_Board] PRIMARY KEY CLUSTERED 
(
	[BoardID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Board_Board_BoardDocumentID_BoardName] ON [dbo].[Board_Board]
(
	[BoardDocumentID] ASC,
	[BoardName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Board_Board_BoardGroupID_BoardName] ON [dbo].[Board_Board]
(
	[BoardGroupID] ASC,
	[BoardName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Board_Board_BoardSiteID] ON [dbo].[Board_Board]
(
	[BoardSiteID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Board_Board_BoardUserID_BoardName] ON [dbo].[Board_Board]
(
	[BoardUserID] ASC,
	[BoardName] ASC
)
GO
ALTER TABLE [dbo].[Board_Board] ADD  CONSTRAINT [DEFAULT_Board_Board_BoardName]  DEFAULT ('') FOR [BoardName]
GO
ALTER TABLE [dbo].[Board_Board] ADD  CONSTRAINT [DEFAULT_Board_Board_BoardRequireEmails]  DEFAULT ((0)) FOR [BoardRequireEmails]
GO
ALTER TABLE [dbo].[Board_Board] ADD  CONSTRAINT [DEFAULT_Board_Board_BoardEnableSubscriptions]  DEFAULT ((0)) FOR [BoardEnableSubscriptions]
GO
ALTER TABLE [dbo].[Board_Board]  WITH CHECK ADD  CONSTRAINT [FK_Board_Board_BoardDocumentID_CMS_Document] FOREIGN KEY([BoardDocumentID])
REFERENCES [dbo].[CMS_Document] ([DocumentID])
GO
ALTER TABLE [dbo].[Board_Board] CHECK CONSTRAINT [FK_Board_Board_BoardDocumentID_CMS_Document]
GO
ALTER TABLE [dbo].[Board_Board]  WITH CHECK ADD  CONSTRAINT [FK_Board_Board_BoardGroupID_Community_Group] FOREIGN KEY([BoardGroupID])
REFERENCES [dbo].[Community_Group] ([GroupID])
GO
ALTER TABLE [dbo].[Board_Board] CHECK CONSTRAINT [FK_Board_Board_BoardGroupID_Community_Group]
GO
ALTER TABLE [dbo].[Board_Board]  WITH CHECK ADD  CONSTRAINT [FK_Board_Board_BoardSiteID_CMS_Site] FOREIGN KEY([BoardSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Board_Board] CHECK CONSTRAINT [FK_Board_Board_BoardSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[Board_Board]  WITH CHECK ADD  CONSTRAINT [FK_Board_Board_BoardUserID_CMS_User] FOREIGN KEY([BoardUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Board_Board] CHECK CONSTRAINT [FK_Board_Board_BoardUserID_CMS_User]
GO
