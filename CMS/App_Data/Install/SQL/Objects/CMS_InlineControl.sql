SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_InlineControl](
	[ControlID] [int] IDENTITY(1,1) NOT NULL,
	[ControlDisplayName] [nvarchar](200) NOT NULL,
	[ControlName] [nvarchar](200) NOT NULL,
	[ControlParameterName] [nvarchar](200) NULL,
	[ControlDescription] [nvarchar](max) NULL,
	[ControlGUID] [uniqueidentifier] NOT NULL,
	[ControlLastModified] [datetime2](7) NOT NULL,
	[ControlFileName] [nvarchar](1000) NOT NULL,
	[ControlProperties] [nvarchar](max) NULL,
	[ControlResourceID] [int] NULL,
	[ControlModule] [int] NULL,
 CONSTRAINT [PK_CMS_InlineControl] PRIMARY KEY NONCLUSTERED 
(
	[ControlID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_InlineControl_ControlDisplayName] ON [dbo].[CMS_InlineControl]
(
	[ControlDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_InlineControl_ControlResourceID] ON [dbo].[CMS_InlineControl]
(
	[ControlResourceID] ASC
)
GO
ALTER TABLE [dbo].[CMS_InlineControl] ADD  CONSTRAINT [DEFAULT_CMS_InlineControl_ControlDisplayName]  DEFAULT ('') FOR [ControlDisplayName]
GO
ALTER TABLE [dbo].[CMS_InlineControl] ADD  CONSTRAINT [DEFAULT_CMS_InlineControl_ControlName]  DEFAULT ('') FOR [ControlName]
GO
ALTER TABLE [dbo].[CMS_InlineControl] ADD  CONSTRAINT [DEFAULT_CMS_InlineControl_ControlFileName]  DEFAULT ('') FOR [ControlFileName]
GO
ALTER TABLE [dbo].[CMS_InlineControl]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_InlineControl_ControlResourceID_CMS_Resource] FOREIGN KEY([ControlResourceID])
REFERENCES [dbo].[CMS_Resource] ([ResourceID])
GO
ALTER TABLE [dbo].[CMS_InlineControl] CHECK CONSTRAINT [FK_CMS_InlineControl_ControlResourceID_CMS_Resource]
GO
