SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_CleanOldChatRecords]
	@DaysOld INT
AS
BEGIN
	DECLARE @Now DATETIME
	SET @Now = GETDATE()

	DECLARE @MessagesDeleted INT
	DECLARE @RoomsDeleted INT
	DECLARE @UsersDeleted INT

	-- First step: delete old messages
	DELETE CM 
	FROM Chat_Message AS CM 
	WHERE DATEDIFF(DD, CM.ChatMessageLastModified, @Now) > @DaysOld

	SET @MessagesDeleted = @@ROWCOUNT

	-- Second step: delete old rooms which are not used anymore
	DECLARE @RoomsToDelete TABLE (RoomID INT);

	-- Find unused rooms and store their IDs to table variable
	INSERT @RoomsToDelete
	SELECT CR.ChatRoomID
	FROM Chat_Room CR
	WHERE CR.ChatRoomPrivate = 1 -- private rooms only
	AND NOT EXISTS (SELECT ChatMessageID FROM Chat_Message CM WHERE CM.ChatMessageRoomID = CR.ChatRoomID) -- without messages
	AND DATEDIFF(dd, CR.ChatRoomCreatedWhen, @Now) > @DaysOld -- was created more than @DaysOld days ago
	AND NOT EXISTS (
		SELECT ChatUserID 
		FROM Chat_RoomUser CRU
		LEFT JOIN Chat_User CU ON CU.ChatUserID = CRU.ChatRoomUserChatUserID
		WHERE
		CRU.ChatRoomUserRoomID = CR.ChatRoomID
		AND
		(
			(CU.ChatUserUserID IS NOT NULL AND CRU.ChatRoomUserAdminLevel > 0) -- without non anonymous users with more than 'None' permissions
			OR (CU.ChatUserUserID IS NULL AND (CRU.ChatRoomUserJoinTime IS NOT NULL OR DATEDIFF(dd, CRU.ChatRoomUserLeaveTime, @Now) < @DaysOld)) -- without anonymous users who are online or were online less than @DaysOld days ago
		))

	-- Delete room's dependencies
	DELETE [Chat_SupportTakenRoom] WHERE [ChatSupportTakenRoomRoomID] IN (SELECT RoomID FROM @RoomsToDelete);
	DELETE [Chat_InitiatedChatRequest] WHERE [InitiatedChatRequestRoomID] IN (SELECT RoomID FROM @RoomsToDelete);
	DELETE [Chat_RoomUser] WHERE [ChatRoomUserRoomID] IN (SELECT RoomID FROM @RoomsToDelete);
	DELETE [Chat_Notification] WHERE [ChatNotificationRoomID] IN (SELECT RoomID FROM @RoomsToDelete);
	DELETE [Chat_Message] WHERE [ChatMessageRoomID] IN (SELECT RoomID FROM @RoomsToDelete);

	-- Delete rooms
	DELETE [Chat_Room] WHERE [ChatRoomID] IN (SELECT RoomID FROM @RoomsToDelete);

	SET @RoomsDeleted = @@ROWCOUNT

	-- Third step: delete inactive anonymous users
	DECLARE @ChatUsersToDelete TABLE (ChatUserID INT);

	-- Find inactive users and store their IDs to table variable
	INSERT @ChatUsersToDelete
	SELECT CU.ChatUserID
	FROM Chat_User AS CU
	WHERE CU.ChatUserUserID IS NULL -- anonymous users only
	AND NOT EXISTS (SELECT ChatMessageID FROM Chat_Message CM WHERE CM.ChatMessageUserID = CU.ChatUserID OR CM.ChatMessageRecipientID = CU.ChatUserID) -- without messages
	AND NOT EXISTS (SELECT ChatOnlineUserID FROM Chat_OnlineUser COU WHERE COU.ChatOnlineUserChatUserID = CU.ChatUserID AND (COU.ChatOnlineUserJoinTime IS NOT NULL OR DATEDIFF(dd, COU.ChatOnlineUserLeaveTime, @Now) < @DaysOld)) -- user is not online and was online more than @DaysOld days ago
	
	-- Delete user's dependencies
	DELETE FROM [Chat_OnlineUser] WHERE [ChatOnlineUserChatUserID] IN (SELECT ChatUserID FROM @ChatUsersToDelete)
	DELETE FROM [Chat_InitiatedChatRequest] WHERE [InitiatedChatRequestInitiatorChatUserID] IN (SELECT ChatUserID FROM @ChatUsersToDelete)
	DELETE FROM [Chat_OnlineSupport] WHERE [ChatOnlineSupportChatUserID] IN (SELECT ChatUserID FROM @ChatUsersToDelete)
	DELETE FROM [Chat_SupportCannedResponse] WHERE [ChatSupportCannedResponseChatUserID] IN (SELECT ChatUserID FROM @ChatUsersToDelete)
	DELETE FROM [Chat_Message] WHERE [ChatMessageRecipientID] IN (SELECT ChatUserID FROM @ChatUsersToDelete) OR [ChatMessageUserID] IN (SELECT ChatUserID FROM @ChatUsersToDelete)
	DELETE FROM [Chat_RoomUser] WHERE [ChatRoomUserChatUserID] IN (SELECT ChatUserID FROM @ChatUsersToDelete)
	DELETE FROM [Chat_SupportTakenRoom] WHERE [ChatSupportTakenRoomChatUserID] IN (SELECT ChatUserID FROM @ChatUsersToDelete)
	DELETE FROM [Chat_Notification] WHERE [ChatNotificationReceiverID] IN (SELECT ChatUserID FROM @ChatUsersToDelete) OR [ChatNotificationSenderID] IN (SELECT ChatUserID FROM @ChatUsersToDelete)
	UPDATE [Chat_Room] SET [ChatRoomCreatedByChatUserID] = NULL WHERE [ChatRoomCreatedByChatUserID] IN (SELECT ChatUserID FROM @ChatUsersToDelete)

	-- Delete users
	DELETE FROM [Chat_User] WHERE [ChatUserID] IN (SELECT ChatUserID FROM @ChatUsersToDelete)

	SET @UsersDeleted = @@ROWCOUNT

	SELECT @MessagesDeleted AS MessagesDeleted, @RoomsDeleted AS RoomsDeleted, @UsersDeleted AS UsersDeleted
END


GO
