SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Proc_CMS_User_RemoveSessionContact
@SessionContactID int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE CMS_Session SET SessionContactID = NULL WHERE SessionContactID = @SessionContactID;
END


GO
