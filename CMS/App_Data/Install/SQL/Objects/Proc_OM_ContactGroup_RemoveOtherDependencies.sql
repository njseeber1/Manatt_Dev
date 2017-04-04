SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_OM_ContactGroup_RemoveOtherDependencies]
@contactGroupID int
AS
BEGIN
SET NOCOUNT ON;
    
-- Contact group newsletter and its bindings
    -- Newsletter_SubscriberNewsletter
    DELETE FROM Newsletter_SubscriberNewsletter WHERE SubscriberID = (SELECT SubscriberID FROM Newsletter_Subscriber WHERE SubscriberRelatedID = @contactGroupID AND SubscriberType LIKE 'om.contactgroup');
    -- Newsletter_Emails
    DELETE FROM Newsletter_Emails WHERE EmailSubscriberID = (SELECT SubscriberID FROM Newsletter_Subscriber WHERE SubscriberRelatedID = @contactGroupID AND SubscriberType LIKE 'om.contactgroup');
    -- Newsletter_Subscriber
    DELETE FROM Newsletter_Subscriber WHERE SubscriberRelatedID = @contactGroupID AND SubscriberType LIKE 'om.contactgroup';
END


GO
