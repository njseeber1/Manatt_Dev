SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[Func_OM_Contact_GetParent]  
(
	@contactID int
)
RETURNS int
AS
BEGIN
    DECLARE @parentContactID INT;

    WITH Recursion(ContactID, ContactGlobalContactID)
		AS
		(
			SELECT ContactID, ContactGlobalContactID
			FROM OM_Contact c
			WHERE c.ContactID = @contactID
			UNION ALL
			SELECT c.ContactID, c.ContactGlobalContactID
			FROM OM_Contact c INNER JOIN Recursion r ON r.ContactGlobalContactID = c.ContactID
		)
		SELECT TOP 1 @parentContactID = ContactID
		FROM Recursion 
		WHERE ContactGlobalContactID IS NULL
    OPTION (MAXRECURSION 500)

    RETURN @parentContactID  
END


GO
