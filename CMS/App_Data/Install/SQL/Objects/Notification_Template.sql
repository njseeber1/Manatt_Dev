SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification_Template](
	[TemplateID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateName] [nvarchar](200) NOT NULL,
	[TemplateDisplayName] [nvarchar](200) NOT NULL,
	[TemplateSiteID] [int] NULL,
	[TemplateLastModified] [datetime2](7) NOT NULL,
	[TemplateGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Notification_Template] PRIMARY KEY NONCLUSTERED 
(
	[TemplateID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Notification_Template_TemplateSiteID_TemplateDisplayName] ON [dbo].[Notification_Template]
(
	[TemplateSiteID] ASC,
	[TemplateDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Notification_Template_TemplateSiteID] ON [dbo].[Notification_Template]
(
	[TemplateSiteID] ASC
)
GO
ALTER TABLE [dbo].[Notification_Template] ADD  CONSTRAINT [DEFAULT_Notification_Template_TemplateName]  DEFAULT ('') FOR [TemplateName]
GO
ALTER TABLE [dbo].[Notification_Template] ADD  CONSTRAINT [DEFAULT_Notification_Template_TemplateDisplayName]  DEFAULT ('') FOR [TemplateDisplayName]
GO
ALTER TABLE [dbo].[Notification_Template]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Template_TemplateSiteID_CMS_Site] FOREIGN KEY([TemplateSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Notification_Template] CHECK CONSTRAINT [FK_Notification_Template_TemplateSiteID_CMS_Site]
GO
