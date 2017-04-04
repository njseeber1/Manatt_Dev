SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_RelationshipNameSite](
	[RelationshipNameID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_RelationshipNameSite] PRIMARY KEY CLUSTERED 
(
	[RelationshipNameID] ASC,
	[SiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_RelationshipNameSite_SiteID] ON [dbo].[CMS_RelationshipNameSite]
(
	[SiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_RelationshipNameSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_RelationshipNameSite_RelationshipNameID_CMS_RelationshipName] FOREIGN KEY([RelationshipNameID])
REFERENCES [dbo].[CMS_RelationshipName] ([RelationshipNameID])
GO
ALTER TABLE [dbo].[CMS_RelationshipNameSite] CHECK CONSTRAINT [FK_CMS_RelationshipNameSite_RelationshipNameID_CMS_RelationshipName]
GO
ALTER TABLE [dbo].[CMS_RelationshipNameSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_RelationshipNameSite_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_RelationshipNameSite] CHECK CONSTRAINT [FK_CMS_RelationshipNameSite_SiteID_CMS_Site]
GO
