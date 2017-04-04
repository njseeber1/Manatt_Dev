SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_ChangeChatRoom]
	@RoomID INT, 
	@DisplayName NVARCHAR(100), 
	@IsPrivate BIT, 
	@Password NVARCHAR(100),
	@AllowAnonym BIT, 
	@Description NVARCHAR(max),
	@IsSupport BIT,
	@CodeName NVARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
	-- This procedure has to be used, because LastModification time has to be set to SQL Server's time (GETDATE()) not Application's server time (DateTime.Now)	
		
	DECLARE @Now DATETIME
	SET @Now = GETDATE()
	
	DECLARE @OldPrivateState BIT

	SELECT @OldPrivateState = [ChatRoomPrivate] FROM Chat_Room WHERE ChatRoomID = @RoomID
	
	-- Return if room was not found
	IF @OldPrivateState IS NULL
	BEGIN
		RETURN
	END

	DECLARE @PrivateStateHasChanged BIT
	
	IF @OldPrivateState <> @IsPrivate
		SET @PrivateStateHasChanged = 1
	ELSE	
		SET @PrivateStateHasChanged = 0
	
	UPDATE [Chat_Room]
	SET [ChatRoomDisplayName] = @DisplayName,
		[ChatRoomPrivate] = @IsPrivate,
		[ChatRoomAllowAnonym] = @AllowAnonym,
		[ChatRoomPassword] = CASE WHEN @Password IS NULL THEN [ChatRoomPassword] ELSE @Password END,
		[ChatRoomDescription] = @Description,
		[ChatRoomIsSupport] = COALESCE(@IsSupport, [ChatRoomIsSupport]), -- change [ChatRoomIsSupport] only if @IsSuppport is not null
		[ChatRoomName] = COALESCE(@CodeName, [ChatRoomName]), -- change [ChatRoomName] (code name) only if @CodeName is not null
		[ChatRoomLastModification] = @Now,
		[ChatRoomPrivateStateLastModification] = CASE WHEN @PrivateStateHasChanged = 1 THEN @Now ELSE [ChatRoomPrivateStateLastModification] END -- Change [ChatRoomPrivateStateLastModification] to @Now only if private state has changed
	WHERE ChatRoomID = @RoomID
END


GO
