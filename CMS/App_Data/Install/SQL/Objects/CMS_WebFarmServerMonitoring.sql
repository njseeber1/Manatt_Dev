SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WebFarmServerMonitoring](
	[WebFarmServerMonitoringID] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [int] NOT NULL,
	[ServerPing] [datetime2](7) NULL,
 CONSTRAINT [PK_CMS_WebFarmServerMonitoring] PRIMARY KEY CLUSTERED 
(
	[WebFarmServerMonitoringID] ASC
)
)

GO
ALTER TABLE [dbo].[CMS_WebFarmServerMonitoring] ADD  CONSTRAINT [DEFAULT_CMS_WebFarmServerMonitoring_ServerID]  DEFAULT ((0)) FOR [ServerID]
GO
