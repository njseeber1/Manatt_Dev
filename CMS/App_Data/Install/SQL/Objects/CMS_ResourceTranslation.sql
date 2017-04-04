SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_ResourceTranslation](
	[TranslationID] [int] IDENTITY(1,1) NOT NULL,
	[TranslationStringID] [int] NOT NULL,
	[TranslationText] [nvarchar](max) NULL,
	[TranslationCultureID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_ResourceTranslation] PRIMARY KEY CLUSTERED 
(
	[TranslationID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_ResourceTranslation_TranslationCultureID] ON [dbo].[CMS_ResourceTranslation]
(
	[TranslationCultureID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_ResourceTranslation_TranslationStringID] ON [dbo].[CMS_ResourceTranslation]
(
	[TranslationStringID] ASC
)
GO
ALTER TABLE [dbo].[CMS_ResourceTranslation]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ResourceTranslation_TranslationCultureID_CMS_Culture] FOREIGN KEY([TranslationCultureID])
REFERENCES [dbo].[CMS_Culture] ([CultureID])
GO
ALTER TABLE [dbo].[CMS_ResourceTranslation] CHECK CONSTRAINT [FK_CMS_ResourceTranslation_TranslationCultureID_CMS_Culture]
GO
ALTER TABLE [dbo].[CMS_ResourceTranslation]  WITH CHECK ADD  CONSTRAINT [FK_CMS_ResourceTranslation_TranslationStringID_CMS_ResourceString] FOREIGN KEY([TranslationStringID])
REFERENCES [dbo].[CMS_ResourceString] ([StringID])
GO
ALTER TABLE [dbo].[CMS_ResourceTranslation] CHECK CONSTRAINT [FK_CMS_ResourceTranslation_TranslationStringID_CMS_ResourceString]
GO
