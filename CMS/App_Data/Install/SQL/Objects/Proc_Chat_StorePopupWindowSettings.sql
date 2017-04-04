SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_Chat_StorePopupWindowSettings]
	@HashCode INT,
	@MessageTransformationName NVARCHAR(255),
	@ErrorTransformationName NVARCHAR(255),
	@ErrorClearTransformationName NVARCHAR(255),
	@UserTransformationName NVARCHAR(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT 1 FROM Chat_PopupWindowSettings WHERE ChatPopupWindowSettingsHashCode = @HashCode)    
	BEGIN
		INSERT INTO Chat_PopupWindowSettings(ChatPopupWindowSettingsHashCode, MessageTransformationName, ErrorTransformationName, ErrorClearTransformationName, UserTransformationName)
		VALUES (@HashCode, @MessageTransformationName, @ErrorTransformationName, @ErrorClearTransformationName, @UserTransformationName)	
	END
		
	SELECT * 
	FROM Chat_PopupWindowSettings
	WHERE ChatPopupWindowSettingsHashCode = @HashCode
END


GO
