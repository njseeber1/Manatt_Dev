SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Proc_Chat_InsertNotification]
	@SenderID INT,
	@ReceiverID INT,
	@Type INT,
	@RoomID INT,
	@SiteID INT
AS
BEGIN
    DECLARE @Existing INT

    -- Select number of existing notifications which are unread and the same as the notification we are about to insert
	SELECT @Existing = COUNT(*)
	FROM Chat_Notification
	WHERE ChatNotificationSenderID = @SenderID 
		AND ChatNotificationReceiverID = @ReceiverID 
		AND ChatNotificationIsRead = 0 
		AND ChatNotificationType = @Type 
		AND ((@RoomID IS NULL AND ChatNotificationRoomID IS NULL) OR ChatNotificationRoomID = @RoomID)

    IF (@Existing = 0)
	    INSERT INTO Chat_Notification (ChatNotificationSenderID, ChatNotificationReceiverID, ChatNotificationIsRead, ChatNotificationType, ChatNotificationRoomID, ChatNotificationSendDateTime, ChatNotificationReadDateTime, ChatNotificationSiteID)
	    VALUES (@SenderID, @ReceiverID, 0, @Type, @RoomID, GETDATE(), NULL, @SiteID)
END



GO
