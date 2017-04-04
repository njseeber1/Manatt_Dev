SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_Messaging_ContactList
AS
SELECT     View_CMS_User.UserNickName, View_CMS_User.UserName, View_CMS_User.FullName, Messaging_ContactList.ContactListUserID, 
                      Messaging_ContactList.ContactListContactUserID, View_CMS_User.UserIsHidden, View_CMS_User.UserWaitingForApproval, 
                      View_CMS_User.UserAccountLockReason, View_CMS_User.UserEnabled
FROM         View_CMS_User INNER JOIN
                      Messaging_ContactList ON Messaging_ContactList.ContactListContactUserID = View_CMS_User.UserID

GO
