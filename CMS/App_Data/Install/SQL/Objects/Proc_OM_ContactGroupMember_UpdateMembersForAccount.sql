SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_OM_ContactGroupMember_UpdateMembersForAccount]

	@accountID int,
	@groupID int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Variables
	DECLARE @tempTable TABLE (
		ContactID int NOT NULL
	);	
	DECLARE @contactGroups TABLE (
		ContactGroupID int NOT NULL
	);	
	DECLARE @contactID int;
	DECLARE @currentGroupID int;
	
	-- Loop through all contact groups of current account
	IF (@groupID = 0) OR (@groupID IS NULL)
	BEGIN
		-- Get all contact groups where account is present
		INSERT INTO @contactGroups SELECT ContactGroupMemberContactGroupID FROM OM_ContactGroupMember WHERE ContactGroupMemberType = 1 
		AND ContactGroupMemberRelatedID = @accountID 
		SELECT TOP 1 @currentGroupID = ContactGroupID FROM @contactGroups
	END
	-- Or use single contact group
	ELSE
		SET @currentGroupID = @groupID;

	WHILE ((@currentGroupID > 0) AND (@currentGroupID IS NOT NULL))
	BEGIN	
		-- Update all contacts which already exist under the group and mark them as added from account
		UPDATE OM_ContactGroupMember SET ContactGroupMemberFromAccount = 1 WHERE ContactGroupMemberType = 0 AND ContactGroupMemberContactGroupID = @currentGroupID
			AND ContactGroupMemberRelatedID IN (SELECT ContactID FROM OM_AccountContact WHERE AccountID = @accountID)
		
		-- Get all contacts from current account which don't already exist as member of the group and are not merged
		INSERT INTO @tempTable 
			SELECT AC.ContactID
			FROM OM_AccountContact AC
			LEFT JOIN OM_Contact C ON C.ContactID = AC.ContactID
			LEFT JOIN OM_ContactGroupMember ON ContactGroupMemberRelatedID = C.ContactID AND ContactGroupMemberContactGroupID = @currentGroupID AND ContactGroupMemberType = 0
			WHERE AccountID = @accountID 
				AND 
				-- Filter out contacts already in group
				ContactGroupMemberRelatedID IS NULL
				AND
				-- Filter out merged contacts (site contact to site contact or global to global)
				((ContactSiteID > 0 AND (ContactMergedWithContactID = 0 OR ContactMergedWithContactID IS NULL))
						OR
				((ContactSiteID = 0 OR ContactSiteID IS NULL) AND (ContactGlobalContactID = 0 OR ContactGlobalContactID IS NULL)))
				
			
		-- Loop through all contacts of added account and insert them into the group
		WHILE ((SELECT Count(*) FROM @tempTable) > 0)
		BEGIN
			SELECT TOP 1 @contactID = ContactID From @tempTable;
		
			-- Insert new contact as a contact group member
			INSERT INTO OM_ContactGroupMember 
			(ContactGroupMemberContactGroupID, ContactGroupMemberRelatedID, ContactGroupMemberType, ContactGroupMemberFromAccount) VALUES
			(@currentGroupID, @contactID, 0, 1)
			
			-- Remove record from temporary table
			DELETE @tempTable WHERE ContactID = @contactID
		END
			
		-- Go to next contact group
		DELETE FROM @contactGroups WHERE ContactGroupID = @currentGroupID;
		SET @currentGroupID = 0;
		SELECT TOP 1 @currentGroupID = ContactGroupID FROM @contactGroups;
	END
END


GO
