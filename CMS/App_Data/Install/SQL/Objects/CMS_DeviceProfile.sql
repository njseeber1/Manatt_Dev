SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_DeviceProfile](
	[ProfileID] [int] IDENTITY(1,1) NOT NULL,
	[ProfileName] [nvarchar](100) NOT NULL,
	[ProfileDisplayName] [nvarchar](200) NOT NULL,
	[ProfileOrder] [int] NULL,
	[ProfileMacro] [nvarchar](max) NULL,
	[ProfileUserAgents] [nvarchar](max) NULL,
	[ProfileDevices] [nvarchar](max) NULL,
	[ProfileEnabled] [bit] NOT NULL,
	[ProfilePreviewWidth] [int] NULL,
	[ProfilePreviewHeight] [int] NULL,
	[ProfileGUID] [uniqueidentifier] NULL,
	[ProfileLastModified] [datetime2](7) NULL,
 CONSTRAINT [PK_CMS_DeviceProfile] PRIMARY KEY CLUSTERED 
(
	[ProfileID] ASC
)
)

GO
ALTER TABLE [dbo].[CMS_DeviceProfile] ADD  CONSTRAINT [DEFAULT_CMS_DeviceProfile_ProfileName]  DEFAULT ('') FOR [ProfileName]
GO
ALTER TABLE [dbo].[CMS_DeviceProfile] ADD  CONSTRAINT [DEFAULT_CMS_DeviceProfile_ProfileEnabled]  DEFAULT ((1)) FOR [ProfileEnabled]
GO
