SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_AllowedChildClasses](
	[ParentClassID] [int] NOT NULL,
	[ChildClassID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_AllowedChildClasses] PRIMARY KEY CLUSTERED 
(
	[ParentClassID] ASC,
	[ChildClassID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_AllowedChildClasses_ChildClassID] ON [dbo].[CMS_AllowedChildClasses]
(
	[ChildClassID] ASC
)
GO
ALTER TABLE [dbo].[CMS_AllowedChildClasses]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AllowedChildClasses_ChildClassID_CMS_Class] FOREIGN KEY([ChildClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_AllowedChildClasses] CHECK CONSTRAINT [FK_CMS_AllowedChildClasses_ChildClassID_CMS_Class]
GO
ALTER TABLE [dbo].[CMS_AllowedChildClasses]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AllowedChildClasses_ParentClassID_CMS_Class] FOREIGN KEY([ParentClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_AllowedChildClasses] CHECK CONSTRAINT [FK_CMS_AllowedChildClasses_ParentClassID_CMS_Class]
GO
