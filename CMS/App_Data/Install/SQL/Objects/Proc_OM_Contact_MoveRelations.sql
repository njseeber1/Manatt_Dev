SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_OM_Contact_MoveRelations]
	@mergeIntoContactID int,
	@mergeFromContactID int
AS
BEGIN
	SET NOCOUNT ON;
		-- Move Activities into parent contact
    	UPDATE OM_Activity SET ActivityActiveContactID = @mergeIntoContactID WHERE ActivityActiveContactID = @mergeFromContactID 
    	-- Move memberships 
    	UPDATE OM_Membership SET ActiveContactID = @mergeIntoContactID WHERE ActiveContactID = @mergeFromContactID 
    	-- IPs
    	UPDATE OM_IP SET IPActiveContactID = @mergeIntoContactID WHERE IPActiveContactID = @mergeFromContactID 
    	-- User agents
    	UPDATE OM_UserAgent SET UserAgentActiveContactID = @mergeIntoContactID WHERE UserAgentActiveContactID = @mergeFromContactID
END


GO
