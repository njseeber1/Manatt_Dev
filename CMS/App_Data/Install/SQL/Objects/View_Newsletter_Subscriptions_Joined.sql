SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.View_Newsletter_Subscriptions_Joined
AS
SELECT        dbo.Newsletter_Subscriber.SubscriberID, dbo.Newsletter_Subscriber.SubscriberFullName, dbo.Newsletter_Subscriber.SubscriberEmail, dbo.CMS_User.Email, 
                         dbo.Newsletter_SubscriberNewsletter.SubscriptionApproved, dbo.Newsletter_SubscriberNewsletter.NewsletterID, dbo.Newsletter_Subscriber.SubscriberType, 
                         dbo.Newsletter_Subscriber.SubscriberBounces, dbo.Newsletter_Newsletter.NewsletterDisplayName, dbo.Newsletter_Subscriber.SubscriberRelatedID, 
                         dbo.Newsletter_SubscriberNewsletter.SubscriberNewsletterID
FROM            dbo.Newsletter_Subscriber INNER JOIN
                         dbo.Newsletter_SubscriberNewsletter ON dbo.Newsletter_Subscriber.SubscriberID = dbo.Newsletter_SubscriberNewsletter.SubscriberID INNER JOIN
                         dbo.Newsletter_Newsletter ON dbo.Newsletter_Newsletter.NewsletterID = dbo.Newsletter_SubscriberNewsletter.NewsletterID LEFT OUTER JOIN
                         dbo.CMS_User ON dbo.Newsletter_Subscriber.SubscriberRelatedID = dbo.CMS_User.UserID AND dbo.Newsletter_Subscriber.SubscriberType = 'cms.user'


GO
