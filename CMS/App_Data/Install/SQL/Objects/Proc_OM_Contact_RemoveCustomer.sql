SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Proc_OM_Contact_RemoveCustomer
		@ID int
AS
BEGIN
	SET NOCOUNT ON;

	-- Remove OM_Membership relation
	DELETE FROM OM_Membership WHERE RelatedID = @ID AND MemberType = 1 -- 1 = ecommerce customer	
END


GO
