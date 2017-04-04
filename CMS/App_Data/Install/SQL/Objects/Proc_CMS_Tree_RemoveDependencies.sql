SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Proc_CMS_Tree_RemoveDependencies]
    @NodeID int,
    @NodeGUID uniqueidentifier,
    @NodeSiteID int
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    UPDATE CMS_EventLog SET NodeID = NULL WHERE NodeID = @NodeID; 
        
    DELETE FROM CMS_DocumentAlias WHERE AliasNodeID = @NodeID    
    UPDATE Community_Group SET GroupNodeGUID = NULL WHERE GroupSiteID = @NodeSiteID AND GroupNodeGUID = @NodeGUID
    
	DELETE FROM Personas_PersonaNode WHERE NodeID = @NodeID

    COMMIT TRANSACTION;
END



GO
