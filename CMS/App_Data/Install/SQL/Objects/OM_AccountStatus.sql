SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_AccountStatus](
	[AccountStatusID] [int] IDENTITY(1,1) NOT NULL,
	[AccountStatusName] [nvarchar](200) NOT NULL,
	[AccountStatusDisplayName] [nvarchar](200) NOT NULL,
	[AccountStatusDescription] [nvarchar](max) NULL,
	[AccountStatusSiteID] [int] NULL,
 CONSTRAINT [PK_OM_AccountStatus] PRIMARY KEY CLUSTERED 
(
	[AccountStatusID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_AccountStatus_AccountStatusSiteID] ON [dbo].[OM_AccountStatus]
(
	[AccountStatusSiteID] ASC
)
GO
ALTER TABLE [dbo].[OM_AccountStatus]  WITH CHECK ADD  CONSTRAINT [FK_OM_AccountStatus_CMS_Site] FOREIGN KEY([AccountStatusSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_AccountStatus] CHECK CONSTRAINT [FK_OM_AccountStatus_CMS_Site]
GO
