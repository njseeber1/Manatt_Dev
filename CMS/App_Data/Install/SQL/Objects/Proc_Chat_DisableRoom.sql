SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_DisableRoom]
	@ChatRoomID INT
AS
BEGIN
	DECLARE @Now DATETIME
	SET @Now = GETDATE()

	UPDATE Chat_Room
	SET ChatRoomEnabled = 0, ChatRoomLastModification = @Now
	WHERE ChatRoomID = @ChatRoomID
	
	IF @@ROWCOUNT = 1
		UPDATE Chat_RoomUser
		SET ChatRoomUserLastChecking = NULL, ChatRoomUserJoinTime = NULL, ChatRoomUserLeaveTime = @Now, ChatRoomUserLastModification = @Now
		WHERE ChatRoomUserRoomID = @ChatRoomID
END


GO
