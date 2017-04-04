SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_OM_ContactGroupMember_AddContactToContactGroupsDynamic]
	@ContactID integer,
	@ContactGroupIDs Type_CMS_IntegerTable readonly,
	@AllContactGroupIDs Type_CMS_IntegerTable readonly
AS
BEGIN
	WITH CGMembers as 
	(SELECT * FROM OM_ContactGroupMember WHERE ContactGroupMemberRelatedID = @ContactID AND ContactGroupMemberType = 0 AND ContactGroupMemberContactGroupID IN (SELECT Value FROM @AllContactGroupIDs))
	 MERGE CGMembers AS target
	   USING @ContactGroupIDs AS source 
	 ON target.ContactGroupMemberContactGroupID = source.Value
	 WHEN MATCHED AND COALESCE(target.ContactGroupMemberFromCondition, 0) = 0 THEN
		UPDATE SET ContactGroupMemberFromCondition = 1  
	 WHEN NOT MATCHED BY TARGET THEN
		INSERT (ContactGroupMemberContactGroupID, ContactGroupMemberRelatedID, ContactGroupMemberFromCondition)
		VALUES (source.Value, @ContactID, 1)
	 WHEN NOT MATCHED BY SOURCE AND 
		COALESCE(target.ContactGroupMemberFromAccount, 0) = 0 AND 
		COALESCE(target.ContactGroupMemberFromManual, 0) = 0
		THEN DELETE
	 WHEN NOT MATCHED BY SOURCE AND
		COALESCE(target.ContactGroupMemberFromCondition, 0) = 1
		THEN UPDATE SET ContactGroupMemberFromCondition = 0;
END



GO
