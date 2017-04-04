SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Culture](
	[CultureID] [int] IDENTITY(1,1) NOT NULL,
	[CultureName] [nvarchar](200) NOT NULL,
	[CultureCode] [nvarchar](50) NOT NULL,
	[CultureShortName] [nvarchar](200) NOT NULL,
	[CultureGUID] [uniqueidentifier] NOT NULL,
	[CultureLastModified] [datetime2](7) NOT NULL,
	[CultureAlias] [nvarchar](100) NULL,
	[CultureIsUICulture] [bit] NULL,
 CONSTRAINT [PK_CMS_Culture] PRIMARY KEY NONCLUSTERED 
(
	[CultureID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Culture_CultureName] ON [dbo].[CMS_Culture]
(
	[CultureName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_CulturAlias] ON [dbo].[CMS_Culture]
(
	[CultureAlias] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Culture_CultureCode] ON [dbo].[CMS_Culture]
(
	[CultureCode] ASC
)
GO
ALTER TABLE [dbo].[CMS_Culture] ADD  CONSTRAINT [DEFAULT_CMS_Culture_CultureIsUICulture]  DEFAULT ((0)) FOR [CultureIsUICulture]
GO
