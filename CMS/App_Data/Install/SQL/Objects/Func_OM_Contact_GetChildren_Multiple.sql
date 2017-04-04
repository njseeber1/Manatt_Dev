SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Func_OM_Contact_GetChildren_Multiple]
(
	@contactIDs nvarchar(max),
	@includeParent int
)
 
RETURNS @result TABLE
(
	ContactID int
)
AS
BEGIN
	DECLARE @parsed TABLE (ContactID int);
	INSERT INTO @parsed SELECT * FROM Func_Selection_ParseIDs(@contactIDs);
	
    -- Recursively find all children of current contact
    WITH Recursion(ContactID)
    AS
    (
        SELECT c.ContactID
        FROM OM_Contact c, @parsed p
        WHERE c.ContactMergedWithContactID = p.ContactID
        UNION ALL
        SELECT c.ContactID
        FROM OM_Contact c, @parsed p
        WHERE c.ContactGlobalContactID = p.ContactID
        UNION ALL
        SELECT c.ContactID
        FROM OM_Contact c INNER JOIN Recursion r ON c.ContactMergedWithContactID = r.ContactID
        UNION ALL
        SELECT c.ContactID
        FROM OM_Contact c INNER JOIN Recursion r ON c.ContactGlobalContactID = r.ContactID
    )
    INSERT INTO @result SELECT DISTINCT ContactID FROM Recursion
    OPTION (MAXRECURSION 500)

	-- Include parent contact IDs in result
	IF @includeParent = 1
      INSERT INTO @result SELECT DISTINCT * FROM @parsed
      
	RETURN 
END


GO
