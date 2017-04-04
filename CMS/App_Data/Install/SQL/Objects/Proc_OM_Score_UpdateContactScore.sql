SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_OM_Score_UpdateContactScore]
  @RuleID int,
  @WhereCond nvarchar(max),
  @ContactIDs nvarchar(max), -- Has to be in format suitable for Func_Selection_ParseIDs. For example "1,2,3". If null, all contacts from site will be recalculated.
  @RuleExpiration datetime,
  @RuleValidUnits int,
  @RuleValidFor int,
  @IncludePageVisitData bit
AS
BEGIN
  DECLARE @ruleType int;
  DECLARE @ruleScoreID int;
  DECLARE @ruleValue int;
  DECLARE @ruleParameter nvarchar(250);
  DECLARE @ruleIsRecurring bit;
  DECLARE @ruleSiteID int;
  DECLARE @ruleMaxPoints int;
  DECLARE @currentContactID int;
  DECLARE @previousContactID int;
  DECLARE @currentPoints int;
  DECLARE @currentExpiration datetime;
  DECLARE @expirationDate nvarchar(300);
  DECLARE @timeRestriction nvarchar(300);

  -- Get rule info
  SELECT
    @ruleSiteID = [RuleSiteID], 
    @ruleType = [RuleType], 
    @ruleScoreID = [RuleScoreID], 
    @ruleValue = [RuleValue], 
    @ruleParameter = [RuleParameter], 
    @ruleIsRecurring = (CASE WHEN [RuleIsRecurring] = 0 OR [RuleIsRecurring] IS NULL THEN 0 ELSE 1 END),
    @ruleMaxPoints = [RuleMaxPoints] 
  FROM OM_Rule 
  WHERE RuleID=@RuleID

  IF @ContactIDs IS NULL
  BEGIN
    -- Retrieve all contacts for specified condition
    SET @WhereCond = 'ContactMergedWithContactID IS NULL AND ContactSiteID = ' + CAST(@ruleSiteID as varchar(15)) + ' AND (' + @WhereCond + ') ' +
                     'AND ContactID NOT IN (SELECT ContactID FROM OM_ScoreContactRule WITH (UPDLOCK, HOLDLOCK) WHERE ScoreID = ' + CAST(@ruleScoreID as varchar(15)) + ' AND RuleID = ' + CAST(@RuleID as varchar(15)) + ')';
  END
  ELSE
  BEGIN
    -- Try to retrieve given contact for specified condition
    SET @WhereCond = 'ContactMergedWithContactID IS NULL AND ContactID IN (SELECT ItemID FROM Func_Selection_ParseIDs(''' + @ContactIDs + ''')) AND (' + @WhereCond + ') ' + 
                     'AND ContactID NOT IN (SELECT ContactID FROM OM_ScoreContactRule WITH (UPDLOCK, HOLDLOCK) WHERE ScoreID = ' + CAST(@ruleScoreID as varchar(15)) + ' AND RuleID = ' + CAST(@RuleID as varchar(15)) + ' AND ContactID IN (SELECT ItemID FROM Func_Selection_ParseIDs(''' + @ContactIDs + ''')))';
  END
  
  ------------------------------------------ Activity rule
  IF @ruleType = 0
  BEGIN 
    -- Prepare expiration date query
    SET @expirationDate =
    CASE @RuleValidUnits
      WHEN 0 THEN 'DATEADD(dd, ' + CAST(@RuleValidFor as varchar(50)) + ', MAX(ActivityCreated)) AS ActCreated'
      WHEN 1 THEN 'DATEADD(wk, ' + CAST(@RuleValidFor as varchar(50)) + ', MAX(ActivityCreated)) AS ActCreated'
      WHEN 2 THEN 'DATEADD(mm, ' + CAST(@RuleValidFor as varchar(50)) + ', MAX(ActivityCreated)) AS ActCreated'
      WHEN 3 THEN 'DATEADD(yy, ' + CAST(@RuleValidFor as varchar(50)) + ', MAX(ActivityCreated)) AS ActCreated'
      ELSE ISNULL('''' + CAST(@RuleExpiration as varchar(250)) + '''', 'NULL') + ' AS ActCreated'
    END
   
    -- Prepare time restriction in the past for time interval activities
    SET @timeRestriction =
    CASE @RuleValidUnits
      WHEN 0 THEN 'ActivityCreated >= DATEADD(dd, -' + CAST(@RuleValidFor as varchar(50)) + ', GETDATE())'
      WHEN 1 THEN 'ActivityCreated >= DATEADD(wk, -' + CAST(@RuleValidFor as varchar(50)) + ', GETDATE())'
      WHEN 2 THEN 'ActivityCreated >= DATEADD(mm, -' + CAST(@RuleValidFor as varchar(50)) + ', GETDATE())'
      WHEN 3 THEN 'ActivityCreated >= DATEADD(yy, -' + CAST(@RuleValidFor as varchar(50)) + ', GETDATE())'
      ELSE '1 = 1'
    END
    
    DECLARE @AdditionalJoin NVARCHAR(MAX) = ''

    -- Join additional table for page visit and landing page. Join OM_PageVisit table only when where condition uses data from this table (performance optimization)
    IF (@ruleParameter = 'pagevisit' OR @ruleParameter = 'landingpage') AND @IncludePageVisitData = 1
    BEGIN
      SET @AdditionalJoin = 'LEFT JOIN OM_PageVisit ON OM_Activity.ActivityID = OM_PageVisit.PageVisitActivityID '
    END
    -- Join additional table for internal and external search. This isn't as common activity as pagevisit, so no optimization is made here
    ELSE IF @ruleParameter = 'internalsearch' OR @ruleParameter = 'externalsearch'
    BEGIN
      SET @AdditionalJoin = 'LEFT JOIN OM_Search ON OM_Activity.ActivityID = OM_Search.SearchActivityID'
    END
    
    DECLARE @RuleValueExpression NVARCHAR(MAX);
    IF @ruleIsRecurring = 0
    BEGIN    
      SET @RuleValueExpression = @ruleValue
    END
    ELSE IF (@ruleMaxPoints IS NOT NULL) AND (@ruleMaxPoints <> 0)
    BEGIN
      IF @ruleMaxPoints > 0
        SET @RuleValueExpression = 'CASE WHEN ' + CAST(@ruleMaxPoints as varchar(50)) + ' < COUNT(ContactID) * ' + CAST(@ruleValue as varchar(50)) + ' THEN ' + CAST(@ruleMaxPoints as varchar(50)) + ' ELSE COUNT(ContactID) * ' + CAST(@ruleValue as varchar(50)) + ' END'
      ELSE
        SET @RuleValueExpression = 'CASE WHEN ' + CAST(@ruleMaxPoints as varchar(50)) + ' > COUNT(ContactID) * ' + CAST(@ruleValue as varchar(50)) + ' THEN ' + CAST(@ruleMaxPoints as varchar(50)) + ' ELSE COUNT(ContactID) * ' + CAST(@ruleValue as varchar(50)) + ' END'
    END
    ELSE
    BEGIN
      SET @RuleValueExpression = 'COUNT(ContactID) * ' + CAST(@ruleValue as varchar(50))
    END

    DECLARE @Query NVARCHAR(MAX) = 'INSERT INTO OM_ScoreContactRule 
                                    SELECT ' + CAST(@ruleScoreID AS NVARCHAR(15)) + ', ContactID, ' + CAST(@RuleID AS NVARCHAR(15)) + ', ' + @RuleValueExpression + ', ' + @expirationDate + '
                                    FROM OM_Activity 
                                    INNER JOIN OM_Contact ON OM_Contact.ContactID = OM_Activity.ActivityActiveContactID 
                                    ' + @AdditionalJoin + '
                                    WHERE (' + @WhereCond + ') AND ' + @timeRestriction + '
                                    GROUP BY ContactID'
    
    EXEC (@Query);

  ------------------------------------------ Attribute rule:
  END 
  ELSE IF @ruleType=1
  BEGIN
    EXEC ('INSERT INTO OM_ScoreContactRule 
            SELECT ' + @ruleScoreID + ', ContactID, ' + @RuleID + ', ' + @ruleValue + ', NULL 
            FROM OM_Contact
            WHERE ' + @WhereCond);
  END
END

GO
