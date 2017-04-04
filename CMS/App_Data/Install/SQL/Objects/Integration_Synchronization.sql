SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Integration_Synchronization](
	[SynchronizationID] [int] IDENTITY(1,1) NOT NULL,
	[SynchronizationTaskID] [int] NOT NULL,
	[SynchronizationConnectorID] [int] NOT NULL,
	[SynchronizationLastRun] [datetime2](7) NOT NULL,
	[SynchronizationErrorMessage] [nvarchar](max) NULL,
	[SynchronizationIsRunning] [bit] NULL,
 CONSTRAINT [PK_Integration_Synchronization] PRIMARY KEY CLUSTERED 
(
	[SynchronizationID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Integration_Synchronization_SynchronizationConnectorID] ON [dbo].[Integration_Synchronization]
(
	[SynchronizationConnectorID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Integration_Synchronization_SynchronizationTaskID] ON [dbo].[Integration_Synchronization]
(
	[SynchronizationTaskID] ASC
)
GO
ALTER TABLE [dbo].[Integration_Synchronization]  WITH CHECK ADD  CONSTRAINT [FK_Integration_Synchronization_SynchronizationConnectorID_Integration_Connector] FOREIGN KEY([SynchronizationConnectorID])
REFERENCES [dbo].[Integration_Connector] ([ConnectorID])
GO
ALTER TABLE [dbo].[Integration_Synchronization] CHECK CONSTRAINT [FK_Integration_Synchronization_SynchronizationConnectorID_Integration_Connector]
GO
ALTER TABLE [dbo].[Integration_Synchronization]  WITH CHECK ADD  CONSTRAINT [FK_Integration_Synchronization_SynchronizationTaskID_Integration_Task] FOREIGN KEY([SynchronizationTaskID])
REFERENCES [dbo].[Integration_Task] ([TaskID])
GO
ALTER TABLE [dbo].[Integration_Synchronization] CHECK CONSTRAINT [FK_Integration_Synchronization_SynchronizationTaskID_Integration_Task]
GO
