SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WebFarmServerLog](
	[WebFarmServerLogID] [int] IDENTITY(1,1) NOT NULL,
	[LogTime] [datetime2](7) NOT NULL,
	[LogCode] [nvarchar](200) NOT NULL,
	[ServerID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_WebFarmServerLog] PRIMARY KEY CLUSTERED 
(
	[WebFarmServerLogID] ASC
)
)

GO
ALTER TABLE [dbo].[CMS_WebFarmServerLog] ADD  CONSTRAINT [DEFAULT_CMS_WebFarmServerLog_LogCode]  DEFAULT (N'') FOR [LogCode]
GO
ALTER TABLE [dbo].[CMS_WebFarmServerLog] ADD  CONSTRAINT [DEFAULT_CMS_WebFarmServerLog_ServerID]  DEFAULT ((0)) FOR [ServerID]
GO
