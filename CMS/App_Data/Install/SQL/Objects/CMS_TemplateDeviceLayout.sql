SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_TemplateDeviceLayout](
	[TemplateDeviceLayoutID] [int] IDENTITY(1,1) NOT NULL,
	[PageTemplateID] [int] NOT NULL,
	[ProfileID] [int] NOT NULL,
	[LayoutID] [int] NULL,
	[LayoutCode] [nvarchar](max) NULL,
	[LayoutType] [nvarchar](50) NULL,
	[LayoutCSS] [nvarchar](max) NULL,
	[LayoutLastModified] [datetime2](7) NOT NULL,
	[LayoutGUID] [uniqueidentifier] NOT NULL,
	[LayoutVersionGUID] [nvarchar](50) NULL,
 CONSTRAINT [PK_CMS_TemplateDeviceLayout] PRIMARY KEY CLUSTERED 
(
	[TemplateDeviceLayoutID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_TemplateDeviceLayout_LayoutID] ON [dbo].[CMS_TemplateDeviceLayout]
(
	[LayoutID] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_TemplateDeviceLayout_PageTemplateID_ProfileID] ON [dbo].[CMS_TemplateDeviceLayout]
(
	[PageTemplateID] ASC,
	[ProfileID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_TemplateDeviceLayout_ProfileID] ON [dbo].[CMS_TemplateDeviceLayout]
(
	[ProfileID] ASC
)
GO
ALTER TABLE [dbo].[CMS_TemplateDeviceLayout] ADD  CONSTRAINT [DEFAULT_CMS_TemplateDeviceLayout_LayoutLastModified]  DEFAULT ('7/31/2012 12:10:49 PM') FOR [LayoutLastModified]
GO
ALTER TABLE [dbo].[CMS_TemplateDeviceLayout] ADD  CONSTRAINT [DEFAULT_CMS_TemplateDeviceLayout_LayoutGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [LayoutGUID]
GO
ALTER TABLE [dbo].[CMS_TemplateDeviceLayout]  WITH CHECK ADD  CONSTRAINT [FK_CMS_TemplateDeviceLayout_LayoutID_CMS_Layout] FOREIGN KEY([LayoutID])
REFERENCES [dbo].[CMS_Layout] ([LayoutID])
GO
ALTER TABLE [dbo].[CMS_TemplateDeviceLayout] CHECK CONSTRAINT [FK_CMS_TemplateDeviceLayout_LayoutID_CMS_Layout]
GO
ALTER TABLE [dbo].[CMS_TemplateDeviceLayout]  WITH CHECK ADD  CONSTRAINT [FK_CMS_TemplateDeviceLayout_PageTemplateID_CMS_PageTemplate] FOREIGN KEY([PageTemplateID])
REFERENCES [dbo].[CMS_PageTemplate] ([PageTemplateID])
GO
ALTER TABLE [dbo].[CMS_TemplateDeviceLayout] CHECK CONSTRAINT [FK_CMS_TemplateDeviceLayout_PageTemplateID_CMS_PageTemplate]
GO
ALTER TABLE [dbo].[CMS_TemplateDeviceLayout]  WITH CHECK ADD  CONSTRAINT [FK_CMS_TemplateDeviceLayout_ProfileID_CMS_DeviceProfile] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[CMS_DeviceProfile] ([ProfileID])
GO
ALTER TABLE [dbo].[CMS_TemplateDeviceLayout] CHECK CONSTRAINT [FK_CMS_TemplateDeviceLayout_ProfileID_CMS_DeviceProfile]
GO
