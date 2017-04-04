SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_Personas_ReevaluateAllContacts]
	@SiteId int,
	@ContactIDs Type_CMS_IntegerTable readonly
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  DECLARE @InputContactsCount int;
	SET @InputContactsCount = (SELECT COUNT(*) FROM @ContactIDs);

   -- Set new persona for contacts from subquery, if contact is not in subquery it means that he does not belong to any persona and NULL is set to the ContactPersonaID column
	UPDATE [OM_Contact]
	SET [ContactPersonaID] = [Fourth].[PersonaID]
	FROM [OM_Contact]
	LEFT JOIN 
	(
		SELECT [ContactID], [PersonaID] FROM
		(
			-- Order personas for contact by quotient to be able to retrieve the persone with highest quotient
			SELECT [PersonaID], [ContactID], ROW_NUMBER() OVER (PARTITION BY [ContactID] ORDER BY [Quotient] DESC, [PersonaID] ASC) AS [RowNumber] FROM 
			(
				SELECT [PersonaID], [ContactID], 1.0 * [TotalPoints] / [PersonaPointsThreshold] AS [Quotient] FROM
				(
					-- Join contact with counted points for persona rules
					SELECT [PersonaID], [ContactID], [PersonaPointsThreshold], SUM([Value]) AS [TotalPoints]
					FROM [Personas_Persona] 
					LEFT JOIN [OM_ScoreContactRule] ON [ScoreID] = [PersonaScoreID] 
					WHERE (@SiteId < 0 OR [PersonaSiteId] = @SiteId)
						AND [PersonaEnabled] = 1
						AND 
						(
							[Expiration] IS NULL OR 
							[Expiration] >= GetDate()
						)
            AND
            (
              @InputContactsCount = 0 OR
              [ContactId] IN (SELECT * FROM @ContactIDs)
            )
					GROUP BY [PersonaID], [ContactId], [PersonaPointsThreshold]
				) AS [First]			
			) AS [Second] 
			-- Omit all contacts with not enough points for persona
			WHERE [Quotient] >= 1
		) AS [Third] 
		WHERE [Third].[RowNumber] = 1
	) AS [Fourth]
	ON [Fourth].[ContactID] = [OM_Contact].[ContactID]
	WHERE (@SiteId < 0 OR [OM_Contact].[ContactSiteID] = @SiteId)
   AND 
   (
     -- When running for list of contacts don't filter out merged ones (so that their persona gets set to null).
     @InputContactsCount > 0 OR
     [OM_Contact].[ContactMergedWithContactID] IS NULL
   )
   AND 
   (
     @InputContactsCount = 0 OR
     [OM_Contact].[ContactId] IN (SELECT * FROM @ContactIDs)
   )
END



GO
