SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_AlternativeForm](
	[FormID] [int] IDENTITY(1,1) NOT NULL,
	[FormDisplayName] [nvarchar](100) NOT NULL,
	[FormName] [nvarchar](50) NOT NULL,
	[FormClassID] [int] NOT NULL,
	[FormDefinition] [nvarchar](max) NULL,
	[FormLayout] [nvarchar](max) NULL,
	[FormGUID] [uniqueidentifier] NOT NULL,
	[FormLastModified] [datetime2](7) NOT NULL,
	[FormCoupledClassID] [int] NULL,
	[FormHideNewParentFields] [bit] NULL,
	[FormLayoutType] [nvarchar](50) NULL,
	[FormVersionGUID] [nvarchar](50) NULL,
	[FormCustomizedColumns] [nvarchar](400) NULL,
	[FormIsCustom] [bit] NULL,
 CONSTRAINT [PK_CMS_AlternativeForm] PRIMARY KEY CLUSTERED 
(
	[FormID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_AlternativeForm_FormClassID_FormName] ON [dbo].[CMS_AlternativeForm]
(
	[FormClassID] ASC,
	[FormName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_AlternativeForm_FormCoupledClassID] ON [dbo].[CMS_AlternativeForm]
(
	[FormCoupledClassID] ASC
)
GO
ALTER TABLE [dbo].[CMS_AlternativeForm] ADD  CONSTRAINT [DEFAULT_CMS_AlternativeForm_FormDisplayName]  DEFAULT ('') FOR [FormDisplayName]
GO
ALTER TABLE [dbo].[CMS_AlternativeForm] ADD  CONSTRAINT [DEFAULT_CMS_AlternativeForm_FormName]  DEFAULT ('') FOR [FormName]
GO
ALTER TABLE [dbo].[CMS_AlternativeForm] ADD  CONSTRAINT [DEFAULT_CMS_AlternativeForm_FormHideNewParentFields]  DEFAULT ((0)) FOR [FormHideNewParentFields]
GO
ALTER TABLE [dbo].[CMS_AlternativeForm] ADD  CONSTRAINT [DEFAULT_CMS_AlternativeForm_FormIsCustom]  DEFAULT ((0)) FOR [FormIsCustom]
GO
ALTER TABLE [dbo].[CMS_AlternativeForm]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_AlternativeForm_FormClassID_CMS_Class] FOREIGN KEY([FormClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_AlternativeForm] CHECK CONSTRAINT [FK_CMS_AlternativeForm_FormClassID_CMS_Class]
GO
ALTER TABLE [dbo].[CMS_AlternativeForm]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_AlternativeForm_FormCoupledClassID_CMS_Class] FOREIGN KEY([FormCoupledClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_AlternativeForm] CHECK CONSTRAINT [FK_CMS_AlternativeForm_FormCoupledClassID_CMS_Class]
GO
