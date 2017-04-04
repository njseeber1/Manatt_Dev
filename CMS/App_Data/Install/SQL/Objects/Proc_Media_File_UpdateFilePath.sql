SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Media_File_UpdateFilePath]
	@OriginalPath nvarchar(450),
	@NewPath nvarchar(450),
	@LibraryID int,
    @OriginalPathLength int

AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRANSACTION

		UPDATE [Media_File] 
		SET [FilePath] = @NewPath + Substring(FilePath, @OriginalPathLength + 1, Len(FilePath) ) 
		FROM [Media_File] 
		WHERE ([FilePath] LIKE (@OriginalPath + '/%')) AND (FileLibraryID = @LibraryID);
		
	COMMIT TRANSACTION
END


GO
