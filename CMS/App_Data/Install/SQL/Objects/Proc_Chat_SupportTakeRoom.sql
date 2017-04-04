SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_Chat_SupportTakeRoom] 
	@ChatUserID INT, 
	@RoomID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Now DATETIME;
	SET @Now = GETDATE();
	
   	-- Try to update (if room is already in Chat_SupportTakenRoom table)
    UPDATE Chat_SupportTakenRoom
    SET ChatSupportTakenRoomLastModification = @Now, ChatSupportTakenRoomChatUserID = @ChatUserID
    WHERE ChatSupportTakenRoomRoomID = @RoomID

    -- Otherwise insert new record
    IF @@ROWCOUNT = 0
       INSERT INTO Chat_SupportTakenRoom (ChatSupportTakenRoomChatUserID, ChatSupportTakenRoomRoomID, ChatSupportTakenRoomResolvedDateTime, ChatSupportTakenRoomLastModification) 
       VALUES (@ChatUserID, @RoomID, NULL, @Now)
END


GO
