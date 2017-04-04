SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_CleanOnlineUsers]
	@InactiveForSeconds INT,
	@LeaveRoomSystemMessageFormat NVARCHAR(max),
	@SystemMessageType INT
AS
BEGIN
	DECLARE @Cleaned INT
	SET @Cleaned = 0
	
	DECLARE @ChatUserID INT
	DECLARE @SiteID INT
	DECLARE @InactiveUsersCursor CURSOR

	SET @InactiveUsersCursor = CURSOR FAST_FORWARD
	FOR
	SELECT ChatOnlineUserChatUserID, ChatOnlineUserSiteID
	FROM Chat_OnlineUser
	WHERE DATEADD(s, @InactiveForSeconds, ChatOnlineUserLastChecking) < GETDATE()

	OPEN @InactiveUsersCursor
	
	FETCH NEXT FROM @InactiveUsersCursor
	INTO @ChatUserID, @SiteID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC Proc_Chat_Logout
			@SiteID = @SiteID,
			@ChatUserID = @ChatUserID,
			@LeaveRoomSystemMessageFormat = @LeaveRoomSystemMessageFormat,
			@SystemMessageType = @SystemMessageType
		
		SET @Cleaned = @Cleaned + 1
		
		FETCH NEXT FROM @InactiveUsersCursor
		INTO @ChatUserID, @SiteID
	END

	CLOSE @InactiveUsersCursor
	DEALLOCATE @InactiveUsersCursor
	
	SELECT @Cleaned
END


GO
