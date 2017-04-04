SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_OM_ContactGroupMember_AddContactsToContactGroupDynamic]
	@ContactGroupID integer,
	@ContactIDs Type_CMS_IntegerTable readonly,
	@AllContactIDs Type_CMS_IntegerTable readonly
AS
BEGIN
	DECLARE @AlteredAllContactsContext int;
	set @AlteredAllContactsContext = (SELECT COUNT(*) FROM @AllContactIDs);

	WITH CGMembers as 
	(SELECT * FROM OM_ContactGroupMember WHERE ContactGroupMemberContactGroupID = @ContactGroupID AND ContactGroupMemberType = 0 AND (@AlteredAllContactsContext = 0 OR ContactGroupMemberRelatedID IN (SELECT Value From @AllContactIDs)))
	MERGE CGMembers AS target
	   USING @ContactIDs AS source 
	ON target.ContactGroupMemberRelatedID = source.Value 
	WHEN MATCHED AND COALESCE(target.ContactGroupMemberFromCondition, 0) = 0 
	-- There is already a row for the membership
		THEN UPDATE SET ContactGroupMemberFromCondition = 1  
	WHEN NOT MATCHED BY TARGET 
	-- There is not a row yet, but contact is sent in @ContactIDs
		THEN INSERT (ContactGroupMemberContactGroupID, ContactGroupMemberRelatedID, ContactGroupMemberFromCondition)
		VALUES (@ContactGroupID, source.Value, 1)
	WHEN NOT MATCHED BY SOURCE AND 
		COALESCE(target.ContactGroupMemberFromAccount, 0) = 0 AND 
		COALESCE(target.ContactGroupMemberFromManual, 0) = 0
	-- There is an existing row, but no corresponding contact is sent in @ContactIDs
		THEN DELETE
	 WHEN NOT MATCHED BY SOURCE AND 
		COALESCE(target.ContactGroupMemberFromCondition, 0) = 1
	 -- There is an existing row, but shouldn't be deleted, because it is membership 
	 -- either from account or manual assignment
		THEN UPDATE SET ContactGroupMemberFromCondition = 0;
END



GO
