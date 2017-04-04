SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_Newsletter_Subscriber_GetRoleUsers]
@RoleID int,
@TopN int,
@LastUserID int,
@MonitoringEnabled bit,
@BounceLimit int
AS
BEGIN
SET NOCOUNT ON
    
    IF (@MonitoringEnabled = 0)
		BEGIN
			SET @BounceLimit = 0
		END
    
    -- Select only TOP N
    IF (@TopN > 0)
		BEGIN				
			-- Get all active users in a role
			SELECT TOP (@TopN) UserID, Email
				FROM View_CMS_UserSettingsRole_Joined
				WHERE RoleID = @RoleID AND UserID > @LastUserID AND
				   (UserBounces IS NULL OR (@BounceLimit <= 0 AND UserBounces < 2147483647) OR UserBounces < @BounceLimit)
				ORDER BY UserID
		END
	-- Select all
	ELSE
		BEGIN
			-- Get all active users in a role
			SELECT UserID, Email
				FROM View_CMS_UserSettingsRole_Joined
				WHERE RoleID = @RoleID AND UserID > @LastUserID AND
				   (UserBounces IS NULL OR (@BounceLimit <= 0 AND UserBounces < 2147483647) OR UserBounces < @BounceLimit)
				ORDER BY UserID
		END
END


GO
