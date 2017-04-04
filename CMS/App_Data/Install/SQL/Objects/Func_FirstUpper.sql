SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Func_FirstUpper] (
 @str NVARCHAR(MAX)
)  
RETURNS NVARCHAR(MAX) AS
BEGIN
	DECLARE @strlen AS INT = LEN(@str);

	IF (@strlen > 0)
	BEGIN
		SET @str = UPPER(LEFT(@str, 1)) + RIGHT(@str, @strlen - 1)
	END

	RETURN @str 
END

GO
