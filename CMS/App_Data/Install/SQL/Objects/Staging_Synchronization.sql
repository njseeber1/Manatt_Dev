SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staging_Synchronization](
	[SynchronizationID] [int] IDENTITY(1,1) NOT NULL,
	[SynchronizationTaskID] [int] NOT NULL,
	[SynchronizationServerID] [int] NOT NULL,
	[SynchronizationLastRun] [datetime2](7) NULL,
	[SynchronizationErrorMessage] [nvarchar](max) NULL,
 CONSTRAINT [PK_Staging_Synchronization] PRIMARY KEY CLUSTERED 
(
	[SynchronizationID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Staging_Synchronization_SynchronizationServerID] ON [dbo].[Staging_Synchronization]
(
	[SynchronizationServerID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Staging_Synchronization_SynchronizationTaskID] ON [dbo].[Staging_Synchronization]
(
	[SynchronizationTaskID] ASC
)
GO
ALTER TABLE [dbo].[Staging_Synchronization]  WITH CHECK ADD  CONSTRAINT [FK_Staging_Synchronization_SynchronizationServerID_Staging_Server] FOREIGN KEY([SynchronizationServerID])
REFERENCES [dbo].[Staging_Server] ([ServerID])
GO
ALTER TABLE [dbo].[Staging_Synchronization] CHECK CONSTRAINT [FK_Staging_Synchronization_SynchronizationServerID_Staging_Server]
GO
ALTER TABLE [dbo].[Staging_Synchronization]  WITH CHECK ADD  CONSTRAINT [FK_Staging_Synchronization_SynchronizationTaskID_Staging_Task] FOREIGN KEY([SynchronizationTaskID])
REFERENCES [dbo].[Staging_Task] ([TaskID])
GO
ALTER TABLE [dbo].[Staging_Synchronization] CHECK CONSTRAINT [FK_Staging_Synchronization_SynchronizationTaskID_Staging_Task]
GO
