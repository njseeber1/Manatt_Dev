SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_CMS_Session_Delete_Expired]
AS
BEGIN
	DELETE FROM CMS_Session WHERE SessionExpired = '1' OR CURRENT_TIMESTAMP > SessionExpires	
END


GO
