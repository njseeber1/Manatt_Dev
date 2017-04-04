SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW View_OM_Account_MembershipJoined
AS
SELECT OM_Account.*, OM_Membership.*,
  ISNULL(OM_Account.AccountAddress1,'') + CASE WHEN (NULLIF(OM_Account.AccountAddress1,'') IS NULL) THEN '' ELSE ', ' END +
  ISNULL(OM_Account.AccountAddress2,'') AS AccountFullAddress,
  ISNULL(OM_Contact.ContactFirstName, '') + CASE WHEN (NULLIF(OM_Contact.ContactFirstName,'') IS NULL) THEN '' ELSE ' ' END +
 ISNULL(OM_Contact.ContactMiddleName, '') + CASE WHEN (NULLIF(OM_Contact.ContactMiddleName,'') IS NULL) THEN '' ELSE ' ' END +
 ISNULL(OM_Contact.ContactLastName, '') AS PrimaryContactFullName
FROM OM_Account INNER JOIN OM_AccountContact ON OM_Account.AccountID=OM_AccountContact.AccountID
INNER JOIN OM_Membership ON OM_Membership.ActiveContactID=OM_AccountContact.ContactID LEFT JOIN OM_Contact
ON OM_Account.AccountPrimaryContactID=OM_Contact.ContactID

GO
