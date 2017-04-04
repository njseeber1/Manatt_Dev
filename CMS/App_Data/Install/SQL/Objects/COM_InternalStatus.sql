SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_InternalStatus](
	[InternalStatusID] [int] IDENTITY(1,1) NOT NULL,
	[InternalStatusName] [nvarchar](200) NOT NULL,
	[InternalStatusDisplayName] [nvarchar](200) NOT NULL,
	[InternalStatusEnabled] [bit] NOT NULL,
	[InternalStatusGUID] [uniqueidentifier] NOT NULL,
	[InternalStatusLastModified] [datetime2](7) NOT NULL,
	[InternalStatusSiteID] [int] NULL,
 CONSTRAINT [PK_COM_InternalStatus] PRIMARY KEY NONCLUSTERED 
(
	[InternalStatusID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_InternalStatus_InternalStatusDisplayName_InternalStatusEnabled] ON [dbo].[COM_InternalStatus]
(
	[InternalStatusDisplayName] ASC,
	[InternalStatusEnabled] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_InternalStatus_InternalStatusSiteID] ON [dbo].[COM_InternalStatus]
(
	[InternalStatusSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_InternalStatus] ADD  CONSTRAINT [DEFAULT_COM_InternalStatus_InternalStatusName]  DEFAULT (N'') FOR [InternalStatusName]
GO
ALTER TABLE [dbo].[COM_InternalStatus] ADD  CONSTRAINT [DEFAULT_COM_InternalStatus_InternalStatusDisplayName]  DEFAULT (N'') FOR [InternalStatusDisplayName]
GO
ALTER TABLE [dbo].[COM_InternalStatus] ADD  CONSTRAINT [DEFAULT_COM_InternalStatus_InternalStatusEnabled]  DEFAULT ((1)) FOR [InternalStatusEnabled]
GO
ALTER TABLE [dbo].[COM_InternalStatus] ADD  CONSTRAINT [DEFAULT_COM_InternalStatus_InternalStatusGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [InternalStatusGUID]
GO
ALTER TABLE [dbo].[COM_InternalStatus] ADD  CONSTRAINT [DEFAULT_COM_InternalStatus_InternalStatusLastModified]  DEFAULT ('9/20/2012 2:45:44 PM') FOR [InternalStatusLastModified]
GO
ALTER TABLE [dbo].[COM_InternalStatus]  WITH CHECK ADD  CONSTRAINT [FK_COM_InternalStatus_InternalStatusSiteID_CMS_Site] FOREIGN KEY([InternalStatusSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_InternalStatus] CHECK CONSTRAINT [FK_COM_InternalStatus_InternalStatusSiteID_CMS_Site]
GO
