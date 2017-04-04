SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Tree](
	[NodeID] [int] IDENTITY(1,1) NOT NULL,
	[NodeAliasPath] [nvarchar](450) NOT NULL,
	[NodeName] [nvarchar](100) NOT NULL,
	[NodeAlias] [nvarchar](50) NOT NULL,
	[NodeClassID] [int] NOT NULL,
	[NodeParentID] [int] NULL,
	[NodeLevel] [int] NOT NULL,
	[NodeACLID] [int] NULL,
	[NodeSiteID] [int] NOT NULL,
	[NodeGUID] [uniqueidentifier] NOT NULL,
	[NodeOrder] [int] NULL,
	[IsSecuredNode] [bit] NULL,
	[NodeCacheMinutes] [int] NULL,
	[NodeSKUID] [int] NULL,
	[NodeDocType] [nvarchar](max) NULL,
	[NodeHeadTags] [nvarchar](max) NULL,
	[NodeBodyElementAttributes] [nvarchar](max) NULL,
	[NodeInheritPageLevels] [nvarchar](200) NULL,
	[RequiresSSL] [int] NULL,
	[NodeLinkedNodeID] [int] NULL,
	[NodeOwner] [int] NULL,
	[NodeCustomData] [nvarchar](max) NULL,
	[NodeGroupID] [int] NULL,
	[NodeLinkedNodeSiteID] [int] NULL,
	[NodeTemplateID] [int] NULL,
	[NodeTemplateForAllCultures] [bit] NULL,
	[NodeInheritPageTemplate] [bit] NULL,
	[NodeAllowCacheInFileSystem] [bit] NULL,
	[NodeHasChildren] [bit] NULL,
	[NodeHasLinks] [bit] NULL,
	[NodeOriginalNodeID] [int] NULL,
	[NodeIsContentOnly] [bit] NOT NULL,
	[NodeIsACLOwner] [bit] NOT NULL,
 CONSTRAINT [PK_CMS_Tree] PRIMARY KEY CLUSTERED 
(
	[NodeID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeACLID] ON [dbo].[CMS_Tree]
(
	[NodeACLID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeAliasPath] ON [dbo].[CMS_Tree]
(
	[NodeAliasPath] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeClassID] ON [dbo].[CMS_Tree]
(
	[NodeClassID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeGroupID] ON [dbo].[CMS_Tree]
(
	[NodeGroupID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeLevel] ON [dbo].[CMS_Tree]
(
	[NodeLevel] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeLinkedNodeID] ON [dbo].[CMS_Tree]
(
	[NodeLinkedNodeID] ASC
)
INCLUDE ( 	[NodeID],
	[NodeClassID])
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeLinkedNodeSiteID] ON [dbo].[CMS_Tree]
(
	[NodeLinkedNodeSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeOriginalNodeID] ON [dbo].[CMS_Tree]
(
	[NodeOriginalNodeID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeOwner] ON [dbo].[CMS_Tree]
(
	[NodeOwner] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeParentID_NodeAlias_NodeName] ON [dbo].[CMS_Tree]
(
	[NodeParentID] ASC,
	[NodeAlias] ASC,
	[NodeName] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_Tree_NodeSiteID_NodeGUID] ON [dbo].[CMS_Tree]
(
	[NodeSiteID] ASC,
	[NodeGUID] ASC
)
INCLUDE ( 	[NodeID])
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeSKUID] ON [dbo].[CMS_Tree]
(
	[NodeSKUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Tree_NodeTemplateID] ON [dbo].[CMS_Tree]
(
	[NodeTemplateID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Tree] ADD  CONSTRAINT [DEFAULT_CMS_Tree_NodeTemplateForAllCultures]  DEFAULT ((0)) FOR [NodeTemplateForAllCultures]
GO
ALTER TABLE [dbo].[CMS_Tree] ADD  CONSTRAINT [DEFAULT_CMS_Tree_NodeInheritPageTemplate]  DEFAULT ((0)) FOR [NodeInheritPageTemplate]
GO
ALTER TABLE [dbo].[CMS_Tree] ADD  CONSTRAINT [DEFAULT_CMS_Tree_NodeAllowCacheInFileSystem]  DEFAULT ((0)) FOR [NodeAllowCacheInFileSystem]
GO
ALTER TABLE [dbo].[CMS_Tree] ADD  CONSTRAINT [DEFAULT_CMS_Tree_NodeHasChildren]  DEFAULT ((0)) FOR [NodeHasChildren]
GO
ALTER TABLE [dbo].[CMS_Tree] ADD  CONSTRAINT [DEFAULT_CMS_Tree_NodeHasLinks]  DEFAULT ((0)) FOR [NodeHasLinks]
GO
ALTER TABLE [dbo].[CMS_Tree] ADD  CONSTRAINT [DEFAULT_CMS_Tree_NodeIsContentOnly]  DEFAULT ((0)) FOR [NodeIsContentOnly]
GO
ALTER TABLE [dbo].[CMS_Tree] ADD  CONSTRAINT [DEFAULT_CMS_Tree_NodeIsACLOwner]  DEFAULT ((0)) FOR [NodeIsACLOwner]
GO
ALTER TABLE [dbo].[CMS_Tree]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Tree_NodeACLID_CMS_ACL] FOREIGN KEY([NodeACLID])
REFERENCES [dbo].[CMS_ACL] ([ACLID])
GO
ALTER TABLE [dbo].[CMS_Tree] CHECK CONSTRAINT [FK_CMS_Tree_NodeACLID_CMS_ACL]
GO
ALTER TABLE [dbo].[CMS_Tree]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Tree_NodeClassID_CMS_Class] FOREIGN KEY([NodeClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_Tree] CHECK CONSTRAINT [FK_CMS_Tree_NodeClassID_CMS_Class]
GO
ALTER TABLE [dbo].[CMS_Tree]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Tree_NodeGroupID_Community_Group] FOREIGN KEY([NodeGroupID])
REFERENCES [dbo].[Community_Group] ([GroupID])
GO
ALTER TABLE [dbo].[CMS_Tree] CHECK CONSTRAINT [FK_CMS_Tree_NodeGroupID_Community_Group]
GO
ALTER TABLE [dbo].[CMS_Tree]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Tree_NodeLinkedNodeID_CMS_Tree] FOREIGN KEY([NodeLinkedNodeID])
REFERENCES [dbo].[CMS_Tree] ([NodeID])
GO
ALTER TABLE [dbo].[CMS_Tree] CHECK CONSTRAINT [FK_CMS_Tree_NodeLinkedNodeID_CMS_Tree]
GO
ALTER TABLE [dbo].[CMS_Tree]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Tree_NodeLinkedNodeSiteID_CMS_Site] FOREIGN KEY([NodeLinkedNodeSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_Tree] CHECK CONSTRAINT [FK_CMS_Tree_NodeLinkedNodeSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_Tree]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Tree_NodeOriginalNodeID_CMS_Tree] FOREIGN KEY([NodeOriginalNodeID])
REFERENCES [dbo].[CMS_Tree] ([NodeID])
GO
ALTER TABLE [dbo].[CMS_Tree] CHECK CONSTRAINT [FK_CMS_Tree_NodeOriginalNodeID_CMS_Tree]
GO
ALTER TABLE [dbo].[CMS_Tree]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Tree_NodeOwner_CMS_User] FOREIGN KEY([NodeOwner])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_Tree] CHECK CONSTRAINT [FK_CMS_Tree_NodeOwner_CMS_User]
GO
ALTER TABLE [dbo].[CMS_Tree]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Tree_NodeParentID_CMS_Tree] FOREIGN KEY([NodeParentID])
REFERENCES [dbo].[CMS_Tree] ([NodeID])
GO
ALTER TABLE [dbo].[CMS_Tree] CHECK CONSTRAINT [FK_CMS_Tree_NodeParentID_CMS_Tree]
GO
ALTER TABLE [dbo].[CMS_Tree]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Tree_NodeSiteID_CMS_Site] FOREIGN KEY([NodeSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_Tree] CHECK CONSTRAINT [FK_CMS_Tree_NodeSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_Tree]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Tree_NodeSKUID_COM_SKU] FOREIGN KEY([NodeSKUID])
REFERENCES [dbo].[COM_SKU] ([SKUID])
GO
ALTER TABLE [dbo].[CMS_Tree] CHECK CONSTRAINT [FK_CMS_Tree_NodeSKUID_COM_SKU]
GO
ALTER TABLE [dbo].[CMS_Tree]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Tree_NodeTemplateID_CMS_PageTemplate] FOREIGN KEY([NodeTemplateID])
REFERENCES [dbo].[CMS_PageTemplate] ([PageTemplateID])
GO
ALTER TABLE [dbo].[CMS_Tree] CHECK CONSTRAINT [FK_CMS_Tree_NodeTemplateID_CMS_PageTemplate]
GO
