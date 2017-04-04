SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_WebPartContainerSite](
	[ContainerID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_WebPartContainerSite] PRIMARY KEY CLUSTERED 
(
	[ContainerID] ASC,
	[SiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_WebPartContainerSite_SiteID] ON [dbo].[CMS_WebPartContainerSite]
(
	[SiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_WebPartContainerSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WebPartContainerSite_ContainerID_CMS_WebPartContainer] FOREIGN KEY([ContainerID])
REFERENCES [dbo].[CMS_WebPartContainer] ([ContainerID])
GO
ALTER TABLE [dbo].[CMS_WebPartContainerSite] CHECK CONSTRAINT [FK_CMS_WebPartContainerSite_ContainerID_CMS_WebPartContainer]
GO
ALTER TABLE [dbo].[CMS_WebPartContainerSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_WebPartContainerSite_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_WebPartContainerSite] CHECK CONSTRAINT [FK_CMS_WebPartContainerSite_SiteID_CMS_Site]
GO
