SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WorkflowScope](
	[ScopeID] [int] IDENTITY(1,1) NOT NULL,
	[ScopeStartingPath] [nvarchar](450) NOT NULL,
	[ScopeWorkflowID] [int] NOT NULL,
	[ScopeClassID] [int] NULL,
	[ScopeSiteID] [int] NOT NULL,
	[ScopeGUID] [uniqueidentifier] NOT NULL,
	[ScopeLastModified] [datetime2](7) NOT NULL,
	[ScopeCultureID] [int] NULL,
	[ScopeExcludeChildren] [bit] NULL,
	[ScopeExcluded] [bit] NOT NULL,
	[ScopeMacroCondition] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_WorkflowScope] PRIMARY KEY NONCLUSTERED 
(
	[ScopeID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_WorkflowScope_ScopeStartingPath] ON [dbo].[CMS_WorkflowScope]
(
	[ScopeStartingPath] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowScope_ScopeClassID] ON [dbo].[CMS_WorkflowScope]
(
	[ScopeClassID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowScope_ScopeCultureID] ON [dbo].[CMS_WorkflowScope]
(
	[ScopeCultureID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowScope_ScopeSiteID] ON [dbo].[CMS_WorkflowScope]
(
	[ScopeSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_WorkflowScope_ScopeWorkflowID] ON [dbo].[CMS_WorkflowScope]
(
	[ScopeWorkflowID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WorkflowScope] ADD  CONSTRAINT [DEFAULT_CMS_WorkflowScope_ScopeWorkflowID]  DEFAULT ((0)) FOR [ScopeWorkflowID]
GO
ALTER TABLE [dbo].[CMS_WorkflowScope] ADD  CONSTRAINT [DEFAULT_CMS_WorkflowScope_ScopeSiteID]  DEFAULT ((0)) FOR [ScopeSiteID]
GO
ALTER TABLE [dbo].[CMS_WorkflowScope] ADD  CONSTRAINT [DEFAULT_CMS_WorkflowScope_ScopeExcluded]  DEFAULT ((0)) FOR [ScopeExcluded]
GO
ALTER TABLE [dbo].[CMS_WorkflowScope]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowScope_ScopeClassID_CMS_Class] FOREIGN KEY([ScopeClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_WorkflowScope] CHECK CONSTRAINT [FK_CMS_WorkflowScope_ScopeClassID_CMS_Class]
GO
ALTER TABLE [dbo].[CMS_WorkflowScope]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowScope_ScopeCultureID_CMS_Culture] FOREIGN KEY([ScopeCultureID])
REFERENCES [dbo].[CMS_Culture] ([CultureID])
GO
ALTER TABLE [dbo].[CMS_WorkflowScope] CHECK CONSTRAINT [FK_CMS_WorkflowScope_ScopeCultureID_CMS_Culture]
GO
ALTER TABLE [dbo].[CMS_WorkflowScope]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowScope_ScopeSiteID_CMS_Site] FOREIGN KEY([ScopeSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_WorkflowScope] CHECK CONSTRAINT [FK_CMS_WorkflowScope_ScopeSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_WorkflowScope]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WorkflowScope_ScopeWorkflowID_CMS_WorkflowID] FOREIGN KEY([ScopeWorkflowID])
REFERENCES [dbo].[CMS_Workflow] ([WorkflowID])
GO
ALTER TABLE [dbo].[CMS_WorkflowScope] CHECK CONSTRAINT [FK_CMS_WorkflowScope_ScopeWorkflowID_CMS_WorkflowID]
GO
