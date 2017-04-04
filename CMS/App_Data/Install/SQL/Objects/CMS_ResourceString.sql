SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_ResourceString](
	[StringID] [int] IDENTITY(1,1) NOT NULL,
	[StringKey] [nvarchar](200) NOT NULL,
	[StringIsCustom] [bit] NOT NULL,
	[StringLoadGeneration] [int] NOT NULL,
 CONSTRAINT [PK_CMS_ResourceString] PRIMARY KEY NONCLUSTERED 
(
	[StringID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_ResourceString_StringLoadGeneration] ON [dbo].[CMS_ResourceString]
(
	[StringLoadGeneration] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_ResourceString_StringKey] ON [dbo].[CMS_ResourceString]
(
	[StringKey] ASC
)
GO
ALTER TABLE [dbo].[CMS_ResourceString] ADD  CONSTRAINT [DEFAULT_CMS_ResourceString_StringLoadGeneration]  DEFAULT ((0)) FOR [StringLoadGeneration]
GO
