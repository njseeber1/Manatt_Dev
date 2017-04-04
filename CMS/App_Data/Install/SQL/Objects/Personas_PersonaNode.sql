SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas_PersonaNode](
	[PersonaID] [int] NOT NULL,
	[NodeID] [int] NOT NULL,
 CONSTRAINT [PK_Personas_PersonaNode] PRIMARY KEY CLUSTERED 
(
	[PersonaID] ASC,
	[NodeID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Personas_PersonaNode_NodeID] ON [dbo].[Personas_PersonaNode]
(
	[NodeID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Personas_PersonaNode_PersonaID] ON [dbo].[Personas_PersonaNode]
(
	[PersonaID] ASC
)
GO
ALTER TABLE [dbo].[Personas_PersonaNode]  WITH CHECK ADD  CONSTRAINT [FK_Personas_PersonaNode_CMS_Tree] FOREIGN KEY([NodeID])
REFERENCES [dbo].[CMS_Tree] ([NodeID])
GO
ALTER TABLE [dbo].[Personas_PersonaNode] CHECK CONSTRAINT [FK_Personas_PersonaNode_CMS_Tree]
GO
