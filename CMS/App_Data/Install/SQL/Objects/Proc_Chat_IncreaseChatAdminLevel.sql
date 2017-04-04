SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_IncreaseChatAdminLevel]
	-- Add the parameters for the stored procedure here
	@ChatUserID INT,
	@ChatRoomID INT,
	@AdminLevel INT
AS
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @Now DATETIME
	SET @Now = GETDATE()
		
	UPDATE Chat_RoomUser 
	SET ChatRoomUserAdminLevel = 
		CASE WHEN (ChatRoomUserAdminLevel > @AdminLevel)
			THEN ChatRoomUserAdminLevel
			ELSE @AdminLevel
		END, 
		ChatRoomUserLastModification = @Now
	WHERE ChatRoomUserChatUserID = @ChatUserID AND ChatRoomUserRoomID = @ChatRoomID

	IF @@ROWCOUNT = 0
	   INSERT INTO Chat_RoomUser (ChatRoomUserRoomID, ChatRoomUserChatUserID, ChatRoomUserLastChecking, ChatRoomUserKickExpiration, ChatRoomUserJoinTime, ChatRoomUserLeaveTime, ChatRoomUserAdminLevel, ChatRoomUserLastModification) 
	   VALUES (@ChatRoomID, @ChatUserID, NULL, NULL, NULL, NULL, @AdminLevel, @Now)
END


GO
