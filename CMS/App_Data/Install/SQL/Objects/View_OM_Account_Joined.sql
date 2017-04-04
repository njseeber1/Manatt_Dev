SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_OM_Account_Joined
AS
SELECT     OM_Account.*, PrimaryContact.ContactFirstName AS PrimaryContactFirstName, 
                      PrimaryContact.ContactMiddleName AS PrimaryContactMiddleName, PrimaryContact.ContactLastName AS PrimaryContactLastName, 
                      SecondaryContact.ContactFirstName AS SecondaryContactFirstName, SecondaryContact.ContactMiddleName AS SecondaryContactMiddleName, 
                      SecondaryContact.ContactLastName AS SecondaryContactLastName, SubsidiaryOf.AccountName AS SubsidiaryOfName, ISNULL(PrimaryContact.ContactFirstName, '') +
                      CASE WHEN (NULLIF(PrimaryContact.ContactFirstName,'') IS NULL) THEN '' ELSE ' ' END + ISNULL(PrimaryContact.ContactMiddleName, '') +
                      CASE WHEN (NULLIF(PrimaryContact.ContactMiddleName,'') IS NULL) THEN '' ELSE ' ' END + ISNULL(PrimaryContact.ContactLastName, '') AS PrimaryContactFullName,
                      ISNULL(SecondaryContact.ContactFirstName, '') + CASE WHEN (NULLIF(SecondaryContact.ContactFirstName,'') IS NULL) THEN '' ELSE ' ' END +
                      ISNULL(SecondaryContact.ContactMiddleName, '') + CASE WHEN (NULLIF(SecondaryContact.ContactMiddleName,'') IS NULL) THEN '' ELSE ' ' END + 
                      ISNULL(SecondaryContact.ContactLastName, '') AS SecondaryContactFullName, ISNULL(OM_Account.AccountAddress1, '') +
                      CASE WHEN (NULLIF(OM_Account.AccountAddress1,'') IS NULL) THEN '' ELSE ' ' END + ISNULL(OM_Account.AccountAddress2, '') AS AccountFullAddress
FROM         OM_Account LEFT OUTER JOIN
                      OM_Contact AS PrimaryContact ON OM_Account.AccountPrimaryContactID = PrimaryContact.ContactID LEFT OUTER JOIN
                      OM_Contact AS SecondaryContact ON OM_Account.AccountSecondaryContactID = SecondaryContact.ContactID LEFT OUTER JOIN
                      OM_Account AS SubsidiaryOf ON OM_Account.AccountSubsidiaryOfID = SubsidiaryOf.AccountID

GO
