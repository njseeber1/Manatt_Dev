SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Newsletter_Emails_CreateMails]
@NewsletterIssueID int,
@NewsletterID int,
@SiteID int,
@MonitoringEnabled bit,
@BounceLimit int,
@UseSiteSpecificUnsubscriptions bit
AS
BEGIN
SET NOCOUNT ON;
		
IF (@MonitoringEnabled = 0)
BEGIN
	SET @BounceLimit = 0
END;

WITH Filtered_Newsletter_Subscriptions AS
(
	SELECT Newsletter_Subscriber.SubscriberID, SubscriberRelatedID, SubscriberEmail, SubscriberType
	FROM Newsletter_SubscriberNewsletter 
	INNER JOIN Newsletter_Subscriber ON Newsletter_SubscriberNewsletter.SubscriberID = Newsletter_Subscriber.SubscriberID
	WHERE
		NewsletterID = @NewsletterID AND 
		(SubscriptionApproved = 1 OR SubscriptionApproved IS NULL) AND 
		(
			(@BounceLimit <= 0 AND SubscriberBounces < 2147483647) OR
			SubscriberBounces IS NULL OR 
			SubscriberBounces < @BounceLimit
		)
)
INSERT INTO Newsletter_Emails (EmailNewsletterIssueID, EmailSubscriberID, EmailSiteID, EmailSending, EmailGUID, EmailUserID, EmailAddress)
  SELECT @NewsletterIssueID, TableWithRowNumber.SubscriberID, @SiteID, 1, NEWID(), TableWithRowNumber.UserID, TableWithRowNumber.Email
  FROM
  (
    SELECT SubscriptionsTable.*, ROW_NUMBER() OVER (PARTITION BY Email ORDER BY SubscriberID) AS RowNumber
    FROM
    (
		    SELECT SubscriberID, SubscriberEmail AS Email, NULL AS UserID
		    FROM Filtered_Newsletter_Subscriptions 
		    WHERE 
			    SubscriberType IS NULL
	    UNION
		    SELECT SubscriberID, Email AS Email, NULL AS UserID
		    FROM Filtered_Newsletter_Subscriptions
		    LEFT OUTER JOIN CMS_User ON SubscriberRelatedID = CMS_User.UserID
		    WHERE 
			    SubscriberType = 'cms.user' AND
          UserEnabled = 1
	    UNION
		    SELECT SubscriberID, Email AS Email, UserID
		    FROM Filtered_Newsletter_Subscriptions 
		    LEFT OUTER JOIN View_CMS_UserSettingsRole_Joined AS UserInfo ON SubscriberRelatedID = UserInfo.RoleID
		    WHERE 
			    SubscriberType = 'cms.role' AND
          UserEnabled = 1 AND
          (UserBounces IS NULL OR (@BounceLimit <= 0 AND UserBounces < 2147483647) OR UserBounces < @BounceLimit)
    ) AS SubscriptionsTable
    WHERE 
	    Email IS NOT NULL AND Email <> ''
  ) AS TableWithRowNumber
  WHERE
    TableWithRowNumber.RowNumber = 1 AND -- remove duplicate emails
    NOT EXISTS ( -- remove unsubscribed emails
		  SELECT * 
		  FROM Newsletter_Unsubscription 
		  WHERE
        UnsubscriptionEmail = TableWithRowNumber.Email AND
			  (UnsubscriptionNewsletterID IS NULL OR UnsubscriptionNewsletterID = @NewsletterID) AND 
			  (@UseSiteSpecificUnsubscriptions = 0 OR UnsubscriptionSiteID = @SiteID)) AND
    NOT EXISTS ( -- remove emails which are already present in the queue (could have been created from contact group subscribers for example)
      SELECT * 
      FROM Newsletter_Emails 
      WHERE 
        EmailAddress = TableWithRowNumber.Email AND 
        EmailNewsletterIssueID = @NewsletterIssueID)

-- Reset sending status so the sending may start	
UPDATE Newsletter_Emails SET EmailSending = NULL WHERE EmailNewsletterIssueID = @NewsletterIssueID
END

GO
