SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Proc_CMS_WebFarmServer_Delete] 
	@ID int
AS
BEGIN
	BEGIN TRANSACTION
		-- Remove all task - server binding
		DELETE FROM [CMS_WebFarmServerTask] WHERE ServerId = @ID;
		-- Remove server
		DELETE FROM [CMS_WebFarmServer] WHERE ServerId = @ID;
	COMMIT
END




GO
