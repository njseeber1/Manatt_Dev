SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_LeaveRoom] 
	@ChatUserID INT,
	@ChatRoomID INT,
	@LeaveRoomSystemMessageFormat NVARCHAR(max),
	@SystemMessageType INT
AS
BEGIN
	DECLARE @Now DATETIME
	SET @Now = GETDATE()
	
	DECLARE @Nickname NVARCHAR(max)


	UPDATE Chat_RoomUser 
	SET ChatRoomUserLastChecking = NULL, ChatRoomUserJoinTime = NULL, ChatRoomUserLeaveTime = @Now, ChatRoomUserLastModification = @Now
	WHERE ChatRoomUserChatUserID = @ChatUserID AND ChatRoomUserRoomID = @ChatRoomID AND ChatRoomUserJoinTime IS NOT NULL
	
	IF @@ROWCOUNT > 0 AND @LeaveRoomSystemMessageFormat IS NOT NULL
	BEGIN
		SELECT @Nickname = CU.ChatUserNickname
		FROM Chat_User CU
		WHERE CU.ChatUserID = @ChatUserID
		
		INSERT INTO Chat_Message 
		([ChatMessageCreatedWhen], [ChatMessageIPAddress], [ChatMessageUserID], [ChatMessageRoomID], [ChatMessageRejected], [ChatMessageLastModified], [ChatMessageText], [ChatMessageSystemMessageType], [ChatMessageRecipientID] ) 
		VALUES (@Now, '', NULL, @ChatRoomID, 0, @Now, REPLACE(@LeaveRoomSystemMessageFormat, '{nickname}', @Nickname), @SystemMessageType, null)
	END
	
END


GO
