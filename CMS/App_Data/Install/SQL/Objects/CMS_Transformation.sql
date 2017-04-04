SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Transformation](
	[TransformationID] [int] IDENTITY(1,1) NOT NULL,
	[TransformationName] [nvarchar](100) NOT NULL,
	[TransformationCode] [nvarchar](max) NOT NULL,
	[TransformationType] [nvarchar](50) NOT NULL,
	[TransformationClassID] [int] NOT NULL,
	[TransformationVersionGUID] [nvarchar](50) NULL,
	[TransformationGUID] [uniqueidentifier] NOT NULL,
	[TransformationLastModified] [datetime2](7) NOT NULL,
	[TransformationIsHierarchical] [bit] NULL,
	[TransformationHierarchicalXML] [nvarchar](max) NULL,
	[TransformationCSS] [nvarchar](max) NULL,
	[TransformationPreferredDocument] [nvarchar](700) NULL,
 CONSTRAINT [PK_CMS_Transformation] PRIMARY KEY NONCLUSTERED 
(
	[TransformationID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Transformation_TransformationClassID_TransformationName] ON [dbo].[CMS_Transformation]
(
	[TransformationClassID] ASC,
	[TransformationName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Transformation_TransformationClassID] ON [dbo].[CMS_Transformation]
(
	[TransformationClassID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Transformation] ADD  CONSTRAINT [DEFAULT_CMS_Transformation_TransformationName]  DEFAULT (N'') FOR [TransformationName]
GO
ALTER TABLE [dbo].[CMS_Transformation] ADD  CONSTRAINT [DEFAULT_CMS_Transformation_TransformationCode]  DEFAULT (N'') FOR [TransformationCode]
GO
ALTER TABLE [dbo].[CMS_Transformation] ADD  CONSTRAINT [DEFAULT_CMS_Transformation_TransformationType]  DEFAULT (N'') FOR [TransformationType]
GO
ALTER TABLE [dbo].[CMS_Transformation] ADD  CONSTRAINT [DEFAULT_CMS_Transformation_TransformationIsHierarchical]  DEFAULT ((0)) FOR [TransformationIsHierarchical]
GO
ALTER TABLE [dbo].[CMS_Transformation]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_Transformation_TransformationClassID_CMS_Class] FOREIGN KEY([TransformationClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_Transformation] CHECK CONSTRAINT [FK_CMS_Transformation_TransformationClassID_CMS_Class]
GO
