SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_OM_Contact_SplitRelations]
	@mergeContactID int,
	@splitContactID int
AS
BEGIN
	SET NOCOUNT ON;

		-- Split Activities
    	UPDATE OM_Activity SET ActivityActiveContactID = @splitContactID WHERE ActivityOriginalContactID = @mergeContactID;
    	-- IPs
    	UPDATE OM_IP SET IPActiveContactID = @splitContactID WHERE IPOriginalContactID = @mergeContactID;
    	-- User agents
    	UPDATE OM_UserAgent SET UserAgentActiveContactID = @splitContactID WHERE UserAgentOriginalContactID = @mergeContactID;
    	-- Move memberships
    	UPDATE OM_Membership SET ActiveContactID = @splitContactID WHERE OriginalContactID = @mergeContactID;
	END


GO
