SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Form](
	[FormID] [int] IDENTITY(1,1) NOT NULL,
	[FormDisplayName] [nvarchar](100) NOT NULL,
	[FormName] [nvarchar](100) NOT NULL,
	[FormSendToEmail] [nvarchar](400) NULL,
	[FormSendFromEmail] [nvarchar](400) NULL,
	[FormEmailSubject] [nvarchar](250) NULL,
	[FormEmailTemplate] [nvarchar](max) NULL,
	[FormEmailAttachUploadedDocs] [bit] NULL,
	[FormClassID] [int] NOT NULL,
	[FormItems] [int] NOT NULL,
	[FormReportFields] [nvarchar](max) NULL,
	[FormRedirectToUrl] [nvarchar](400) NULL,
	[FormDisplayText] [nvarchar](max) NULL,
	[FormClearAfterSave] [bit] NOT NULL,
	[FormSubmitButtonText] [nvarchar](400) NULL,
	[FormSiteID] [int] NOT NULL,
	[FormConfirmationEmailField] [nvarchar](100) NULL,
	[FormConfirmationTemplate] [nvarchar](max) NULL,
	[FormConfirmationSendFromEmail] [nvarchar](400) NULL,
	[FormConfirmationEmailSubject] [nvarchar](250) NULL,
	[FormAccess] [int] NULL,
	[FormSubmitButtonImage] [nvarchar](255) NULL,
	[FormGUID] [uniqueidentifier] NOT NULL,
	[FormLastModified] [datetime2](7) NOT NULL,
	[FormLogActivity] [bit] NULL,
 CONSTRAINT [PK_CMS_Form] PRIMARY KEY NONCLUSTERED 
(
	[FormID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_Form_FormDisplayName] ON [dbo].[CMS_Form]
(
	[FormDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Form_FormClassID] ON [dbo].[CMS_Form]
(
	[FormClassID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Form_FormSiteID] ON [dbo].[CMS_Form]
(
	[FormSiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DEFAULT_CMS_Form_FormDisplayName]  DEFAULT ('') FOR [FormDisplayName]
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DEFAULT_CMS_Form_FormName]  DEFAULT ('') FOR [FormName]
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DEFAULT_CMS_Form_FormEmailAttachUploadedDocs]  DEFAULT ((0)) FOR [FormEmailAttachUploadedDocs]
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DF__CMS_Form__FormIt__2739D489]  DEFAULT ((0)) FOR [FormItems]
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DF__CMS_Form__FormCl__2645B050]  DEFAULT ((0)) FOR [FormClearAfterSave]
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DEFAULT_CMS_Form_FormSubmitButtonText]  DEFAULT (N'') FOR [FormSubmitButtonText]
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DEFAULT_CMS_Form_FormConfirmationEmailField]  DEFAULT (N'') FOR [FormConfirmationEmailField]
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DEFAULT_CMS_Form_FormConfirmationSendFromEmail]  DEFAULT (N'') FOR [FormConfirmationSendFromEmail]
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DEFAULT_CMS_Form_FormConfirmationEmailSubject]  DEFAULT (N'') FOR [FormConfirmationEmailSubject]
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DEFAULT_CMS_Form_FormGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [FormGUID]
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DEFAULT_CMS_Form_FormLastModified]  DEFAULT ('9/17/2012 1:37:08 PM') FOR [FormLastModified]
GO
ALTER TABLE [dbo].[CMS_Form] ADD  CONSTRAINT [DEFAULT_CMS_Form_FormLogActivity]  DEFAULT ((1)) FOR [FormLogActivity]
GO
ALTER TABLE [dbo].[CMS_Form]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Form_FormClassID_CMS_Class] FOREIGN KEY([FormClassID])
REFERENCES [dbo].[CMS_Class] ([ClassID])
GO
ALTER TABLE [dbo].[CMS_Form] CHECK CONSTRAINT [FK_CMS_Form_FormClassID_CMS_Class]
GO
ALTER TABLE [dbo].[CMS_Form]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Form_FormSiteID_CMS_Site] FOREIGN KEY([FormSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_Form] CHECK CONSTRAINT [FK_CMS_Form_FormSiteID_CMS_Site]
GO
