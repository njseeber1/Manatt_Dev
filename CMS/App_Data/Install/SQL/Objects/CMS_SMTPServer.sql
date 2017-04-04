SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_SMTPServer](
	[ServerID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](200) NOT NULL,
	[ServerUserName] [nvarchar](50) NULL,
	[ServerPassword] [nvarchar](200) NULL,
	[ServerUseSSL] [bit] NOT NULL,
	[ServerEnabled] [bit] NOT NULL,
	[ServerIsGlobal] [bit] NOT NULL,
	[ServerGUID] [uniqueidentifier] NOT NULL,
	[ServerLastModified] [datetime2](7) NOT NULL,
	[ServerPriority] [int] NULL,
	[ServerDeliveryMethod] [int] NULL,
	[ServerPickupDirectory] [nvarchar](450) NULL,
 CONSTRAINT [PK_CMS_SMTPServer] PRIMARY KEY CLUSTERED 
(
	[ServerID] ASC
)
)

GO
ALTER TABLE [dbo].[CMS_SMTPServer] ADD  CONSTRAINT [DEFAULT_CMS_SMTPServer_ServerDeliveryMethod]  DEFAULT ((0)) FOR [ServerDeliveryMethod]
GO
