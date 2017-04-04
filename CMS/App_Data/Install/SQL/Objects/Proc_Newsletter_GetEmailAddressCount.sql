SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_Newsletter_GetEmailAddressCount]
@NewsletterID int,
@SiteID int,
@BounceLimit int,
@UseSiteSpecificUnsubscriptions bit
AS
BEGIN

WITH [Filtered_Newsletter_Subscriptions] AS
(
	SELECT [SubscriberRelatedID], [SubscriberEmail], [SubscriberType]
	FROM [Newsletter_SubscriberNewsletter] 
	INNER JOIN [Newsletter_Subscriber] ON [Newsletter_SubscriberNewsletter].[SubscriberID] = [Newsletter_Subscriber].[SubscriberID]
	WHERE
		[NewsletterID] = @NewsletterID AND 
		ISNULL([Newsletter_SubscriberNewsletter].[SubscriptionApproved], 1) = 1 AND 
		(
			@BounceLimit <= 0 OR 
			[Newsletter_Subscriber].[SubscriberBounces] IS NULL OR 
			[Newsletter_Subscriber].[SubscriberBounces] < @BounceLimit
		)
)
SELECT COUNT(*) 
FROM
(
		SELECT [SubscriberEmail] AS Email
		FROM [Filtered_Newsletter_Subscriptions] 
		WHERE 
			[SubscriberType] IS NULL OR
			[SubscriberType] = 'om.contact'
	UNION
		SELECT [CMS_User].[Email] AS Email
		FROM [Filtered_Newsletter_Subscriptions]
		LEFT OUTER JOIN [CMS_User] ON [SubscriberRelatedID] = [CMS_User].[UserID]
		WHERE 
			[SubscriberType] = 'cms.user' AND
			[CMS_User].[UserEnabled] = 1
	UNION
		SELECT [UserInfo].[Email] AS Email
		FROM [Filtered_Newsletter_Subscriptions] 
		LEFT OUTER JOIN [View_CMS_UserSettingsRole_Joined] AS [UserInfo] ON [SubscriberRelatedID] = [UserInfo].[RoleID]
		WHERE 
			[SubscriberType] = 'cms.role' AND
			[UserInfo].[UserEnabled] = 1 AND
			(
				[UserBounces] IS NULL OR 
				(
					@BounceLimit <= 0 AND 
					[UserBounces] < 2147483647
				) OR 
				[UserBounces] < @BounceLimit
			)
) AS T
WHERE 
	ISNULL([Email], '') <> '' AND 
	T.Email NOT IN (
		SELECT UnsubscriptionEmail 
		FROM Newsletter_Unsubscription 
		WHERE 	
			(UnsubscriptionNewsletterID IS NULL OR UnsubscriptionNewsletterID = @NewsletterID) AND 
			(@UseSiteSpecificUnsubscriptions = 0 OR UnsubscriptionSiteID = @SiteID))
END


GO
