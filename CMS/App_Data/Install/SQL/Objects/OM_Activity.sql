SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_Activity](
	[ActivityID] [int] IDENTITY(1,1) NOT NULL,
	[ActivityActiveContactID] [int] NOT NULL,
	[ActivityOriginalContactID] [int] NOT NULL,
	[ActivityCreated] [datetime2](7) NULL,
	[ActivityType] [nvarchar](250) NOT NULL,
	[ActivityItemID] [int] NULL,
	[ActivityItemDetailID] [int] NULL,
	[ActivityValue] [nvarchar](250) NULL,
	[ActivityURL] [nvarchar](max) NULL,
	[ActivityTitle] [nvarchar](250) NULL,
	[ActivitySiteID] [int] NULL,
	[ActivityGUID] [uniqueidentifier] NOT NULL,
	[ActivityIPAddress] [nvarchar](100) NULL,
	[ActivityComment] [nvarchar](max) NULL,
	[ActivityCampaign] [nvarchar](200) NULL,
	[ActivityURLReferrer] [nvarchar](max) NULL,
	[ActivityCulture] [nvarchar](10) NULL,
	[ActivityNodeID] [int] NULL,
 CONSTRAINT [PK_OM_Activity] PRIMARY KEY CLUSTERED 
(
	[ActivityID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_Activity_ActivityActiveContactID] ON [dbo].[OM_Activity]
(
	[ActivityActiveContactID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Activity_ActivityCreated] ON [dbo].[OM_Activity]
(
	[ActivityCreated] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Activity_ActivityItemDetailID] ON [dbo].[OM_Activity]
(
	[ActivityItemDetailID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Activity_ActivityOriginalContactID] ON [dbo].[OM_Activity]
(
	[ActivityOriginalContactID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Activity_ActivitySiteID] ON [dbo].[OM_Activity]
(
	[ActivitySiteID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_OM_Activity_ActivityType] ON [dbo].[OM_Activity]
(
	[ActivityType] ASC
)
GO
ALTER TABLE [dbo].[OM_Activity]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Activity_CMS_Site] FOREIGN KEY([ActivitySiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_Activity] CHECK CONSTRAINT [FK_OM_Activity_CMS_Site]
GO
ALTER TABLE [dbo].[OM_Activity]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Activity_OM_Contact_Active] FOREIGN KEY([ActivityActiveContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_Activity] CHECK CONSTRAINT [FK_OM_Activity_OM_Contact_Active]
GO
ALTER TABLE [dbo].[OM_Activity]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Activity_OM_Contact_Original] FOREIGN KEY([ActivityOriginalContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_Activity] CHECK CONSTRAINT [FK_OM_Activity_OM_Contact_Original]
GO
