SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat_InitiatedChatRequest](
	[InitiatedChatRequestID] [int] IDENTITY(1,1) NOT NULL,
	[InitiatedChatRequestUserID] [int] NULL,
	[InitiatedChatRequestContactID] [int] NULL,
	[InitiatedChatRequestRoomID] [int] NOT NULL,
	[InitiatedChatRequestState] [int] NOT NULL,
	[InitiatedChatRequestInitiatorName] [nvarchar](100) NOT NULL,
	[InitiatedChatRequestInitiatorChatUserID] [int] NOT NULL,
	[InitiatedChatRequestLastModification] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Chat_InitiatedChatRequest] PRIMARY KEY CLUSTERED 
(
	[InitiatedChatRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
 CONSTRAINT [UQ_Chat_InitiatedChatRequest_RoomID] UNIQUE NONCLUSTERED 
(
	[InitiatedChatRequestRoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
 CONSTRAINT [UQ_Chat_InitiatedChatRequest_UserIDContactID] UNIQUE NONCLUSTERED 
(
	[InitiatedChatRequestUserID] ASC,
	[InitiatedChatRequestContactID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Chat_InitiatedChatRequest_InitiatedChatRequestInitiatorChatUserID] ON [dbo].[Chat_InitiatedChatRequest]
(
	[InitiatedChatRequestInitiatorChatUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_InitiatedChatRequest_InitiatedChatRequestRoomID] ON [dbo].[Chat_InitiatedChatRequest]
(
	[InitiatedChatRequestRoomID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Chat_InitiatedChatRequest_InitiatedChatRequestUserID] ON [dbo].[Chat_InitiatedChatRequest]
(
	[InitiatedChatRequestUserID] ASC
)
GO
ALTER TABLE [dbo].[Chat_InitiatedChatRequest] ADD  CONSTRAINT [DEFAULT_Chat_InitiatedChatRequest_InitiatedChatRequestState]  DEFAULT ((1)) FOR [InitiatedChatRequestState]
GO
ALTER TABLE [dbo].[Chat_InitiatedChatRequest]  WITH CHECK ADD  CONSTRAINT [FK_Chat_InitiatedChatRequest_Chat_Room] FOREIGN KEY([InitiatedChatRequestRoomID])
REFERENCES [dbo].[Chat_Room] ([ChatRoomID])
GO
ALTER TABLE [dbo].[Chat_InitiatedChatRequest] CHECK CONSTRAINT [FK_Chat_InitiatedChatRequest_Chat_Room]
GO
ALTER TABLE [dbo].[Chat_InitiatedChatRequest]  WITH CHECK ADD  CONSTRAINT [FK_Chat_InitiatedChatRequest_Chat_User] FOREIGN KEY([InitiatedChatRequestInitiatorChatUserID])
REFERENCES [dbo].[Chat_User] ([ChatUserID])
GO
ALTER TABLE [dbo].[Chat_InitiatedChatRequest] CHECK CONSTRAINT [FK_Chat_InitiatedChatRequest_Chat_User]
GO
ALTER TABLE [dbo].[Chat_InitiatedChatRequest]  WITH CHECK ADD  CONSTRAINT [FK_Chat_InitiatedChatRequest_CMS_User] FOREIGN KEY([InitiatedChatRequestUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Chat_InitiatedChatRequest] CHECK CONSTRAINT [FK_Chat_InitiatedChatRequest_CMS_User]
GO
