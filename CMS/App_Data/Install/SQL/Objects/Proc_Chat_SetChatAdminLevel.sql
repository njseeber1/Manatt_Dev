SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_SetChatAdminLevel]
	-- Add the parameters for the stored procedure here
	@ChatUserID INT,
	@ChatRoomID INT,
	@AdminLevel INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Now DATETIME
	SET @Now = GETDATE()
		

	UPDATE Chat_RoomUser 
	SET ChatRoomUserAdminLevel = @AdminLevel,
		ChatRoomUserLastModification = @Now
	WHERE ChatRoomUserChatUserID = @ChatUserID AND ChatRoomUserRoomID = @ChatRoomID


	IF @@ROWCOUNT = 0
	   INSERT INTO Chat_RoomUser (ChatRoomUserRoomID, ChatRoomUserChatUserID, ChatRoomUserLastChecking, ChatRoomUserKickExpiration, ChatRoomUserJoinTime, ChatRoomUserLeaveTime, ChatRoomUserAdminLevel, ChatRoomUserLastModification) 
	       VALUES (@ChatRoomID, @ChatUserID, NULL, NULL, NULL, NULL, @AdminLevel, @Now)
	   
	   
	   
	-- Indicate that ChatUser has been changed
	-- UPDATE Chat_User SET ChatUserLastModification = GETDATE() WHERE ChatUserID = @ChatUserID
END


GO
