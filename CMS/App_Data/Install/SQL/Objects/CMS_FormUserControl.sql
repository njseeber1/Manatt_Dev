SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_FormUserControl](
	[UserControlID] [int] IDENTITY(1,1) NOT NULL,
	[UserControlDisplayName] [nvarchar](200) NOT NULL,
	[UserControlCodeName] [nvarchar](200) NOT NULL,
	[UserControlFileName] [nvarchar](400) NOT NULL,
	[UserControlForText] [bit] NOT NULL,
	[UserControlForLongText] [bit] NOT NULL,
	[UserControlForInteger] [bit] NOT NULL,
	[UserControlForDecimal] [bit] NOT NULL,
	[UserControlForDateTime] [bit] NOT NULL,
	[UserControlForBoolean] [bit] NOT NULL,
	[UserControlForFile] [bit] NOT NULL,
	[UserControlShowInBizForms] [bit] NOT NULL,
	[UserControlDefaultDataType] [nvarchar](50) NOT NULL,
	[UserControlDefaultDataTypeSize] [int] NULL,
	[UserControlShowInDocumentTypes] [bit] NULL,
	[UserControlShowInSystemTables] [bit] NULL,
	[UserControlShowInWebParts] [bit] NULL,
	[UserControlShowInReports] [bit] NULL,
	[UserControlGUID] [uniqueidentifier] NOT NULL,
	[UserControlLastModified] [datetime2](7) NOT NULL,
	[UserControlForGuid] [bit] NOT NULL,
	[UserControlShowInCustomTables] [bit] NULL,
	[UserControlForVisibility] [bit] NOT NULL,
	[UserControlParameters] [nvarchar](max) NULL,
	[UserControlForDocAttachments] [bit] NOT NULL,
	[UserControlResourceID] [int] NULL,
	[UserControlType] [int] NULL,
	[UserControlParentID] [int] NULL,
	[UserControlDescription] [nvarchar](max) NULL,
	[UserControlThumbnailGUID] [uniqueidentifier] NULL,
	[UserControlPriority] [int] NULL,
	[UserControlIsSystem] [bit] NULL,
	[UserControlForBinary] [bit] NOT NULL,
	[UserControlForDocRelationships] [bit] NOT NULL,
 CONSTRAINT [PK_CMS_FormUserControl] PRIMARY KEY NONCLUSTERED 
(
	[UserControlID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_FormUserControl_UserControlDisplayName] ON [dbo].[CMS_FormUserControl]
(
	[UserControlDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_FormUserControl_UserControlParentID] ON [dbo].[CMS_FormUserControl]
(
	[UserControlParentID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_FormUserControl_UserControlResourceID] ON [dbo].[CMS_FormUserControl]
(
	[UserControlResourceID] ASC
)
GO
ALTER TABLE [dbo].[CMS_FormUserControl] ADD  CONSTRAINT [DEFAULT_CMS_FormUserControl_UserControlForGuid]  DEFAULT ((0)) FOR [UserControlForGuid]
GO
ALTER TABLE [dbo].[CMS_FormUserControl] ADD  CONSTRAINT [DEFAULT_cms_FormUserControl_UserControlShowInCustomTables]  DEFAULT ((0)) FOR [UserControlShowInCustomTables]
GO
ALTER TABLE [dbo].[CMS_FormUserControl] ADD  CONSTRAINT [DEFAULT_CMS_FormUserControl_UserControlForVisibility]  DEFAULT ((0)) FOR [UserControlForVisibility]
GO
ALTER TABLE [dbo].[CMS_FormUserControl] ADD  CONSTRAINT [DEFAULT_CMS_FormUserControl_UserControlForDocAttachments]  DEFAULT ((0)) FOR [UserControlForDocAttachments]
GO
ALTER TABLE [dbo].[CMS_FormUserControl] ADD  CONSTRAINT [DEFAULT_CMS_FormUserControl_UserControlPriority]  DEFAULT ((0)) FOR [UserControlPriority]
GO
ALTER TABLE [dbo].[CMS_FormUserControl] ADD  CONSTRAINT [DEFAULT_CMS_FormUserControl_UserControlIsSystem]  DEFAULT ((0)) FOR [UserControlIsSystem]
GO
ALTER TABLE [dbo].[CMS_FormUserControl] ADD  CONSTRAINT [DEFAULT_CMS_FormUserControl_UserControlForBinary]  DEFAULT ((0)) FOR [UserControlForBinary]
GO
ALTER TABLE [dbo].[CMS_FormUserControl] ADD  CONSTRAINT [DEFAULT_CMS_FormUserControl_UserControlForDocRelationships]  DEFAULT ((0)) FOR [UserControlForDocRelationships]
GO
ALTER TABLE [dbo].[CMS_FormUserControl]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_FormUserControl_UserControlParentID_CMS_FormUserControl] FOREIGN KEY([UserControlParentID])
REFERENCES [dbo].[CMS_FormUserControl] ([UserControlID])
GO
ALTER TABLE [dbo].[CMS_FormUserControl] CHECK CONSTRAINT [FK_CMS_FormUserControl_UserControlParentID_CMS_FormUserControl]
GO
ALTER TABLE [dbo].[CMS_FormUserControl]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_FormUserControl_UserControlResourceID_CMS_Resource] FOREIGN KEY([UserControlResourceID])
REFERENCES [dbo].[CMS_Resource] ([ResourceID])
GO
ALTER TABLE [dbo].[CMS_FormUserControl] CHECK CONSTRAINT [FK_CMS_FormUserControl_UserControlResourceID_CMS_Resource]
GO
