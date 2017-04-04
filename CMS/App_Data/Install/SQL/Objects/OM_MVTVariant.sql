SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_MVTVariant](
	[MVTVariantID] [int] IDENTITY(1,1) NOT NULL,
	[MVTVariantName] [nvarchar](100) NOT NULL,
	[MVTVariantDisplayName] [nvarchar](200) NOT NULL,
	[MVTVariantInstanceGUID] [uniqueidentifier] NULL,
	[MVTVariantZoneID] [nvarchar](200) NULL,
	[MVTVariantPageTemplateID] [int] NOT NULL,
	[MVTVariantEnabled] [bit] NOT NULL,
	[MVTVariantWebParts] [nvarchar](max) NULL,
	[MVTVariantGUID] [uniqueidentifier] NOT NULL,
	[MVTVariantLastModified] [datetime2](7) NOT NULL,
	[MVTVariantDescription] [nvarchar](max) NULL,
	[MVTVariantDocumentID] [int] NULL,
 CONSTRAINT [PK_OM_MVTVariant] PRIMARY KEY CLUSTERED 
(
	[MVTVariantID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_MVTVariant_MVTVariantPageTemplateID] ON [dbo].[OM_MVTVariant]
(
	[MVTVariantPageTemplateID] ASC
)
GO
ALTER TABLE [dbo].[OM_MVTVariant] ADD  CONSTRAINT [DEFAULT_OM_MVTVariant_MVTVariantName]  DEFAULT (N'') FOR [MVTVariantName]
GO
ALTER TABLE [dbo].[OM_MVTVariant] ADD  CONSTRAINT [DEFAULT_OM_MVTVariant_MVTVariantEnabled]  DEFAULT ((1)) FOR [MVTVariantEnabled]
GO
ALTER TABLE [dbo].[OM_MVTVariant]  WITH CHECK ADD  CONSTRAINT [FK_OM_MVTVariant_MVTVariantPageTemplateID_CMS_PageTemplate] FOREIGN KEY([MVTVariantPageTemplateID])
REFERENCES [dbo].[CMS_PageTemplate] ([PageTemplateID])
GO
ALTER TABLE [dbo].[OM_MVTVariant] CHECK CONSTRAINT [FK_OM_MVTVariant_MVTVariantPageTemplateID_CMS_PageTemplate]
GO
