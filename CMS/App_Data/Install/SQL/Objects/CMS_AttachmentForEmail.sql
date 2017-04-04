SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_AttachmentForEmail](
	[EmailID] [int] NOT NULL,
	[AttachmentID] [int] NOT NULL,
 CONSTRAINT [PK_CMS_AttachmentForEmail] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC,
	[AttachmentID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_AttachmentForEmail_AttachmentID] ON [dbo].[CMS_AttachmentForEmail]
(
	[AttachmentID] ASC
)
GO
ALTER TABLE [dbo].[CMS_AttachmentForEmail]  WITH CHECK ADD  CONSTRAINT [FK_CMS_AttachmentForEmail_AttachmentID_CMS_EmailAttachment] FOREIGN KEY([AttachmentID])
REFERENCES [dbo].[CMS_EmailAttachment] ([AttachmentID])
GO
ALTER TABLE [dbo].[CMS_AttachmentForEmail] CHECK CONSTRAINT [FK_CMS_AttachmentForEmail_AttachmentID_CMS_EmailAttachment]
GO
ALTER TABLE [dbo].[CMS_AttachmentForEmail]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_AttachmentForEmail_EmailID_CMS_Email] FOREIGN KEY([EmailID])
REFERENCES [dbo].[CMS_Email] ([EmailID])
GO
ALTER TABLE [dbo].[CMS_AttachmentForEmail] CHECK CONSTRAINT [FK_CMS_AttachmentForEmail_EmailID_CMS_Email]
GO
