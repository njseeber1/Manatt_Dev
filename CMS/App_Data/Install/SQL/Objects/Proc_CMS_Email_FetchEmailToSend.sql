SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Proc_CMS_Email_FetchEmailToSend] 
	@FetchFailed bit,
	@FetchNew bit,
	@FirstEmailID int,	
	@BatchSize bigint,
	@FailedEmailsNewerThan datetime2
AS
BEGIN

	SET NOCOUNT ON;

	IF @FetchFailed = 1 AND @FetchNew = 1
	BEGIN
		/* Get failed and waiting */
		;WITH q AS
		(
			SELECT TOP (@BatchSize) [EmailID],[EmailFrom],[EmailTo],[EmailCc],[EmailBcc],[EmailSubject],[EmailBody],[EmailPlainTextBody],
			[EmailFormat],[EmailPriority],[EmailSiteID],[EmailLastSendResult],[EmailLastSendAttempt],[EmailGUID],[EmailLastModified],
			[EmailStatus],[EmailIsMass],[EmailSetName],[EmailSetRelatedID],[EmailReplyTo],[EmailHeaders],[EmailCreated]
				FROM CMS_Email
				WHERE (EmailStatus = 1 AND EmailID > @FirstEmailID AND (EmailLastSendResult IS NULL OR @FailedEmailsNewerThan IS NULL OR EmailCreated > @FailedEmailsNewerThan))
				ORDER BY EmailPriority DESC, EmailID
		)
		UPDATE q SET EmailStatus = 2, EmailLastSendAttempt = GETDATE()
			OUTPUT INSERTED.[EmailID],INSERTED.[EmailFrom],INSERTED.[EmailTo],INSERTED.[EmailCc],INSERTED.[EmailBcc],
				INSERTED.[EmailSubject],INSERTED.[EmailBody],INSERTED.[EmailPlainTextBody],INSERTED.[EmailFormat],
				INSERTED.[EmailPriority],INSERTED.[EmailSiteID],INSERTED.[EmailLastSendResult],INSERTED.[EmailLastSendAttempt],
				INSERTED.[EmailGUID],INSERTED.[EmailLastModified],INSERTED.[EmailStatus],INSERTED.[EmailIsMass],INSERTED.[EmailSetName],
				INSERTED.[EmailSetRelatedID],INSERTED.[EmailReplyTo],INSERTED.[EmailHeaders],INSERTED.[EmailCreated];
	END
	ELSE IF @FetchNew = 1
	BEGIN
		/* Get only waiting */	
		;WITH q AS
		(
			SELECT TOP (@BatchSize) [EmailID],[EmailFrom],[EmailTo],[EmailCc],[EmailBcc],[EmailSubject],[EmailBody],[EmailPlainTextBody],
			[EmailFormat],[EmailPriority],[EmailSiteID],[EmailLastSendResult],[EmailLastSendAttempt],[EmailGUID],[EmailLastModified],
			[EmailStatus],[EmailIsMass],[EmailSetName],[EmailSetRelatedID],[EmailReplyTo],[EmailHeaders],[EmailCreated]
				FROM CMS_Email
				WHERE (EmailStatus = 1 AND EmailID > @FirstEmailID AND EmailLastSendResult IS NULL)
				ORDER BY EmailPriority DESC, EmailID
		)
		UPDATE q SET EmailStatus = 2, EmailLastSendAttempt = GETDATE()
			OUTPUT INSERTED.[EmailID],INSERTED.[EmailFrom],INSERTED.[EmailTo],INSERTED.[EmailCc],INSERTED.[EmailBcc],
				INSERTED.[EmailSubject],INSERTED.[EmailBody],INSERTED.[EmailPlainTextBody],INSERTED.[EmailFormat],
				INSERTED.[EmailPriority],INSERTED.[EmailSiteID],INSERTED.[EmailLastSendResult],INSERTED.[EmailLastSendAttempt],
				INSERTED.[EmailGUID],INSERTED.[EmailLastModified],INSERTED.[EmailStatus],INSERTED.[EmailIsMass],INSERTED.[EmailSetName],
				INSERTED.[EmailSetRelatedID],INSERTED.[EmailReplyTo],INSERTED.[EmailHeaders],INSERTED.[EmailCreated];
	END
	ELSE IF @FetchFailed = 1
	BEGIN
		/* Get only failed */
		;WITH q AS
		(
			SELECT TOP (@BatchSize) [EmailID],[EmailFrom],[EmailTo],[EmailCc],[EmailBcc],[EmailSubject],[EmailBody],[EmailPlainTextBody],
			[EmailFormat],[EmailPriority],[EmailSiteID],[EmailLastSendResult],[EmailLastSendAttempt],[EmailGUID],[EmailLastModified],
			[EmailStatus],[EmailIsMass],[EmailSetName],[EmailSetRelatedID],[EmailReplyTo],[EmailHeaders],[EmailCreated]
				FROM CMS_Email
				WHERE (EmailStatus = 1 AND EmailID > @FirstEmailID AND EmailLastSendResult IS NOT NULL AND (@FailedEmailsNewerThan IS NULL OR EmailCreated > @FailedEmailsNewerThan))
				ORDER BY EmailPriority DESC, EmailID
		)
		UPDATE q SET EmailStatus = 2, EmailLastSendAttempt = GETDATE()
			OUTPUT INSERTED.[EmailID],INSERTED.[EmailFrom],INSERTED.[EmailTo],INSERTED.[EmailCc],INSERTED.[EmailBcc],
				INSERTED.[EmailSubject],INSERTED.[EmailBody],INSERTED.[EmailPlainTextBody],INSERTED.[EmailFormat],
				INSERTED.[EmailPriority],INSERTED.[EmailSiteID],INSERTED.[EmailLastSendResult],INSERTED.[EmailLastSendAttempt],
				INSERTED.[EmailGUID],INSERTED.[EmailLastModified],INSERTED.[EmailStatus],INSERTED.[EmailIsMass],INSERTED.[EmailSetName],
				INSERTED.[EmailSetRelatedID],INSERTED.[EmailReplyTo],INSERTED.[EmailHeaders],INSERTED.[EmailCreated];
	END
END















GO
