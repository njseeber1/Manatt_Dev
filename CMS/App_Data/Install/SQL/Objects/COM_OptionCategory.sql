SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_OptionCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryDisplayName] [nvarchar](200) NOT NULL,
	[CategoryName] [nvarchar](200) NOT NULL,
	[CategorySelectionType] [nvarchar](200) NOT NULL,
	[CategoryDefaultOptions] [nvarchar](200) NULL,
	[CategoryDescription] [nvarchar](max) NULL,
	[CategoryDefaultRecord] [nvarchar](200) NULL,
	[CategoryEnabled] [bit] NOT NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL,
	[CategoryLastModified] [datetime2](7) NOT NULL,
	[CategoryDisplayPrice] [bit] NULL,
	[CategorySiteID] [int] NULL,
	[CategoryTextMaxLength] [int] NULL,
	[CategoryFormControlName] [nvarchar](200) NULL,
	[CategoryType] [nvarchar](20) NULL,
	[CategoryTextMinLength] [int] NULL,
	[CategoryAllowEmpty] [bit] NULL,
	[CategoryLiveSiteDisplayName] [nvarchar](200) NULL,
 CONSTRAINT [PK_COM_OptionCategory] PRIMARY KEY NONCLUSTERED 
(
	[CategoryID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_OptionCategory_CategoryDisplayName_CategoryEnabled] ON [dbo].[COM_OptionCategory]
(
	[CategoryDisplayName] ASC,
	[CategoryEnabled] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_OptionCategory_CategorySiteID] ON [dbo].[COM_OptionCategory]
(
	[CategorySiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_OptionCategory] ADD  CONSTRAINT [DEFAULT_COM_OptionCategory_CategoryDisplayName]  DEFAULT (N'') FOR [CategoryDisplayName]
GO
ALTER TABLE [dbo].[COM_OptionCategory] ADD  CONSTRAINT [DEFAULT_COM_OptionCategory_CategoryName]  DEFAULT (N'') FOR [CategoryName]
GO
ALTER TABLE [dbo].[COM_OptionCategory] ADD  CONSTRAINT [DEFAULT_COM_OptionCategory_CategorySelectionType]  DEFAULT (N'') FOR [CategorySelectionType]
GO
ALTER TABLE [dbo].[COM_OptionCategory] ADD  CONSTRAINT [DEFAULT_COM_OptionCategory_CategoryEnabled]  DEFAULT ((1)) FOR [CategoryEnabled]
GO
ALTER TABLE [dbo].[COM_OptionCategory] ADD  CONSTRAINT [DEFAULT_COM_OptionCategory_CategoryDisplayPrice]  DEFAULT ((1)) FOR [CategoryDisplayPrice]
GO
ALTER TABLE [dbo].[COM_OptionCategory] ADD  CONSTRAINT [DEFAULT_COM_OptionCategory_CategoryAllowEmpty]  DEFAULT ((0)) FOR [CategoryAllowEmpty]
GO
ALTER TABLE [dbo].[COM_OptionCategory]  WITH CHECK ADD  CONSTRAINT [FK_COM_OptionCategory_CategorySiteID_CMS_Site] FOREIGN KEY([CategorySiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_OptionCategory] CHECK CONSTRAINT [FK_COM_OptionCategory_CategorySiteID_CMS_Site]
GO
