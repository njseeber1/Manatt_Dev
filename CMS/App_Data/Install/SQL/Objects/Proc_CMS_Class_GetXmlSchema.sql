SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_CMS_Class_GetXmlSchema]
	@ClassName nvarchar(100)
AS
BEGIN
	SELECT ClassXmlSchema, ClassTableName FROM [CMS_Class] WHERE ClassName = @ClassName
END



GO
