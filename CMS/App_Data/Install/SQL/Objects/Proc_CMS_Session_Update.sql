SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_CMS_Session_Update] 
	@SessionIdentifier nvarchar(200),
    @SessionUserID int, 
    @SessionLocation nvarchar(450),
	@SessionLastActive datetime, 
	@SessionLastLogon datetime, 
	@SessionExpires datetime, 
	@SessionExpired bit,
	@SessionSiteID int, 
	@SessionUserIsHidden bit,
	@SessionFullName nvarchar(450),
	@SessionEmail nvarchar(100),
	@SessionUserName nvarchar(100),
	@SessionNickName nvarchar(100),
	@SessionUserCreated datetime,
	@SessionContactID int
AS
BEGIN
	DELETE FROM CMS_Session WHERE SessionIdentificator = @SessionIdentifier
	INSERT INTO CMS_Session ([SessionIdentificator], [SessionUserID], [SessionLocation], [SessionLastActive], [SessionLastLogon], [SessionExpires], [SessionExpired], [SessionSiteID], [SessionUserIsHidden],[SessionFullName] ,[SessionEmail],[SessionUserName],[SessionNickName],[SessionUserCreated],[SessionContactID] ) VALUES (@SessionIdentifier,  @SessionUserID, @SessionLocation, @SessionLastActive, @SessionLastLogon, @SessionExpires, @SessionExpired, @SessionSiteID, @SessionUserIsHidden,@SessionFullName,@SessionEmail,@SessionUserName,@SessionNickName,@SessionUserCreated,@SessionContactID); SELECT SCOPE_IDENTITY() AS [SessionIdentificator]
END


GO
