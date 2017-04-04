SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_OM_Contact_RemoveRelations]
	@ContactID int = 0,
	@ContactMergedWithContactID int = 0
AS
BEGIN
	SET NOCOUNT ON;
	
		-- Remove activities
		UPDATE OM_Activity SET ActivityOriginalContactID = @ContactMergedWithContactID
			WHERE ActivityOriginalContactID = @ContactID;
		
		-- Remove IPs
		UPDATE OM_IP SET IPOriginalContactID = @ContactMergedWithContactID
			WHERE IPOriginalContactID = @ContactID;
	
		-- Remove User agents
		UPDATE OM_UserAgent SET UserAgentOriginalContactID = @ContactMergedWithContactID
			WHERE UserAgentOriginalContactID = @ContactID;
		
		-- Remove membership relations
		UPDATE  OM_Membership SET OriginalContactID = @ContactMergedWithContactID
			WHERE OriginalContactID = @ContactID;
END


GO
