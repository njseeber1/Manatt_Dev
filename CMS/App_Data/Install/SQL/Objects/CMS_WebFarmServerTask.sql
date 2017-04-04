SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WebFarmServerTask](
	[ServerID] [int] NOT NULL,
	[TaskID] [int] NOT NULL,
	[ErrorMessage] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_WebFarmServerTask] PRIMARY KEY CLUSTERED 
(
	[ServerID] ASC,
	[TaskID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_WebFarmServerTask_TaskID] ON [dbo].[CMS_WebFarmServerTask]
(
	[TaskID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WebFarmServerTask]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WebFarmServerTask_ServerID_CMS_WebFarmServer] FOREIGN KEY([ServerID])
REFERENCES [dbo].[CMS_WebFarmServer] ([ServerID])
GO
ALTER TABLE [dbo].[CMS_WebFarmServerTask] NOCHECK CONSTRAINT [FK_CMS_WebFarmServerTask_ServerID_CMS_WebFarmServer]
GO
ALTER TABLE [dbo].[CMS_WebFarmServerTask]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_WebFarmServerTask_TaskID_CMS_WebFarmTask] FOREIGN KEY([TaskID])
REFERENCES [dbo].[CMS_WebFarmTask] ([TaskID])
GO
ALTER TABLE [dbo].[CMS_WebFarmServerTask] NOCHECK CONSTRAINT [FK_CMS_WebFarmServerTask_TaskID_CMS_WebFarmTask]
GO
