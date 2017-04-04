SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_PageTemplateScope](
	[PageTemplateScopeID] [int] IDENTITY(1,1) NOT NULL,
	[PageTemplateScopePath] [nvarchar](450) NOT NULL,
	[PageTemplateScopeLevels] [nvarchar](450) NULL,
	[PageTemplateScopeCultureID] [int] NULL,
	[PageTemplateScopeClassID] [int] NULL,
	[PageTemplateScopeTemplateID] [int] NOT NULL,
	[PageTemplateScopeSiteID] [int] NULL,
	[PageTemplateScopeLastModified] [datetime2](7) NOT NULL,
	[PageTemplateScopeGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CMS_PageTemplateScope] PRIMARY KEY NONCLUSTERED 
(
	[PageTemplateScopeID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_PageTemplateScope_PageTemplateScopePath] ON [dbo].[CMS_PageTemplateScope]
(
	[PageTemplateScopePath] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplateScope_PageTemplateScopeClassID] ON [dbo].[CMS_PageTemplateScope]
(
	[PageTemplateScopeClassID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplateScope_PageTemplateScopeCultureID] ON [dbo].[CMS_PageTemplateScope]
(
	[PageTemplateScopeCultureID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplateScope_PageTemplateScopeLevels] ON [dbo].[CMS_PageTemplateScope]
(
	[PageTemplateScopeLevels] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplateScope_PageTemplateScopeSiteID] ON [dbo].[CMS_PageTemplateScope]
(
	[PageTemplateScopeSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_PageTemplateScope_PageTemplateScopeTemplateID] ON [dbo].[CMS_PageTemplateScope]
(
	[PageTemplateScopeTemplateID] ASC
)
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplateScope_PageTemplateScopePath]  DEFAULT ('') FOR [PageTemplateScopePath]
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplateScope_PageTemplateScopeTemplateID]  DEFAULT ((0)) FOR [PageTemplateScopeTemplateID]
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplateScope_PageTemplateScopeLastModified]  DEFAULT ('2/22/2010 9:30:07 AM') FOR [PageTemplateScopeLastModified]
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope] ADD  CONSTRAINT [DEFAULT_CMS_PageTemplateScope_PageTemplateScopeGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [PageTemplateScopeGUID]
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope]  WITH CHECK ADD  CONSTRAINT [FK_CMS_PageTemplateScope_PageTemplateScopeClassID_CMS_Class] FOREIGN KEY([PageTemplateScopeClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope] CHECK CONSTRAINT [FK_CMS_PageTemplateScope_PageTemplateScopeClassID_CMS_Class]
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope]  WITH CHECK ADD  CONSTRAINT [FK_CMS_PageTemplateScope_PageTemplateScopeCultureID_CMS_Culture] FOREIGN KEY([PageTemplateScopeCultureID])
REFERENCES [dbo].[CMS_Culture] ([CultureID])
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope] CHECK CONSTRAINT [FK_CMS_PageTemplateScope_PageTemplateScopeCultureID_CMS_Culture]
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope]  WITH CHECK ADD  CONSTRAINT [FK_CMS_PageTemplateScope_PageTemplateScopeSiteID_CMS_Site] FOREIGN KEY([PageTemplateScopeSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope] CHECK CONSTRAINT [FK_CMS_PageTemplateScope_PageTemplateScopeSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope]  WITH CHECK ADD  CONSTRAINT [FK_CMS_PageTemplateScope_PageTemplateScopeTemplateID_CMS_PageTemplate] FOREIGN KEY([PageTemplateScopeTemplateID])
REFERENCES [dbo].[CMS_PageTemplate] ([PageTemplateID])
GO
ALTER TABLE [dbo].[CMS_PageTemplateScope] CHECK CONSTRAINT [FK_CMS_PageTemplateScope_PageTemplateScopeTemplateID_CMS_PageTemplate]
GO
