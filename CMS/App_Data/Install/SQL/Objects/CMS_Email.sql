SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Email](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[EmailFrom] [nvarchar](250) NOT NULL,
	[EmailTo] [nvarchar](max) NULL,
	[EmailCc] [nvarchar](max) NULL,
	[EmailBcc] [nvarchar](max) NULL,
	[EmailSubject] [nvarchar](450) NOT NULL,
	[EmailBody] [nvarchar](max) NULL,
	[EmailPlainTextBody] [nvarchar](max) NULL,
	[EmailFormat] [int] NOT NULL,
	[EmailPriority] [int] NOT NULL,
	[EmailSiteID] [int] NULL,
	[EmailLastSendResult] [nvarchar](max) NULL,
	[EmailLastSendAttempt] [datetime2](7) NULL,
	[EmailGUID] [uniqueidentifier] NOT NULL,
	[EmailLastModified] [datetime2](7) NOT NULL,
	[EmailStatus] [int] NULL,
	[EmailIsMass] [bit] NULL,
	[EmailSetName] [nvarchar](250) NULL,
	[EmailSetRelatedID] [int] NULL,
	[EmailReplyTo] [nvarchar](250) NULL,
	[EmailHeaders] [nvarchar](max) NULL,
	[EmailCreated] [datetime2](7) NULL,
 CONSTRAINT [PK_CMS_Email] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_Email_EmailPriority_EmailID] ON [dbo].[CMS_Email]
(
	[EmailPriority] DESC,
	[EmailID] ASC
)
INCLUDE ( 	[EmailStatus],
	[EmailLastSendResult])
GO
ALTER TABLE [dbo].[CMS_Email] ADD  CONSTRAINT [DEFAULT_CMS_Email_EmailSubject]  DEFAULT ('') FOR [EmailSubject]
GO
ALTER TABLE [dbo].[CMS_Email] ADD  CONSTRAINT [DEFAULT_CMS_Email_EmailIsMass]  DEFAULT ((1)) FOR [EmailIsMass]
GO
