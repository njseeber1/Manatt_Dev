SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_LoginToChat]
	@SiteID INT,
	@ChatUserID INT,
	@Hidden BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Now DATETIME;
	DECLARE @LoginToken NVARCHAR(50);
	
	SET @Now = GETDATE();
	
	-- Check if user is already logged in
	SELECT @LoginToken = ChatOnlineUserToken
	FROM [Chat_OnlineUser]
	WHERE ChatOnlineUserSiteID = @SiteID AND ChatOnlineUserChatUserID = @ChatUserID AND ChatOnlineUserJoinTime IS NOT NULL
	
	-- User is not online right now
	IF @LoginToken IS NULL
	BEGIN
	    -- generate new token
    	SET @LoginToken = NEWID();
    	
    	-- Try to update (if user was previously online)
	    UPDATE Chat_OnlineUser 
	    SET ChatOnlineUserLastChecking = @Now, ChatOnlineUserJoinTime = @Now, ChatOnlineUserLeaveTime = NULL, ChatOnlineUserToken = @LoginToken, ChatOnlineUserIsHidden = @Hidden
	    WHERE ChatOnlineUserSiteID = @SiteID AND ChatOnlineUserChatUserID = @ChatUserID

        -- Otherwise insert new record
	    IF @@ROWCOUNT = 0
	       INSERT INTO Chat_OnlineUser (ChatOnlineUserSiteID, ChatOnlineUserLastChecking, ChatOnlineUserChatUserID, ChatOnlineUserJoinTime, ChatOnlineUserLeaveTime, ChatOnlineUserToken, ChatOnlineUserIsHidden) 
	       VALUES (@SiteID, @Now, @ChatUserID, @Now, NULL, @LoginToken, @Hidden)
    END
    -- User is online now
    ELSE
    BEGIN
	    UPDATE Chat_OnlineUser 
	    SET ChatOnlineUserLastChecking = @Now, ChatOnlineUserJoinTime = @Now, ChatOnlineUserLeaveTime = NULL, 
	        ChatOnlineUserIsHidden = @Hidden & ChatOnlineUserIsHidden -- never overwrite hidden from 0 to 1 (set to 1 only if old value and new value are 1)
	    WHERE ChatOnlineUserSiteID = @SiteID AND ChatOnlineUserChatUserID = @ChatUserID
    END
	   
	SELECT @LoginToken;
END


GO
