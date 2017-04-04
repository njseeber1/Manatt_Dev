SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_Chat_CleanOldInitiatedChatRequests]
AS
BEGIN
    DECLARE @Threshold DATETIME;
    SET @Threshold = DATEADD(HOUR, -1, GETDATE()); -- Mark as deleted request older than 1 hour (also after one more hour delete them physically)

    -- Set state to Deleted (so it will be removed from cache)
    UPDATE Chat_InitiatedChatRequest
    SET InitiatedChatRequestState = 4, InitiatedChatRequestLastModification = GETDATE()
    WHERE InitiatedChatRequestLastModification < @Threshold -- Request must be older than threshold
        AND (InitiatedChatRequestState = 2 OR InitiatedChatRequestState = 3 OR NOT EXISTS(SELECT * FROM Chat_OnlineSupport AS OS WHERE OS.ChatOnlineSupportChatUserID = InitiatedChatRequestInitiatorChatUserID)); 
        -- request has to be Accepted or Declined or Supporter who initiated it has to be offline

    -- Delete for real request which are in state Deleted (and was moved to this state more than 2 hours ago)
    DELETE FROM Chat_InitiatedChatRequest
    WHERE InitiatedChatRequestState = 4 AND InitiatedChatRequestLastModification < @Threshold
    
    SELECT @@ROWCOUNT;
END


GO
