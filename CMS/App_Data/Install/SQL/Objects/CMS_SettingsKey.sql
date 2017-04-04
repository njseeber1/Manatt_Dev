SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_SettingsKey](
	[KeyID] [int] IDENTITY(1,1) NOT NULL,
	[KeyName] [nvarchar](100) NOT NULL,
	[KeyDisplayName] [nvarchar](200) NOT NULL,
	[KeyDescription] [nvarchar](max) NULL,
	[KeyValue] [nvarchar](max) NULL,
	[KeyType] [nvarchar](50) NOT NULL,
	[KeyCategoryID] [int] NULL,
	[SiteID] [int] NULL,
	[KeyGUID] [uniqueidentifier] NOT NULL,
	[KeyLastModified] [datetime2](7) NOT NULL,
	[KeyOrder] [int] NULL,
	[KeyDefaultValue] [nvarchar](max) NULL,
	[KeyValidation] [nvarchar](255) NULL,
	[KeyEditingControlPath] [nvarchar](200) NULL,
	[KeyLoadGeneration] [int] NOT NULL,
	[KeyIsGlobal] [bit] NULL,
	[KeyIsCustom] [bit] NULL,
	[KeyIsHidden] [bit] NULL,
	[KeyFormControlSettings] [nvarchar](max) NULL,
	[KeyExplanationText] [nvarchar](max) NULL,
 CONSTRAINT [PK_CMS_SettingsKey] PRIMARY KEY NONCLUSTERED 
(
	[KeyID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_SettingsKey_KeyLoadGeneration_SiteID] ON [dbo].[CMS_SettingsKey]
(
	[KeyLoadGeneration] ASC,
	[SiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_SettingsKey_KeyCategoryID] ON [dbo].[CMS_SettingsKey]
(
	[KeyCategoryID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_CMS_SettingsKey_SiteID_KeyName] ON [dbo].[CMS_SettingsKey]
(
	[SiteID] ASC,
	[KeyName] ASC
)
INCLUDE ( 	[KeyValue])
GO
ALTER TABLE [dbo].[CMS_SettingsKey] ADD  CONSTRAINT [DEFAULT_CMS_SettingsKey_KeyName]  DEFAULT ('') FOR [KeyName]
GO
ALTER TABLE [dbo].[CMS_SettingsKey] ADD  CONSTRAINT [DEFAULT_CMS_SettingsKey_KeyDisplayName]  DEFAULT ('') FOR [KeyDisplayName]
GO
ALTER TABLE [dbo].[CMS_SettingsKey] ADD  CONSTRAINT [DEFAULT_CMS_SettingsKey_KeyType]  DEFAULT ('') FOR [KeyType]
GO
ALTER TABLE [dbo].[CMS_SettingsKey] ADD  CONSTRAINT [DEFAULT_CMS_SettingsKey_KeyGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [KeyGUID]
GO
ALTER TABLE [dbo].[CMS_SettingsKey] ADD  CONSTRAINT [DEFAULT_CMS_SettingsKey_KeyLoadGeneration]  DEFAULT ((0)) FOR [KeyLoadGeneration]
GO
ALTER TABLE [dbo].[CMS_SettingsKey] ADD  CONSTRAINT [DEFAULT_CMS_SettingsKey_KeyIsGlobal]  DEFAULT ((0)) FOR [KeyIsGlobal]
GO
ALTER TABLE [dbo].[CMS_SettingsKey] ADD  CONSTRAINT [DEFAULT_CMS_SettingsKey_KeyIsCustom]  DEFAULT ((0)) FOR [KeyIsCustom]
GO
ALTER TABLE [dbo].[CMS_SettingsKey] ADD  CONSTRAINT [DEFAULT_CMS_SettingsKey_KeyIsHidden]  DEFAULT ((0)) FOR [KeyIsHidden]
GO
ALTER TABLE [dbo].[CMS_SettingsKey] ADD  CONSTRAINT [DEFAULT_CMS_SettingsKey_KeyExplanationText]  DEFAULT (N'') FOR [KeyExplanationText]
GO
ALTER TABLE [dbo].[CMS_SettingsKey]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_SettingsKey_KeyCategoryID_CMS_SettingsCategory] FOREIGN KEY([KeyCategoryID])
REFERENCES [dbo].[CMS_SettingsCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[CMS_SettingsKey] CHECK CONSTRAINT [FK_CMS_SettingsKey_KeyCategoryID_CMS_SettingsCategory]
GO
ALTER TABLE [dbo].[CMS_SettingsKey]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_SettingsKey_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_SettingsKey] CHECK CONSTRAINT [FK_CMS_SettingsKey_SiteID_CMS_Site]
GO
