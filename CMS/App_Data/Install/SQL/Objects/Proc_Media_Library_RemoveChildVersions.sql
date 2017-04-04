SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_Media_Library_RemoveChildVersions]
@ID int
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
     
   -- Media file
   DELETE FROM [CMS_ObjectVersionHistory] WHERE [VersionObjectType] = N'media.file' AND [VersionObjectID] IN (
       SELECT [FileID] FROM [Media_File] WHERE FileLibraryID = @ID
   );
END


GO
