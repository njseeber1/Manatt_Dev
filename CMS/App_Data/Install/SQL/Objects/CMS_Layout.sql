SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Layout](
	[LayoutID] [int] IDENTITY(1,1) NOT NULL,
	[LayoutCodeName] [nvarchar](100) NOT NULL,
	[LayoutDisplayName] [nvarchar](200) NOT NULL,
	[LayoutDescription] [nvarchar](max) NULL,
	[LayoutCode] [nvarchar](max) NOT NULL,
	[LayoutVersionGUID] [nvarchar](50) NULL,
	[LayoutGUID] [uniqueidentifier] NOT NULL,
	[LayoutLastModified] [datetime2](7) NOT NULL,
	[LayoutType] [nvarchar](50) NULL,
	[LayoutCSS] [nvarchar](max) NULL,
	[LayoutThumbnailGUID] [uniqueidentifier] NULL,
	[LayoutZoneCount] [int] NULL,
	[LayoutIsConvertible] [bit] NULL,
	[LayoutIconClass] [nvarchar](200) NULL,
 CONSTRAINT [PK_CMS_Layout] PRIMARY KEY CLUSTERED 
(
	[LayoutID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Layout_LayoutDisplayName] ON [dbo].[CMS_Layout]
(
	[LayoutDisplayName] ASC
)
GO
ALTER TABLE [dbo].[CMS_Layout] ADD  CONSTRAINT [DEFAULT_CMS_Layout_LayoutCodeName]  DEFAULT ('') FOR [LayoutCodeName]
GO
ALTER TABLE [dbo].[CMS_Layout] ADD  CONSTRAINT [DEFAULT_CMS_Layout_LayoutDisplayName]  DEFAULT (N'') FOR [LayoutDisplayName]
GO
ALTER TABLE [dbo].[CMS_Layout] ADD  CONSTRAINT [DEFAULT_CMS_Layout_LayoutCode]  DEFAULT ('<cms:CMSWebPartZone ZoneID="zoneA" runat="server" />') FOR [LayoutCode]
GO
ALTER TABLE [dbo].[CMS_Layout] ADD  CONSTRAINT [DEFAULT_CMS_Layout_LayoutGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [LayoutGUID]
GO
ALTER TABLE [dbo].[CMS_Layout] ADD  CONSTRAINT [DEFAULT_CMS_Layout_LayoutIsConvertible]  DEFAULT ((0)) FOR [LayoutIsConvertible]
GO
