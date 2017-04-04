SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_CMS_ObjectVersionHistoryUser_Joined]
AS
SELECT * FROM CMS_ObjectVersionHistory LEFT OUTER JOIN CMS_User ON CMS_User.UserID = CMS_ObjectVersionHistory.VersionModifiedByUserID


GO
