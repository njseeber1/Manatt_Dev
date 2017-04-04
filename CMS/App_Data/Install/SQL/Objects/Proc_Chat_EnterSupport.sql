SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_Chat_EnterSupport] 
	@ChatUserID INT,
	@SiteID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Now DATETIME;
	DECLARE @LoginToken NVARCHAR(50);
	
	SET @Now = GETDATE();
	
	
	-- Check if user is already logged in support
	SELECT @LoginToken = ChatOnlineSupportToken
	FROM [Chat_OnlineSupport]
	WHERE ChatOnlineSupportChatUserID = @ChatUserID AND ChatOnlineSupportSiteID = @SiteID
	
	-- User is not online right now, log him in (otherwise do nothing)
    IF @LoginToken IS NULL
    BEGIN
	    -- generate new token
        SET @LoginToken = NEWID();
    
        INSERT INTO Chat_OnlineSupport (ChatOnlineSupportChatUserID, ChatOnlineSupportLastChecking, ChatOnlineSupportSiteID, ChatOnlineSupportToken) 
        VALUES (@ChatUserID, @Now, @SiteID, @LoginToken)
    END
    
    SELECT @LoginToken
END


GO
