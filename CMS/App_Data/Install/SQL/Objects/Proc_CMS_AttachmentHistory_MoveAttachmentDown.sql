SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_CMS_AttachmentHistory_MoveAttachmentDown]
	@AttachmentGUID uniqueidentifier,
	@VersionHistoryID int
AS
BEGIN
	/* Get Attachment ID */
	DECLARE @AttachmentHistoryID int;
	SET @AttachmentHistoryID = (SELECT TOP 1 AttachmentHistoryID FROM CMS_AttachmentHistory WHERE (AttachmentGUID = @AttachmentGUID) AND (AttachmentHistoryID IN (SELECT AttachmentHistoryID FROM CMS_VersionAttachment WHERE VersionHistoryID=@VersionHistoryID)));

	/* Get attachment's document ID */
	DECLARE @AttachmentDocumentID int;
	SET @AttachmentDocumentID = (SELECT TOP 1 AttachmentDocumentID FROM CMS_AttachmentHistory WHERE AttachmentHistoryID = @AttachmentHistoryID);
	
	/* Get ID of group */
	DECLARE @AttachmentGroupGUID uniqueidentifier;
	SET @AttachmentGroupGUID = (SELECT TOP 1 AttachmentGroupGUID FROM CMS_AttachmentHistory WHERE AttachmentHistoryID = @AttachmentHistoryID);
	
	DECLARE @MaxAttachmentOrder int
	IF @AttachmentGroupGUID IS NOT NULL
		SET @MaxAttachmentOrder = (SELECT TOP 1 AttachmentOrder FROM CMS_AttachmentHistory WHERE AttachmentDocumentID = @AttachmentDocumentID AND AttachmentGroupGUID = @AttachmentGroupGUID AND (AttachmentHistoryID IN (SELECT AttachmentHistoryID FROM CMS_VersionAttachment WHERE VersionHistoryID=@VersionHistoryID)) ORDER BY AttachmentOrder DESC);
	ELSE
		SET @MaxAttachmentOrder = (SELECT TOP 1 AttachmentOrder FROM CMS_AttachmentHistory WHERE AttachmentDocumentID = @AttachmentDocumentID AND AttachmentGroupGUID IS NULL AND (AttachmentHistoryID IN (SELECT AttachmentHistoryID FROM CMS_VersionAttachment WHERE VersionHistoryID=@VersionHistoryID)) ORDER BY AttachmentOrder DESC);		
	
	/* Move the next attachment(s) up */	
	IF @AttachmentGroupGUID IS NOT NULL
		UPDATE CMS_AttachmentHistory SET AttachmentOrder = AttachmentOrder - 1 WHERE AttachmentOrder = ((SELECT AttachmentOrder FROM CMS_AttachmentHistory WHERE AttachmentHistoryID = @AttachmentHistoryID) + 1 ) AND AttachmentDocumentID = @AttachmentDocumentID AND AttachmentGroupGUID = @AttachmentGroupGUID AND (AttachmentHistoryID IN (SELECT AttachmentHistoryID FROM CMS_VersionAttachment WHERE VersionHistoryID=@VersionHistoryID))
	ELSE
		UPDATE CMS_AttachmentHistory SET AttachmentOrder = AttachmentOrder - 1 WHERE AttachmentOrder = ((SELECT AttachmentOrder FROM CMS_AttachmentHistory WHERE AttachmentHistoryID = @AttachmentHistoryID) + 1 ) AND AttachmentDocumentID = @AttachmentDocumentID AND AttachmentGroupGUID IS NULL AND (AttachmentHistoryID IN (SELECT AttachmentHistoryID FROM CMS_VersionAttachment WHERE VersionHistoryID=@VersionHistoryID))
		
	/* Move the current attachment down */
	UPDATE CMS_AttachmentHistory SET AttachmentOrder = AttachmentOrder + 1 WHERE AttachmentHistoryID = @AttachmentHistoryID AND AttachmentOrder < @MaxAttachmentOrder
END


GO
