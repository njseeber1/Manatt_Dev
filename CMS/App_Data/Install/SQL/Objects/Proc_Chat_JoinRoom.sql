SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_JoinRoom]
	@ChatRoomID INT,
	@ChatUserID INT,
	@RoomPassword NVARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Now DATETIME
	SET @Now = GETDATE()
	
	DECLARE @JoinTime DATETIME
	
	SET @JoinTime = (SELECT ChatRoomUserJoinTime FROM Chat_RoomUser WHERE ChatRoomUserRoomID = @ChatRoomID AND ChatRoomUserChatUserID = @ChatUserID)
	
	IF @JoinTime IS NOT NULL
	BEGIN
		UPDATE Chat_RoomUser 
		SET ChatRoomUserLastChecking = @Now, ChatRoomUserKickExpiration = NULL, ChatRoomUserJoinTime = @Now, ChatRoomUserLeaveTime = NULL, ChatRoomUserLastModification = @Now
		WHERE ChatRoomUserRoomID = @ChatRoomID AND ChatRoomUserChatUserID = @ChatUserID
		
		SELECT 0 -- user was already joined, so password does not need to be checked and 0 is returned
		
		RETURN 1
	END
	
	-- user is not joined
	
	IF (SELECT COUNT(ChatRoomID) FROM Chat_Room WHERE ChatRoomID = @ChatRoomID AND ChatRoomEnabled = 1) <> 1
	BEGIN
		SELECT -2 -- room does not exist or is disabled
		
		RETURN 1
	END
			
	IF (SELECT COUNT(ChatRoomID) FROM Chat_Room WHERE ChatRoomID = @ChatRoomID AND (ChatRoomPassword IS NULL OR ChatRoomPassword = '' OR ChatRoomPassword = @RoomPassword)) <> 1
	BEGIN
		SELECT -1 -- password is wrong
		
		RETURN 1
	END
	
	-- user is not joined and password is correct -> join him

	UPDATE Chat_RoomUser 
	SET ChatRoomUserLastChecking = @Now, ChatRoomUserKickExpiration = NULL, ChatRoomUserJoinTime = @Now, ChatRoomUserLeaveTime = NULL, ChatRoomUserLastModification = @Now
	WHERE ChatRoomUserRoomID = @ChatRoomID AND ChatRoomUserChatUserID = @ChatUserID

	IF @@ROWCOUNT = 0
	BEGIN
	   INSERT INTO Chat_RoomUser (ChatRoomUserRoomID, ChatRoomUserChatUserID, ChatRoomUserLastChecking, ChatRoomUserKickExpiration, ChatRoomUserJoinTime, ChatRoomUserLeaveTime, ChatRoomUserAdminLevel, ChatRoomUserLastModification) 
	   VALUES (@ChatRoomID, @ChatUserID, @Now, NULL, @Now, NULL, 0, @Now)
	END

	SELECT 1 -- user was joined by this procedure
END


GO
