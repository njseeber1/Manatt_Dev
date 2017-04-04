SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Newsletter_Subscriber_UpdateRelatedID]
	@oldObjectID int,
	@newObjectID int,
	@objectType nvarchar(200),
	@newFullName nvarchar(440)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @SubscriberIDs TABLE
	(
	  OldSubscriberID int,
	  NewSubscriberID int
	)	

	-- Change related ID to parent contact only when parent contact isn't subscribed on the same site as merged contact
	UPDATE Newsletter_Subscriber SET SubscriberRelatedID = @newObjectID, SubscriberLastModified = GETDATE(), SubscriberFullName = @newFullName
		WHERE SubscriberType = @objectType AND SubscriberRelatedID = @oldObjectID AND NOT EXISTS (
			SELECT SubscriberID FROM Newsletter_Subscriber AS NEW 
			WHERE NEW.SubscriberSiteID = SubscriberSiteID AND NEW.SubscriberRelatedID = @newObjectID AND NEW.SubscriberType = @objectType)

	-- Get subscribers who have both contacts on the same site as two subscribers
	INSERT INTO @SubscriberIDs SELECT OLD.SubscriberID AS OldSubscriberID, NEW.SubscriberID AS NewSubscriberID 
	FROM Newsletter_Subscriber AS OLD LEFT JOIN Newsletter_Subscriber AS NEW ON OLD.SubscriberSiteID = NEW.SubscriberSiteID
	WHERE OLD.SubscriberRelatedID = @oldObjectID AND OLD.SubscriberType = @objectType AND NEW.SubscriberType = @objectType AND NEW.SubscriberRelatedID = @newObjectID

	-- Modify subscriptions which are unique on the site and for the newsletter = transfer to parent contact
	UPDATE MAIN SET SubscriberID = IDS.NewSubscriberID 
	FROM Newsletter_SubscriberNewsletter AS MAIN JOIN @SubscriberIDs AS IDS ON IDS.OldSubscriberID = MAIN.SubscriberID
	WHERE NewsletterID NOT IN (SELECT NewsletterID FROM Newsletter_SubscriberNewsletter WHERE SubscriberID IN (SELECT NewSubscriberID FROM @SubscriberIDs))

	-- Merge subscriptions where one of the merged contacts doesn't have approved subscription 
	UPDATE NEWIDS SET SubscriptionApproved = 0, SubscriptionApprovedWhen = NULL
	FROM Newsletter_SubscriberNewsletter AS OLDIDS
	JOIN  @SubscriberIDs ON OLDIDS.SubscriberID = OldSubscriberID
	JOIN Newsletter_SubscriberNewsletter AS NEWIDS ON NEWIDS.SubscriberID = NewSubscriberID
	WHERE OLDIDS.SubscriptionApproved = 0 AND OLDIDS.NewsletterID = NEWIDS.NewsletterID 

	-- Delete subscriptions of merged contact
	DELETE ns FROM Newsletter_SubscriberNewsletter ns INNER JOIN @SubscriberIDs b ON ns.SubscriberID = b.[OldSubscriberID]

	-- Delete subscribers for merged contact
	DELETE FROM Newsletter_Subscriber WHERE SubscriberRelatedID = @oldObjectID AND SubscriberType = @objectType
END

GO
