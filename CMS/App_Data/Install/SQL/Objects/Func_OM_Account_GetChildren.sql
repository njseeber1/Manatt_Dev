SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Func_OM_Account_GetChildren] 
(
	@currentAccountId int,
	@includeParent int
)
RETURNS @result TABLE
(
	AccountID int
)
AS
BEGIN
    -- Recursively find all children of current account
    WITH Recursion(AccountID)
    AS
    (
        SELECT AccountID
        FROM OM_Account a
        WHERE a.AccountMergedWithAccountID = @currentAccountId
		UNION ALL
		SELECT AccountID
        FROM OM_Account a
        WHERE a.AccountGlobalAccountID = @currentAccountId
		UNION ALL
        SELECT a.AccountID
        FROM OM_Account a INNER JOIN Recursion r ON a.AccountMergedWithAccountID = r.AccountID
		UNION ALL
        SELECT a.AccountID
        FROM OM_Account a INNER JOIN Recursion r ON a.AccountGlobalAccountID = r.AccountID
    )
    INSERT INTO @result SELECT AccountID FROM Recursion 
	-- Include parent account ID in result
	IF @includeParent = 1
      INSERT INTO @result VALUES (@currentAccountId)
	RETURN 
END



GO
