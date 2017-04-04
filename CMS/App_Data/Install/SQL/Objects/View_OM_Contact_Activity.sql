SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_OM_Contact_Activity
AS
SELECT     dbo.OM_Contact.ContactID, dbo.OM_Contact.ContactFirstName, dbo.OM_Contact.ContactMiddleName, dbo.OM_Contact.ContactLastName, 
                      dbo.OM_Contact.ContactSalutation, dbo.OM_Contact.ContactTitleBefore, dbo.OM_Contact.ContactTitleAfter, dbo.OM_Contact.ContactJobTitle, 
                      dbo.OM_Contact.ContactAddress1, dbo.OM_Contact.ContactAddress2, dbo.OM_Contact.ContactCity, dbo.OM_Contact.ContactZIP, dbo.OM_Contact.ContactStateID, 
                      dbo.OM_Contact.ContactCountryID, dbo.OM_Contact.ContactMobilePhone, dbo.OM_Contact.ContactHomePhone, dbo.OM_Contact.ContactBusinessPhone, 
                      dbo.OM_Contact.ContactEmail, dbo.OM_Contact.ContactWebSite, dbo.OM_Contact.ContactBirthday, dbo.OM_Contact.ContactGender, dbo.OM_Contact.ContactStatusID, 
                      dbo.OM_Contact.ContactNotes, dbo.OM_Contact.ContactOwnerUserID, dbo.OM_Contact.ContactMonitored, dbo.OM_Contact.ContactMergedWithContactID, 
                      dbo.OM_Contact.ContactIsAnonymous, dbo.OM_Contact.ContactSiteID, dbo.OM_Contact.ContactGUID, dbo.OM_Contact.ContactLastModified, 
                      dbo.OM_Contact.ContactCreated, dbo.OM_Contact.ContactMergedWhen, dbo.OM_Contact.ContactGlobalContactID, dbo.OM_Contact.ContactBounces, 
                      dbo.OM_Contact.ContactLastLogon, dbo.OM_Contact.ContactCampaign, dbo.OM_Contact.ContactSalesForceLeadID, 
                      dbo.OM_Contact.ContactSalesForceLeadReplicationDisabled, dbo.OM_Contact.ContactSalesForceLeadReplicationDateTime, 
                      dbo.OM_Contact.ContactSalesForceLeadReplicationSuspensionDateTime, dbo.OM_Contact.ContactCompanyName, dbo.OM_Activity.ActivityID, 
                      dbo.OM_Activity.ActivityActiveContactID, dbo.OM_Activity.ActivityOriginalContactID, dbo.OM_Activity.ActivityCreated, dbo.OM_Activity.ActivityType, 
                      dbo.OM_Activity.ActivityItemID, dbo.OM_Activity.ActivityItemDetailID, dbo.OM_Activity.ActivityValue, dbo.OM_Activity.ActivityURL, dbo.OM_Activity.ActivityTitle, 
                      dbo.OM_Activity.ActivitySiteID, dbo.OM_Activity.ActivityGUID, dbo.OM_Activity.ActivityIPAddress, dbo.OM_Activity.ActivityComment, dbo.OM_Activity.ActivityCampaign,
                       dbo.OM_Activity.ActivityURLReferrer, dbo.OM_Activity.ActivityCulture, dbo.OM_Activity.ActivityNodeID
FROM         dbo.OM_Contact INNER JOIN
                      dbo.OM_Activity ON dbo.OM_Contact.ContactID = dbo.OM_Activity.ActivityActiveContactID


GO
