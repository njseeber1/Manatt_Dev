SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_OM_ScoreContactRule_AddContacts]
@ScoreID int,
@RuleID int,
@Value int,
@ContactIDs varchar(MAX)
AS
BEGIN
INSERT INTO OM_ScoreContactRule (ScoreID, ContactID, RuleID, Value)
  SELECT @ScoreID, ContactIDs.ItemID, @RuleID, @Value FROM 
    (SELECT ItemID FROM Func_Selection_ParseIDs(@ContactIDs)) as ContactIDs
  WHERE ContactIDs.ItemID NOT IN (SELECT ContactID FROM OM_ScoreContactRule WHERE ScoreID=@ScoreID and ContactID=ContactIDs.ItemID and RuleID=@RuleID )
END


GO
