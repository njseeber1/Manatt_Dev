SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_TranslationService](
	[TranslationServiceID] [int] IDENTITY(1,1) NOT NULL,
	[TranslationServiceAssemblyName] [nvarchar](200) NOT NULL,
	[TranslationServiceClassName] [nvarchar](200) NOT NULL,
	[TranslationServiceName] [nvarchar](200) NOT NULL,
	[TranslationServiceDisplayName] [nvarchar](200) NOT NULL,
	[TranslationServiceIsMachine] [bit] NOT NULL,
	[TranslationServiceLastModified] [datetime2](7) NOT NULL,
	[TranslationServiceGUID] [uniqueidentifier] NOT NULL,
	[TranslationServiceEnabled] [bit] NOT NULL,
	[TranslationServiceSupportsInstructions] [bit] NULL,
	[TranslationServiceSupportsPriority] [bit] NULL,
	[TranslationServiceSupportsDeadline] [bit] NULL,
	[TranslationServiceGenerateTargetTag] [bit] NULL,
	[TranslationServiceParameter] [nvarchar](1000) NULL,
	[TranslationServiceSupportsStatusUpdate] [bit] NULL,
	[TranslationServiceSupportsCancel] [bit] NULL,
 CONSTRAINT [PK_CMS_TranslationService] PRIMARY KEY CLUSTERED 
(
	[TranslationServiceID] ASC
)
)

GO
ALTER TABLE [dbo].[CMS_TranslationService] ADD  CONSTRAINT [DEFAULT_CMS_TranslationService_TranslationServiceGenerateTargetTag]  DEFAULT ((0)) FOR [TranslationServiceGenerateTargetTag]
GO
ALTER TABLE [dbo].[CMS_TranslationService] ADD  CONSTRAINT [DEFAULT_CMS_TranslationService_TranslationServiceSupportsStatusUpdate]  DEFAULT ((0)) FOR [TranslationServiceSupportsStatusUpdate]
GO
ALTER TABLE [dbo].[CMS_TranslationService] ADD  CONSTRAINT [DEFAULT_CMS_TranslationService_TranslationServiceSupportsCancel]  DEFAULT ((0)) FOR [TranslationServiceSupportsCancel]
GO
