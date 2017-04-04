SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_DocumentAlias](
	[AliasID] [int] IDENTITY(1,1) NOT NULL,
	[AliasNodeID] [int] NOT NULL,
	[AliasCulture] [nvarchar](20) NULL,
	[AliasURLPath] [nvarchar](450) NULL,
	[AliasExtensions] [nvarchar](100) NULL,
	[AliasWildcardRule] [nvarchar](440) NULL,
	[AliasPriority] [int] NULL,
	[AliasGUID] [uniqueidentifier] NULL,
	[AliasLastModified] [datetime2](7) NOT NULL,
	[AliasSiteID] [int] NOT NULL,
	[AliasActionMode] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMS_DocumentAlias] PRIMARY KEY NONCLUSTERED 
(
	[AliasID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_DocumentAlias_AliasURLPath] ON [dbo].[CMS_DocumentAlias]
(
	[AliasURLPath] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Document_AliasCulture] ON [dbo].[CMS_DocumentAlias]
(
	[AliasCulture] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_DocumentAlias_AliasNodeID] ON [dbo].[CMS_DocumentAlias]
(
	[AliasNodeID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_DocumentAlias_AliasSiteID] ON [dbo].[CMS_DocumentAlias]
(
	[AliasSiteID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_DocumentAlias_AliasWildcardRule_AliasPriority] ON [dbo].[CMS_DocumentAlias]
(
	[AliasWildcardRule] ASC,
	[AliasPriority] ASC
)
GO
ALTER TABLE [dbo].[CMS_DocumentAlias] ADD  CONSTRAINT [DEFAULT_CMS_DocumentAlias_AliasCulture]  DEFAULT (N'') FOR [AliasCulture]
GO
ALTER TABLE [dbo].[CMS_DocumentAlias] ADD  CONSTRAINT [DEFAULT_CMS_DocumentAlias_AliasURLPath]  DEFAULT (N'') FOR [AliasURLPath]
GO
ALTER TABLE [dbo].[CMS_DocumentAlias] ADD  CONSTRAINT [DEFAULT_CMS_DocumentAlias_AliasExtensions]  DEFAULT (N'') FOR [AliasExtensions]
GO
ALTER TABLE [dbo].[CMS_DocumentAlias] ADD  CONSTRAINT [DEFAULT_CMS_DocumentAlias_AliasLastModified]  DEFAULT ('10/22/2008 12:55:43 PM') FOR [AliasLastModified]
GO
ALTER TABLE [dbo].[CMS_DocumentAlias] ADD  CONSTRAINT [DEFAULT_CMS_DocumentAlias_AliasSiteID]  DEFAULT ((0)) FOR [AliasSiteID]
GO
ALTER TABLE [dbo].[CMS_DocumentAlias]  WITH CHECK ADD  CONSTRAINT [FK_CMS_DocumentAlias_AliasNodeID_CMS_Tree] FOREIGN KEY([AliasNodeID])
REFERENCES [dbo].[CMS_Tree] ([NodeID])
GO
ALTER TABLE [dbo].[CMS_DocumentAlias] CHECK CONSTRAINT [FK_CMS_DocumentAlias_AliasNodeID_CMS_Tree]
GO
ALTER TABLE [dbo].[CMS_DocumentAlias]  WITH CHECK ADD  CONSTRAINT [FK_CMS_DocumentAlias_AliasSiteID_CMS_Site] FOREIGN KEY([AliasSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_DocumentAlias] CHECK CONSTRAINT [FK_CMS_DocumentAlias_AliasSiteID_CMS_Site]
GO
