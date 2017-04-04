SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staging_SyncLog](
	[SyncLogID] [int] IDENTITY(1,1) NOT NULL,
	[SyncLogTaskID] [int] NOT NULL,
	[SyncLogServerID] [int] NOT NULL,
	[SyncLogTime] [datetime2](7) NOT NULL,
	[SyncLogError] [nvarchar](max) NULL,
 CONSTRAINT [PK_Staging_SyncLog] PRIMARY KEY CLUSTERED 
(
	[SyncLogID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Staging_SyncLog_SyncLogServerID] ON [dbo].[Staging_SyncLog]
(
	[SyncLogServerID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Staging_SyncLog_SyncLogTaskID] ON [dbo].[Staging_SyncLog]
(
	[SyncLogTaskID] ASC
)
GO
ALTER TABLE [dbo].[Staging_SyncLog]  WITH CHECK ADD  CONSTRAINT [FK_Staging_SyncLog_SyncLogServerID_Staging_Server] FOREIGN KEY([SyncLogServerID])
REFERENCES [dbo].[Staging_Server] ([ServerID])
GO
ALTER TABLE [dbo].[Staging_SyncLog] CHECK CONSTRAINT [FK_Staging_SyncLog_SyncLogServerID_Staging_Server]
GO
ALTER TABLE [dbo].[Staging_SyncLog]  WITH CHECK ADD  CONSTRAINT [FK_Staging_SyncLog_SyncLogTaskID_Staging_Task] FOREIGN KEY([SyncLogTaskID])
REFERENCES [dbo].[Staging_Task] ([TaskID])
GO
ALTER TABLE [dbo].[Staging_SyncLog] CHECK CONSTRAINT [FK_Staging_SyncLog_SyncLogTaskID_Staging_Task]
GO
