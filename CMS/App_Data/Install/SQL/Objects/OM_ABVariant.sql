SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_ABVariant](
	[ABVariantID] [int] IDENTITY(1,1) NOT NULL,
	[ABVariantDisplayName] [nvarchar](110) NOT NULL,
	[ABVariantName] [nvarchar](50) NOT NULL,
	[ABVariantTestID] [int] NOT NULL,
	[ABVariantPath] [nvarchar](450) NOT NULL,
	[ABVariantGUID] [uniqueidentifier] NOT NULL,
	[ABVariantLastModified] [datetime2](7) NOT NULL,
	[ABVariantSiteID] [int] NOT NULL,
 CONSTRAINT [PK_OM_ABVariant] PRIMARY KEY CLUSTERED 
(
	[ABVariantID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_ABVariant_ABVariantSiteID] ON [dbo].[OM_ABVariant]
(
	[ABVariantSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_ABVariant_ABVariantTestID] ON [dbo].[OM_ABVariant]
(
	[ABVariantTestID] ASC
)
GO
ALTER TABLE [dbo].[OM_ABVariant] ADD  CONSTRAINT [DEFAULT_OM_ABVariant_ABVariantDisplayName]  DEFAULT ('') FOR [ABVariantDisplayName]
GO
ALTER TABLE [dbo].[OM_ABVariant] ADD  CONSTRAINT [DEFAULT_OM_ABVariant_ABVariantName]  DEFAULT (N'') FOR [ABVariantName]
GO
ALTER TABLE [dbo].[OM_ABVariant] ADD  CONSTRAINT [DEFAULT_OM_ABVariant_ABVariantSiteID]  DEFAULT ((0)) FOR [ABVariantSiteID]
GO
ALTER TABLE [dbo].[OM_ABVariant]  WITH CHECK ADD  CONSTRAINT [FK_OM_ABVariant_ABVariantTestID_OM_ABTest] FOREIGN KEY([ABVariantTestID])
REFERENCES [dbo].[OM_ABTest] ([ABTestID])
GO
ALTER TABLE [dbo].[OM_ABVariant] CHECK CONSTRAINT [FK_OM_ABVariant_ABVariantTestID_OM_ABTest]
GO
ALTER TABLE [dbo].[OM_ABVariant]  WITH CHECK ADD  CONSTRAINT [FK_OM_ABVariant_CMS_Site] FOREIGN KEY([ABVariantSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_ABVariant] CHECK CONSTRAINT [FK_OM_ABVariant_CMS_Site]
GO
