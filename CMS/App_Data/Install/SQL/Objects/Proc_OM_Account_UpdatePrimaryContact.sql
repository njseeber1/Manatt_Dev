SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_OM_Account_UpdatePrimaryContact]
	@OldContactID int,
	@NewContactID int
AS
BEGIN
	SET NOCOUNT ON;
    UPDATE OM_Account SET AccountPrimaryContactID = @NewContactID WHERE AccountPrimaryContactID = @OldContactID;
	UPDATE OM_Account SET AccountSecondaryContactID = @NewContactID WHERE AccountSecondaryContactID = @OldContactID;
END


GO
