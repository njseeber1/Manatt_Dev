SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog_PostSubscription](
	[SubscriptionID] [int] IDENTITY(1,1) NOT NULL,
	[SubscriptionPostDocumentID] [int] NOT NULL,
	[SubscriptionUserID] [int] NULL,
	[SubscriptionEmail] [nvarchar](250) NULL,
	[SubscriptionLastModified] [datetime2](7) NOT NULL,
	[SubscriptionGUID] [uniqueidentifier] NOT NULL,
	[SubscriptionApproved] [bit] NULL,
	[SubscriptionApprovalHash] [nvarchar](100) NULL,
 CONSTRAINT [PK_Blog_PostSubscription] PRIMARY KEY CLUSTERED 
(
	[SubscriptionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Blog_PostSubscription_SubscriptionPostDocumentID] ON [dbo].[Blog_PostSubscription]
(
	[SubscriptionPostDocumentID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Blog_PostSubscription_SubscriptionUserID] ON [dbo].[Blog_PostSubscription]
(
	[SubscriptionUserID] ASC
)
GO
ALTER TABLE [dbo].[Blog_PostSubscription]  WITH CHECK ADD  CONSTRAINT [FK_Blog_PostSubscription_SubscriptionPostDocumentID_CMS_Document] FOREIGN KEY([SubscriptionPostDocumentID])
REFERENCES [dbo].[CMS_Document] ([DocumentID])
GO
ALTER TABLE [dbo].[Blog_PostSubscription] CHECK CONSTRAINT [FK_Blog_PostSubscription_SubscriptionPostDocumentID_CMS_Document]
GO
ALTER TABLE [dbo].[Blog_PostSubscription]  WITH CHECK ADD  CONSTRAINT [FK_Blog_PostSubscription_SubscriptionUserID_CMS_User] FOREIGN KEY([SubscriptionUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Blog_PostSubscription] CHECK CONSTRAINT [FK_Blog_PostSubscription_SubscriptionUserID_CMS_User]
GO
