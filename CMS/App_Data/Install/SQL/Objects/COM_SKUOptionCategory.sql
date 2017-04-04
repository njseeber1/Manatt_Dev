SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_SKUOptionCategory](
	[SKUID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[AllowAllOptions] [bit] NULL,
	[SKUCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[SKUCategoryOrder] [int] NULL,
 CONSTRAINT [PK_COM_SKUOptionCategory] PRIMARY KEY CLUSTERED 
(
	[SKUCategoryID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_SKUOptionCategory_CategoryID] ON [dbo].[COM_SKUOptionCategory]
(
	[CategoryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_SKUOptionCategory_SKUID] ON [dbo].[COM_SKUOptionCategory]
(
	[SKUID] ASC
)
GO
ALTER TABLE [dbo].[COM_SKUOptionCategory]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKUOptionCategory_CategoryID_COM_OptionCategory] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[COM_OptionCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[COM_SKUOptionCategory] CHECK CONSTRAINT [FK_COM_SKUOptionCategory_CategoryID_COM_OptionCategory]
GO
ALTER TABLE [dbo].[COM_SKUOptionCategory]  WITH CHECK ADD  CONSTRAINT [FK_COM_SKUOptionCategory_SKUID_COM_SKU] FOREIGN KEY([SKUID])
REFERENCES [dbo].[COM_SKU] ([SKUID])
GO
ALTER TABLE [dbo].[COM_SKUOptionCategory] CHECK CONSTRAINT [FK_COM_SKUOptionCategory_SKUID_COM_SKU]
GO
