SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Integration_SyncLog](
	[SyncLogID] [int] IDENTITY(1,1) NOT NULL,
	[SyncLogSynchronizationID] [int] NOT NULL,
	[SyncLogTime] [datetime2](7) NOT NULL,
	[SyncLogErrorMessage] [nvarchar](max) NULL,
 CONSTRAINT [PK_Integration_SyncLog] PRIMARY KEY CLUSTERED 
(
	[SyncLogID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Integration_SyncLog_SyncLogTaskID] ON [dbo].[Integration_SyncLog]
(
	[SyncLogSynchronizationID] ASC
)
GO
ALTER TABLE [dbo].[Integration_SyncLog]  WITH CHECK ADD  CONSTRAINT [FK_Integration_SyncLog_SyncLogSynchronizationID_Integration_Synchronization] FOREIGN KEY([SyncLogSynchronizationID])
REFERENCES [dbo].[Integration_Synchronization] ([SynchronizationID])
GO
ALTER TABLE [dbo].[Integration_SyncLog] CHECK CONSTRAINT [FK_Integration_SyncLog_SyncLogSynchronizationID_Integration_Synchronization]
GO
