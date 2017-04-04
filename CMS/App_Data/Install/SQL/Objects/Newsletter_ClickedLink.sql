SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Newsletter_ClickedLink](
	[ClickedLinkID] [int] IDENTITY(1,1) NOT NULL,
	[ClickedLinkGuid] [uniqueidentifier] NOT NULL,
	[ClickedLinkEmail] [nvarchar](400) NOT NULL,
	[ClickedLinkNewsletterLinkID] [int] NOT NULL,
	[ClickedLinkTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Newsletter_ClickedLink] PRIMARY KEY CLUSTERED 
(
	[ClickedLinkID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Newsletter_ClickedLink_ClickedLinkNewsletterLinkID] ON [dbo].[Newsletter_ClickedLink]
(
	[ClickedLinkNewsletterLinkID] ASC
)
GO
ALTER TABLE [dbo].[Newsletter_ClickedLink] ADD  CONSTRAINT [DEFAULT_Newsletter_ClickedLink_ClickedLinkGuid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ClickedLinkGuid]
GO
ALTER TABLE [dbo].[Newsletter_ClickedLink] ADD  CONSTRAINT [DEFAULT_Newsletter_ClickedLink_ClickedLinkEmail]  DEFAULT (N'') FOR [ClickedLinkEmail]
GO
ALTER TABLE [dbo].[Newsletter_ClickedLink] ADD  CONSTRAINT [DEFAULT_Newsletter_ClickedLink_ClickedLinkNewsletterLinkID]  DEFAULT ((0)) FOR [ClickedLinkNewsletterLinkID]
GO
ALTER TABLE [dbo].[Newsletter_ClickedLink]  WITH CHECK ADD  CONSTRAINT [FK_Newsletter_ClickedLink_Newsletter_Link] FOREIGN KEY([ClickedLinkNewsletterLinkID])
REFERENCES [dbo].[Newsletter_Link] ([LinkID])
GO
ALTER TABLE [dbo].[Newsletter_ClickedLink] CHECK CONSTRAINT [FK_Newsletter_ClickedLink_Newsletter_Link]
GO
