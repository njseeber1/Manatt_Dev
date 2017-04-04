SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_CMS_User_RemoveSiteRoles]
	@UserID int,
	@SiteID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM [CMS_UserRole] WHERE
		UserID=@UserID AND
		RoleID IN (
			SELECT RoleID FROM [CMS_Role]
			WHERE [CMS_Role].[SiteID]=@SiteID
		);
	DELETE FROM [Community_GroupMember] WHERE
		MemberUserID=@UserID AND 
		MemberGroupID in (
			SELECT MemberGroupID FROM [Community_Group] 
			WHERE GroupSiteID=@SiteID
		);
END


GO
