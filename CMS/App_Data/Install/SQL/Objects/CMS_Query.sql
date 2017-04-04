SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Query](
	[QueryID] [int] IDENTITY(1,1) NOT NULL,
	[QueryName] [nvarchar](100) NOT NULL,
	[QueryTypeID] [int] NOT NULL,
	[QueryText] [nvarchar](max) NOT NULL,
	[QueryRequiresTransaction] [bit] NOT NULL,
	[ClassID] [int] NULL,
	[QueryIsLocked] [bit] NOT NULL,
	[QueryLastModified] [datetime2](7) NOT NULL,
	[QueryGUID] [uniqueidentifier] NOT NULL,
	[QueryLoadGeneration] [int] NOT NULL,
	[QueryIsCustom] [bit] NULL,
	[QueryConnectionString] [nvarchar](100) NULL,
 CONSTRAINT [PK_CMS_Query] PRIMARY KEY NONCLUSTERED 
(
	[QueryID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_Query_QueryLoadGeneration] ON [dbo].[CMS_Query]
(
	[QueryLoadGeneration] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Query_QueryClassID_QueryName] ON [dbo].[CMS_Query]
(
	[ClassID] ASC,
	[QueryName] ASC
)
GO
ALTER TABLE [dbo].[CMS_Query] ADD  CONSTRAINT [DEFAULT_CMS_Query_QueryName]  DEFAULT (N'') FOR [QueryName]
GO
ALTER TABLE [dbo].[CMS_Query] ADD  CONSTRAINT [DEFAULT_CMS_Query_QueryGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [QueryGUID]
GO
ALTER TABLE [dbo].[CMS_Query] ADD  CONSTRAINT [DEFAULT_CMS_Query_QueryLoadGeneration]  DEFAULT ((0)) FOR [QueryLoadGeneration]
GO
ALTER TABLE [dbo].[CMS_Query] ADD  CONSTRAINT [DEFAULT_CMS_Query_QueryIsCustom]  DEFAULT ((0)) FOR [QueryIsCustom]
GO
ALTER TABLE [dbo].[CMS_Query]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_Query_ClassID_CMS_Class] FOREIGN KEY([ClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_Query] CHECK CONSTRAINT [FK_CMS_Query_ClassID_CMS_Class]
GO
