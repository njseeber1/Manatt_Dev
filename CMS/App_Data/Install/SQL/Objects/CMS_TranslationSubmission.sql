SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_TranslationSubmission](
	[SubmissionID] [int] IDENTITY(1,1) NOT NULL,
	[SubmissionName] [nvarchar](200) NOT NULL,
	[SubmissionTicket] [nvarchar](200) NULL,
	[SubmissionStatus] [int] NOT NULL,
	[SubmissionServiceID] [int] NOT NULL,
	[SubmissionSourceCulture] [nvarchar](10) NOT NULL,
	[SubmissionTargetCulture] [nvarchar](max) NOT NULL,
	[SubmissionPriority] [int] NOT NULL,
	[SubmissionDeadline] [datetime2](7) NULL,
	[SubmissionInstructions] [nvarchar](500) NULL,
	[SubmissionLastModified] [datetime2](7) NOT NULL,
	[SubmissionGUID] [uniqueidentifier] NOT NULL,
	[SubmissionSiteID] [int] NULL,
	[SubmissionPrice] [float] NULL,
	[SubmissionStatusMessage] [nvarchar](max) NULL,
	[SubmissionTranslateAttachments] [bit] NULL,
	[SubmissionItemCount] [int] NOT NULL,
	[SubmissionDate] [datetime2](7) NOT NULL,
	[SubmissionWordCount] [int] NULL,
	[SubmissionCharCount] [int] NULL,
	[SubmissionSubmittedByUserID] [int] NULL,
 CONSTRAINT [PK_CMS_TranslationSubmission] PRIMARY KEY CLUSTERED 
(
	[SubmissionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_TranslationSubmission] ON [dbo].[CMS_TranslationSubmission]
(
	[SubmissionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_TranslationSubmission_SubmissionServiceID] ON [dbo].[CMS_TranslationSubmission]
(
	[SubmissionServiceID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_TranslationSubmission_SubmissionSubmittedByUserID] ON [dbo].[CMS_TranslationSubmission]
(
	[SubmissionSubmittedByUserID] ASC
)
GO
ALTER TABLE [dbo].[CMS_TranslationSubmission] ADD  CONSTRAINT [DEFAULT_CMS_TranslationSubmission_SubmissionTargetCulture]  DEFAULT (N'') FOR [SubmissionTargetCulture]
GO
ALTER TABLE [dbo].[CMS_TranslationSubmission]  WITH CHECK ADD  CONSTRAINT [FK_CMS_TranslationSubmission_CMS_TranslationService] FOREIGN KEY([SubmissionServiceID])
REFERENCES [dbo].[CMS_TranslationService] ([TranslationServiceID])
GO
ALTER TABLE [dbo].[CMS_TranslationSubmission] CHECK CONSTRAINT [FK_CMS_TranslationSubmission_CMS_TranslationService]
GO
ALTER TABLE [dbo].[CMS_TranslationSubmission]  WITH CHECK ADD  CONSTRAINT [FK_CMS_TranslationSubmission_CMS_User] FOREIGN KEY([SubmissionSubmittedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_TranslationSubmission] CHECK CONSTRAINT [FK_CMS_TranslationSubmission_CMS_User]
GO
