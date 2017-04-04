SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_Newsletter_Issue_AddOpenedEmails]
@IssueID int
AS
BEGIN
SET NOCOUNT ON;
	
	BEGIN TRANSACTION
	
	DECLARE @Opened AS int
	SET @Opened = (SELECT COALESCE(IssueOpenedEmails, 0) FROM [Newsletter_NewsletterIssue] WHERE IssueID = @IssueID)
	SET @Opened = @Opened + 1
	UPDATE Newsletter_NewsletterIssue SET IssueOpenedEmails = @Opened WHERE IssueID = @IssueID

	COMMIT TRANSACTION
END


GO
