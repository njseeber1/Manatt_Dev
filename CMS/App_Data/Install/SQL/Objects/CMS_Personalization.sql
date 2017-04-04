SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Personalization](
	[PersonalizationID] [int] IDENTITY(1,1) NOT NULL,
	[PersonalizationGUID] [uniqueidentifier] NOT NULL,
	[PersonalizationLastModified] [datetime2](7) NOT NULL,
	[PersonalizationUserID] [int] NULL,
	[PersonalizationDocumentID] [int] NULL,
	[PersonalizationWebParts] [nvarchar](max) NULL,
	[PersonalizationDashboardName] [nvarchar](200) NULL,
	[PersonalizationSiteID] [int] NULL,
 CONSTRAINT [PK_CMS_Personalization] PRIMARY KEY NONCLUSTERED 
(
	[PersonalizationID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_CMS_Personalization_PersonalizationUserID_PersonalizationDocumentID] ON [dbo].[CMS_Personalization]
(
	[PersonalizationDocumentID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_Personalization_PersonalizationID_PersonalizationUserID_PersonalizationDocumentID_PersonalizationDashboardName] ON [dbo].[CMS_Personalization]
(
	[PersonalizationID] ASC,
	[PersonalizationUserID] ASC,
	[PersonalizationDocumentID] ASC,
	[PersonalizationDashboardName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Personalization_PersonalizationSiteID_SiteID] ON [dbo].[CMS_Personalization]
(
	[PersonalizationSiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_Personalization_PersonalizationUserID] ON [dbo].[CMS_Personalization]
(
	[PersonalizationUserID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Personalization] ADD  CONSTRAINT [DEFAULT_CMS_Personalization_PersonalizationGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [PersonalizationGUID]
GO
ALTER TABLE [dbo].[CMS_Personalization] ADD  CONSTRAINT [DEFAULT_CMS_Personalization_PersonalizationLastModified]  DEFAULT ('9/2/2008 5:36:59 PM') FOR [PersonalizationLastModified]
GO
ALTER TABLE [dbo].[CMS_Personalization]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Personalization_CMS_Personalization] FOREIGN KEY([PersonalizationID])
REFERENCES [dbo].[CMS_Personalization] ([PersonalizationID])
GO
ALTER TABLE [dbo].[CMS_Personalization] CHECK CONSTRAINT [FK_CMS_Personalization_CMS_Personalization]
GO
ALTER TABLE [dbo].[CMS_Personalization]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Personalization_PersonalizationDocumentID_CMS_Document] FOREIGN KEY([PersonalizationDocumentID])
REFERENCES [dbo].[CMS_Document] ([DocumentID])
GO
ALTER TABLE [dbo].[CMS_Personalization] CHECK CONSTRAINT [FK_CMS_Personalization_PersonalizationDocumentID_CMS_Document]
GO
ALTER TABLE [dbo].[CMS_Personalization]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Personalization_PersonalizationSiteID_CMS_Site] FOREIGN KEY([PersonalizationSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_Personalization] CHECK CONSTRAINT [FK_CMS_Personalization_PersonalizationSiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_Personalization]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Personalization_PersonalizationUserID_CMS_User] FOREIGN KEY([PersonalizationUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_Personalization] CHECK CONSTRAINT [FK_CMS_Personalization_PersonalizationUserID_CMS_User]
GO
