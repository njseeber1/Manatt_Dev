SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_Newsletter_Emails_FetchEmailsToSend]
@FetchFailed bit,
@FetchNew bit,
@FirstEmailID int,
@FirstEmailGuid uniqueidentifier,
@IssueID int,
@DeleteSent bit,
@TopN int,
@IsVariant bit
AS
BEGIN
SET NOCOUNT ON;
DECLARE @Emails TABLE (
	EmailID int
);

BEGIN TRANSACTION

-- Delete emails successfully sent in previous fetch
IF @DeleteSent = 1 AND @IssueID > 0
BEGIN
	IF @IsVariant = 0 AND @FirstEmailID > 0
	BEGIN
		DELETE FROM Newsletter_Emails WHERE (EmailNewsletterIssueID = @IssueID) AND (EmailSending = 1) AND (EmailID <= @FirstEmailID) AND (EmailLastSendResult IS NULL OR EmailLastSendResult LIKE '');
	END
	
	IF @IsVariant = 1 AND @FirstEmailGuid > '00000000-0000-0000-0000-000000000000'
	BEGIN
		DELETE FROM Newsletter_Emails WHERE (EmailNewsletterIssueID = @IssueID) AND (EmailSending = 1) AND (EmailGUID <= @FirstEmailGuid) AND (EmailLastSendResult IS NULL OR EmailLastSendResult LIKE '');
	END
END

IF @IsVariant = 0
BEGIN
	IF @FetchFailed = 1 AND @FetchNew = 1
		BEGIN
			-- Fetch new and failed emails
			INSERT INTO @Emails SELECT TOP(@TopN) EmailID FROM Newsletter_Emails WHERE (EmailID > @FirstEmailID) AND (EmailSending IS NULL OR EmailSending = 0) AND (EmailNewsletterIssueID = @IssueID) ORDER BY EmailID;
		END
	ELSE IF @FetchNew = 1
		BEGIN
			-- Fetch only new emails
			INSERT INTO @Emails SELECT TOP(@TopN) EmailID FROM Newsletter_Emails WHERE (EmailID > @FirstEmailID) AND (EmailSending IS NULL OR EmailSending = 0) AND (EmailNewsletterIssueID = @IssueID) AND (EmailLastSendResult IS NULL OR EmailLastSendResult LIKE '') ORDER BY EmailID;
		END
	ELSE IF @FetchFailed = 1
		BEGIN
			-- Fetch only failed emails
			INSERT INTO @Emails SELECT TOP(@TopN) EmailID FROM Newsletter_Emails WHERE (EmailID > @FirstEmailID) AND (EmailSending IS NULL OR EmailSending = 0) AND (EmailNewsletterIssueID = @IssueID) AND NOT (EmailLastSendResult IS NULL OR EmailLastSendResult LIKE '') ORDER BY EmailID;
		END
END
ELSE
BEGIN
	IF @FetchFailed = 1 AND @FetchNew = 1
		BEGIN
			-- Fetch new and failed emails
			INSERT INTO @Emails SELECT TOP(@TopN) EmailID FROM Newsletter_Emails WHERE (EmailGUID > @FirstEmailGuid) AND (EmailSending IS NULL OR EmailSending = 0) AND (EmailNewsletterIssueID = @IssueID) ORDER BY EmailGUID;
		END
	ELSE IF @FetchNew = 1
		BEGIN
			-- Fetch only new emails
			INSERT INTO @Emails SELECT TOP(@TopN) EmailID FROM Newsletter_Emails WHERE (EmailGUID > @FirstEmailGuid) AND (EmailSending IS NULL OR EmailSending = 0) AND (EmailNewsletterIssueID = @IssueID) AND (EmailLastSendResult IS NULL OR EmailLastSendResult LIKE '') ORDER BY EmailGUID;
		END
	ELSE IF @FetchFailed = 1
		BEGIN
			-- Fetch only failed emails
			INSERT INTO @Emails SELECT TOP(@TopN) EmailID FROM Newsletter_Emails WHERE (EmailGUID > @FirstEmailGuid) AND (EmailSending IS NULL OR EmailSending = 0) AND (EmailNewsletterIssueID = @IssueID) AND NOT (EmailLastSendResult IS NULL OR EmailLastSendResult LIKE '') ORDER BY EmailGUID;
		END
END

-- Set status of fetched emails to 'sending'
UPDATE Newsletter_Emails SET EmailSending = 1, EmailLastSendResult = NULL WHERE EmailID IN (SELECT EmailID FROM @Emails);

IF @IsVariant = 0
BEGIN
	SELECT * FROM Newsletter_Emails WHERE EmailID IN (SELECT EmailID FROM @Emails) ORDER BY EmailID;
END
ELSE
BEGIN
	SELECT * FROM Newsletter_Emails WHERE EmailID IN (SELECT EmailID FROM @Emails) ORDER BY EmailGUID;
END

COMMIT TRANSACTION
END


GO
