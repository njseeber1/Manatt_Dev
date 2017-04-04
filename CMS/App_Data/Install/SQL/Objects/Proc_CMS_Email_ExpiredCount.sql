SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_CMS_Email_ExpiredCount]
@Now datetime
AS
BEGIN
SET NOCOUNT ON;

-- Get default value for number of days to keep archived emails
DECLARE @DefaultDays AS int
SET @DefaultDays = (SELECT KeyValue FROM CMS_SettingsKey WHERE KeyName = 'CMSArchiveEmails' AND SiteID IS NULL)

-- Create a table variable that contains SiteID's and Expiration Dates for archived emails
-- Expiration dates are calculated as today - number of days to archive emails
DECLARE @ExpTable AS TABLE ( SiteID int NOT NULL, ExpirationDate datetime NOT NULL )
-- Insert expiration date for global emails
INSERT INTO @ExpTable VALUES (0, DATEADD(day, -CONVERT(int, @DefaultDays), @Now)) 
-- Insert expiration dates for sites
INSERT INTO @ExpTable 
	SELECT Sites.SiteID, DATEADD(day, -CONVERT(int, ISNULL(KeyValue, @DefaultDays)), @Now) AS ExpirationDate
	FROM (SELECT SiteID FROM CMS_Site) AS Sites LEFT JOIN (SELECT SiteID, KeyValue FROM CMS_SettingsKey WHERE KeyName = 'CMSArchiveEmails') AS Settings
	ON Sites.SiteID = Settings.SiteID
	WHERE ISNULL(KeyValue, @DefaultDays) > 0

DECLARE @Archived AS int
SET @Archived = 3

-- Get number of expired emails in archive for each site along with the expiration date
SELECT ISNULL(CMS_Email.EmailSiteID, 0) AS SiteID, ExpTable.ExpirationDate AS ExpirationDate, COUNT(*) AS ExpiredEmailsCount
FROM CMS_Email LEFT OUTER JOIN  @ExpTable AS ExpTable ON ISNULL(CMS_Email.EmailSiteID, 0) = ExpTable.SiteID
WHERE EmailStatus = @Archived AND EmailLastSendAttempt <= ExpirationDate
GROUP BY EmailSiteID, ExpTable.ExpirationDate
END


GO
