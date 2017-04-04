SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_CMS_VersionHistory_RemoveDependencies]
	@ID int
AS
BEGIN
	SET NOCOUNT ON;

	/* Update the documents */
	UPDATE CMS_Document SET 
		DocumentCheckedOutVersionHistoryID = NULL, 
		DocumentCheckedOutByUserID = NULL, 
		DocumentCheckedOutWhen = NULL,
		DocumentCanBePublished = CASE WHEN (DocumentIsArchived IS NULL OR DocumentIsArchived = 0) AND DocumentPublishedVersionHistoryID IS NULL THEN 1 ELSE 0 END
	WHERE DocumentCheckedOutVersionHistoryID = @ID; 
	
	UPDATE CMS_Document SET 
		DocumentPublishedVersionHistoryID = NULL,
		DocumentCanBePublished = CASE WHEN (DocumentIsArchived IS NULL OR DocumentIsArchived = 0) AND DocumentCheckedOutVersionHistoryID IS NULL THEN 1 ELSE 0 END
	WHERE DocumentPublishedVersionHistoryID = @ID; 
	
	/* Clear the workflow history */
	DELETE FROM CMS_WorkflowHistory WHERE VersionHistoryID = @ID; 
	
	/* Clear the attachment history - delete all the attachments that are connected to the version */
	DELETE FROM CMS_AttachmentHistory WHERE AttachmentHistoryID IN (SELECT AttachmentHistoryID FROM CMS_VersionAttachment WITH (NOLOCK) WHERE VersionHistoryID = @ID GROUP BY AttachmentHistoryID HAVING COUNT(VersionHistoryID) <= 1 )
END



GO
