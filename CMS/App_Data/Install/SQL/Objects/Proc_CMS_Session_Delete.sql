SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_CMS_Session_Delete]
	@SessionIdentifier nvarchar(200)
AS
BEGIN
	DELETE FROM CMS_Session WHERE SessionIdentificator = @SessionIdentifier	
END


GO
