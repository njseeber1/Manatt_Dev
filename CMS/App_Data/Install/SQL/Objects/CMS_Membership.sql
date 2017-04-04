SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_Membership](
	[MembershipID] [int] IDENTITY(1,1) NOT NULL,
	[MembershipName] [nvarchar](200) NOT NULL,
	[MembershipDisplayName] [nvarchar](200) NOT NULL,
	[MembershipDescription] [nvarchar](max) NULL,
	[MembershipLastModified] [datetime2](7) NOT NULL,
	[MembershipGUID] [uniqueidentifier] NOT NULL,
	[MembershipSiteID] [int] NULL,
 CONSTRAINT [PK_CMS_Membership] PRIMARY KEY CLUSTERED 
(
	[MembershipID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_Membership_MembershipSiteID] ON [dbo].[CMS_Membership]
(
	[MembershipSiteID] ASC
)
GO
ALTER TABLE [dbo].[CMS_Membership]  WITH CHECK ADD  CONSTRAINT [FK_CMS_Membership_MembershipSiteID_CMS_Site] FOREIGN KEY([MembershipSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_Membership] CHECK CONSTRAINT [FK_CMS_Membership_MembershipSiteID_CMS_Site]
GO
