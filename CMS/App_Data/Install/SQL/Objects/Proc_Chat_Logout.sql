SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_Logout]
	@SiteID INT,
	@ChatUserID INT,
	@LeaveRoomSystemMessageFormat NVARCHAR(max),
	@SystemMessageType INT
AS
BEGIN
	DECLARE @Now DATETIME
	SET @Now = GETDATE()
	
	DECLARE @IsOnSupport BIT
	SET @IsOnSupport = CASE WHEN EXISTS (SELECT * FROM Chat_OnlineSupport WHERE ChatOnlineSupportChatUserID = @ChatUserID) THEN 1 ELSE 0 END;
	
	
	IF @IsOnSupport = 0
	BEGIN
	    -- 'Leave' user from table Chat_OnlineUser if he isn't online at support
	    UPDATE Chat_OnlineUser
	    SET ChatOnlineUserJoinTime = NULL, ChatOnlineUserLeaveTime = @Now, ChatOnlineUserLastChecking = NULL, ChatOnlineUserToken = NULL
	    WHERE ChatOnlineUserSiteID = @SiteID AND ChatOnlineUserChatUserID = @ChatUserID AND ChatOnlineUserJoinTime IS NOT NULL
	END
	ELSE
    BEGIN
	    -- Only set him to hidden if he is on support
	    UPDATE Chat_OnlineUser
	    SET ChatOnlineUserJoinTime = @Now, ChatOnlineUserLastChecking = @Now
	    WHERE ChatOnlineUserSiteID = @SiteID AND ChatOnlineUserChatUserID = @ChatUserID AND ChatOnlineUserJoinTime IS NOT NULL
    END
	
	-- If user was actually updated (he was online), 'leave' him also from all rooms
	IF @@ROWCOUNT > 0
	BEGIN
		DECLARE @ClearedUsersCursor CURSOR
		
		DECLARE @ChatRoomID INT

		SET @ClearedUsersCursor = CURSOR FAST_FORWARD
		FOR
		SELECT CRU.ChatRoomUserRoomID
		FROM Chat_RoomUser AS CRU
		LEFT JOIN Chat_Room AS CR ON CRU.ChatRoomUserRoomID = CR.ChatRoomID
		LEFT JOIN Chat_User AS CU ON CRU.ChatRoomUserChatUserID = CU.ChatUserID
		WHERE 
		    CRU.ChatRoomUserChatUserID = @ChatUserID AND 
		    (CR.ChatRoomSiteID = @SiteID OR CR.ChatRoomSiteID IS NULL) AND 
		    CRU.ChatRoomUserJoinTime IS NOT NULL AND
		    (@IsOnSupport = 0 OR CR.ChatRoomIsSupport = 0) -- If user is online at support do not kick him from support rooms


		OPEN @ClearedUsersCursor

		
		FETCH NEXT FROM @ClearedUsersCursor
		INTO @ChatRoomID

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC [Proc_Chat_LeaveRoom]
				@ChatUserID = @ChatUserID,
				@ChatRoomID = @ChatRoomID,
				@LeaveRoomSystemMessageFormat = @LeaveRoomSystemMessageFormat,
				@SystemMessageType = @SystemMessageType
				
			FETCH NEXT FROM @ClearedUsersCursor
			INTO @ChatRoomID
		END
		

		CLOSE @ClearedUsersCursor
		DEALLOCATE @ClearedUsersCursor
		
		-- If user is anonymous, set his last modified to NOW, because he has to be removed from lists of online users in private rooms
		-- Chat Service has to know, that something has changed (it is checking LastModified in Chat_RoomUser and Chat_User)
		-- His admin states has also be changed to None
		IF (SELECT ChatUserUserID FROM Chat_User WHERE ChatUserID = @ChatUserID) IS NULL
		BEGIN
			UPDATE Chat_RoomUser 
			SET ChatRoomUserLastModification = @Now, ChatRoomUserAdminLevel = 0
			WHERE ChatRoomUserChatUserID = @ChatUserID
		END
	END
END


GO
