SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_CssStylesheet](
	[StylesheetID] [int] IDENTITY(1,1) NOT NULL,
	[StylesheetDisplayName] [nvarchar](200) NOT NULL,
	[StylesheetName] [nvarchar](200) NOT NULL,
	[StylesheetText] [nvarchar](max) NULL,
	[StylesheetVersionGUID] [uniqueidentifier] NULL,
	[StylesheetGUID] [uniqueidentifier] NULL,
	[StylesheetLastModified] [datetime2](7) NOT NULL,
	[StylesheetDynamicCode] [nvarchar](max) NULL,
	[StylesheetDynamicLanguage] [nvarchar](200) NULL,
 CONSTRAINT [PK_CMS_CssStylesheet] PRIMARY KEY NONCLUSTERED 
(
	[StylesheetID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_CssStylesheet_StylesheetDisplayName] ON [dbo].[CMS_CssStylesheet]
(
	[StylesheetDisplayName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_CssStylesheet_StylesheetName] ON [dbo].[CMS_CssStylesheet]
(
	[StylesheetName] ASC
)
GO
ALTER TABLE [dbo].[CMS_CssStylesheet] ADD  CONSTRAINT [DEFAULT_CMS_CssStyleSheet_StylesheetDisplayName]  DEFAULT ('') FOR [StylesheetDisplayName]
GO
ALTER TABLE [dbo].[CMS_CssStylesheet] ADD  CONSTRAINT [DEFAULT_CMS_CssStyleSheet_StylesheetName]  DEFAULT ('') FOR [StylesheetName]
GO
ALTER TABLE [dbo].[CMS_CssStylesheet] ADD  CONSTRAINT [DEFAULT_CMS_CssStyleSheet_StylesheetDynamicLanguage]  DEFAULT ('plaincss') FOR [StylesheetDynamicLanguage]
GO
