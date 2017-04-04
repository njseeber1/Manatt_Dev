SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Surrounds given nvarchar parameter with localization macro tags.
CREATE FUNCTION [dbo].[Func_LocalizationMacro] (
 @localizationMacroKey NVARCHAR(MAX)
)  
RETURNS NVARCHAR(MAX) AS
BEGIN
	RETURN N'{$' + @localizationMacroKey + N'$}'
END

GO
