SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_DocumentTypeScopeClass](
	[ScopeID] [int] NOT NULL,
	[ClassID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_DocumentTypeScopeClass] PRIMARY KEY CLUSTERED 
(
	[ScopeID] ASC,
	[ClassID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_DocumentTypeScopeClass_ClassID] ON [dbo].[CMS_DocumentTypeScopeClass]
(
	[ClassID] ASC
)
GO
ALTER TABLE [dbo].[CMS_DocumentTypeScopeClass]  WITH CHECK ADD  CONSTRAINT [FK_CMS_DocumentTypeScopeClass_ClassID_CMS_Class] FOREIGN KEY([ClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_DocumentTypeScopeClass] CHECK CONSTRAINT [FK_CMS_DocumentTypeScopeClass_ClassID_CMS_Class]
GO
ALTER TABLE [dbo].[CMS_DocumentTypeScopeClass]  WITH CHECK ADD  CONSTRAINT [FK_CMS_DocumentTypeScopeClass_ScopeID_CMS_DocumentTypeScope] FOREIGN KEY([ScopeID])
REFERENCES [dbo].[CMS_DocumentTypeScope] ([ScopeID])
GO
ALTER TABLE [dbo].[CMS_DocumentTypeScopeClass] CHECK CONSTRAINT [FK_CMS_DocumentTypeScopeClass_ScopeID_CMS_DocumentTypeScope]
GO
