SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Board_Subscription](
	[SubscriptionID] [int] IDENTITY(1,1) NOT NULL,
	[SubscriptionBoardID] [int] NOT NULL,
	[SubscriptionUserID] [int] NULL,
	[SubscriptionEmail] [nvarchar](250) NOT NULL,
	[SubscriptionLastModified] [datetime2](7) NOT NULL,
	[SubscriptionGUID] [uniqueidentifier] NOT NULL,
	[SubscriptionApproved] [bit] NULL,
	[SubscriptionApprovalHash] [nvarchar](100) NULL,
 CONSTRAINT [PK_Board_Subscription] PRIMARY KEY CLUSTERED 
(
	[SubscriptionID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Board_Subscription_SubscriptionBoardID] ON [dbo].[Board_Subscription]
(
	[SubscriptionBoardID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Board_Subscription_SubscriptionUserID] ON [dbo].[Board_Subscription]
(
	[SubscriptionUserID] ASC
)
GO
ALTER TABLE [dbo].[Board_Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Board_Subscription_SubscriptionBoardID_Board_Board] FOREIGN KEY([SubscriptionBoardID])
REFERENCES [dbo].[Board_Board] ([BoardID])
GO
ALTER TABLE [dbo].[Board_Subscription] CHECK CONSTRAINT [FK_Board_Subscription_SubscriptionBoardID_Board_Board]
GO
ALTER TABLE [dbo].[Board_Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Board_Subscription_SubscriptionUserID_CMS_User] FOREIGN KEY([SubscriptionUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Board_Subscription] CHECK CONSTRAINT [FK_Board_Subscription_SubscriptionUserID_CMS_User]
GO
