SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staging_TaskGroup](
	[TaskGroupID] [int] IDENTITY(1,1) NOT NULL,
	[TaskGroupCodeName] [nvarchar](50) NOT NULL,
	[TaskGroupGuid] [uniqueidentifier] NOT NULL,
	[TaskGroupDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_staging_TaskGroup] PRIMARY KEY CLUSTERED 
(
	[TaskGroupID] ASC
)
)

GO
ALTER TABLE [dbo].[staging_TaskGroup] ADD  CONSTRAINT [DEFAULT_staging_TaskGroup_TaskGroupCodeName]  DEFAULT (N'') FOR [TaskGroupCodeName]
GO
ALTER TABLE [dbo].[staging_TaskGroup] ADD  CONSTRAINT [DEFAULT_staging_TaskGroup_TaskGroupGuid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TaskGroupGuid]
GO
