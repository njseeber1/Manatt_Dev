SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Proc_CMS_Session_UpdateAll
	 @WhereCond nvarchar(max),
	 @SetColumns nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;

	EXEC ('UPDATE CMS_Session SET ' + @SetColumns + ' WHERE ' + @WhereCond);
END


GO
