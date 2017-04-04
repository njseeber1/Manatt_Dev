SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_DocumentTypeScope](
	[ScopeID] [int] IDENTITY(1,1) NOT NULL,
	[ScopePath] [nvarchar](450) NOT NULL,
	[ScopeSiteID] [int] NULL,
	[ScopeLastModified] [datetime2](7) NOT NULL,
	[ScopeGUID] [uniqueidentifier] NULL,
	[ScopeIncludeChildren] [bit] NULL,
	[ScopeAllowAllTypes] [bit] NULL,
	[ScopeAllowLinks] [bit] NULL,
	[ScopeAllowABVariant] [bit] NULL,
	[ScopeMacroCondition] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_DocumentTypeScope] PRIMARY KEY NONCLUSTERED 
(
	[ScopeID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_DocumentTypeScope_ScopePath] ON [dbo].[CMS_DocumentTypeScope]
(
	[ScopePath] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_DocumentTypeScope_ScopeSiteID] ON [dbo].[CMS_DocumentTypeScope]
(
	[ScopeSiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_DocumentTypeScope] ADD  CONSTRAINT [DEFAULT_CMS_DocumentTypeScope_ScopePath]  DEFAULT ('') FOR [ScopePath]
GO
ALTER TABLE [dbo].[CMS_DocumentTypeScope] ADD  CONSTRAINT [DEFAULT_CMS_DocumentTypeScope_ScopeLastModified]  DEFAULT ('4/30/2013 2:47:21 PM') FOR [ScopeLastModified]
GO
ALTER TABLE [dbo].[CMS_DocumentTypeScope] ADD  CONSTRAINT [DEFAULT_CMS_DocumentTypeScope_ScopeAllowAllTypes]  DEFAULT ((0)) FOR [ScopeAllowAllTypes]
GO
ALTER TABLE [dbo].[CMS_DocumentTypeScope] ADD  CONSTRAINT [DEFAULT_CMS_DocumentTypeScope_ScopeAllowLinks]  DEFAULT ((0)) FOR [ScopeAllowLinks]
GO
ALTER TABLE [dbo].[CMS_DocumentTypeScope] ADD  CONSTRAINT [DEFAULT_CMS_DocumentTypeScope_ScopeAllowABVariant]  DEFAULT ((0)) FOR [ScopeAllowABVariant]
GO
ALTER TABLE [dbo].[CMS_DocumentTypeScope]  WITH CHECK ADD  CONSTRAINT [FK_CMS_DocumentTypeScope_ScopeSiteID_CMS_Site] FOREIGN KEY([ScopeSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_DocumentTypeScope] CHECK CONSTRAINT [FK_CMS_DocumentTypeScope_ScopeSiteID_CMS_Site]
GO
