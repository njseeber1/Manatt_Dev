SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_TranslationSubmissionItem](
	[SubmissionItemID] [int] IDENTITY(1,1) NOT NULL,
	[SubmissionItemSubmissionID] [int] NOT NULL,
	[SubmissionItemSourceXLIFF] [nvarchar](max) NULL,
	[SubmissionItemTargetXLIFF] [nvarchar](max) NULL,
	[SubmissionItemObjectType] [nvarchar](100) NOT NULL,
	[SubmissionItemObjectID] [int] NOT NULL,
	[SubmissionItemGUID] [uniqueidentifier] NOT NULL,
	[SubmissionItemLastModified] [datetime2](7) NOT NULL,
	[SubmissionItemName] [nvarchar](200) NOT NULL,
	[SubmissionItemWordCount] [int] NULL,
	[SubmissionItemCharCount] [int] NULL,
	[SubmissionItemCustomData] [nvarchar](max) NULL,
	[SubmissionItemTargetObjectID] [int] NOT NULL,
	[SubmissionItemType] [nvarchar](50) NULL,
	[SubmissionItemTargetCulture] [nvarchar](10) NULL,
 CONSTRAINT [PK_CMS_TranslationSubmissionItem] PRIMARY KEY CLUSTERED 
(
	[SubmissionItemID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_TranslationSubmissionItem_SubmissionItemSubmissionID] ON [dbo].[CMS_TranslationSubmissionItem]
(
	[SubmissionItemSubmissionID] ASC
)
GO
ALTER TABLE [dbo].[CMS_TranslationSubmissionItem]  WITH CHECK ADD  CONSTRAINT [FK_CMS_TranslationSubmissionItem_CMS_TranslationSubmission] FOREIGN KEY([SubmissionItemSubmissionID])
REFERENCES [dbo].[CMS_TranslationSubmission] ([SubmissionID])
GO
ALTER TABLE [dbo].[CMS_TranslationSubmissionItem] CHECK CONSTRAINT [FK_CMS_TranslationSubmissionItem_CMS_TranslationSubmission]
GO
