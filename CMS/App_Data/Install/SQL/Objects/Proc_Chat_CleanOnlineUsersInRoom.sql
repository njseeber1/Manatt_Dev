SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_CleanOnlineUsersInRoom]
	@InactiveForSeconds INT,
	@LeaveRoomSystemMessageFormat NVARCHAR(max),
	@SystemMessageType INT
AS
BEGIN
	DECLARE @Now DATETIME
	SET @Now = GETDATE()
	
	DECLARE @ClearedUsersCursor CURSOR
	
	DECLARE @ChatUserID INT
	DECLARE @ChatRoomID INT
	
	DECLARE @Cleaned INT
	
	SET @Cleaned = 0

	SET @ClearedUsersCursor = CURSOR FAST_FORWARD
	FOR
	SELECT CRU.ChatRoomUserChatUserID, CRU.ChatRoomUserRoomID
	FROM Chat_RoomUser AS CRU
	WHERE DATEADD(s, @InactiveForSeconds, CRU.ChatRoomUserLastChecking) < @Now


	OPEN @ClearedUsersCursor

	
	FETCH NEXT FROM @ClearedUsersCursor
	INTO @ChatUserID, @ChatRoomID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC [Proc_Chat_LeaveRoom]
			@ChatUserID = @ChatUserID,
			@ChatRoomID = @ChatRoomID,
			@LeaveRoomSystemMessageFormat = @LeaveRoomSystemMessageFormat,
			@SystemMessageType = @SystemMessageType
			
		SET @Cleaned = @Cleaned + 1
			
		FETCH NEXT FROM @ClearedUsersCursor
		INTO @ChatUserID, @ChatRoomID
	END
	

	CLOSE @ClearedUsersCursor
	DEALLOCATE @ClearedUsersCursor
	
	-- Threshold when kick expiration will be removed from the user's record
	-- Is not set to @Now to leave a little bit of additional time, in which the record will be visible on the web server
	-- (the time is set to server's time, so it should stay there longer in case the IIS and SQL times are different)
	DECLARE @KickExpirationThreshold DATETIME;
	SET @KickExpirationThreshold = DATEADD(HOUR, -1,  @Now);

	-- Reset kicked state of users
	UPDATE Chat_RoomUser
	SET ChatRoomUserKickExpiration = NULL
	WHERE ChatRoomUserKickExpiration IS NOT NULL AND ChatRoomUserKickExpiration < @KickExpirationThreshold
	
	SELECT @Cleaned
END


GO
