SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_SafeDeleteRoom]
	@ChatRoomID INT,
	@AfterHours INT
AS
BEGIN
	EXEC Proc_Chat_DisableRoom
		@ChatRoomID = @ChatRoomID
		
	UPDATE Chat_Room
	SET ChatRoomScheduledToDelete = DATEADD(hh, @AfterHours, GETDATE())
	WHERE ChatRoomID = @ChatRoomID
END


GO
