SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_KickPermanentlyFromRoom]
	@ChatRoomID INT,
	@ChatUserID INT
AS
BEGIN
	DECLARE @Now DATETIME
	SET @Now = GETDATE()

    UPDATE Chat_RoomUser 
	SET ChatRoomUserAdminLevel = 0,
		ChatRoomUserLastModification = @Now,
		ChatRoomUserLastChecking = NULL, 
		ChatRoomUserJoinTime = NULL, 
		ChatRoomUserLeaveTime = @Now
	WHERE ChatRoomUserChatUserID = @ChatUserID AND ChatRoomUserRoomID = @ChatRoomID
END


GO
