SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_CMS_Class_RemoveChildVersions]
@ID int
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
	DELETE FROM [CMS_ObjectSettings] WHERE ObjectCheckedOutVersionHistoryID IN (
	  SELECT VersionID FROM CMS_ObjectVersionHistory WHERE 
		([VersionObjectType] = N'cms.query' AND [VersionObjectID] IN ( SELECT [QueryID] FROM [CMS_Query] WHERE ClassID = @ID)) OR 
		([VersionObjectType] = N'cms.transformation' AND [VersionObjectID] IN (SELECT [TransformationID] FROM [CMS_Transformation] WHERE [TransformationClassID] = @ID)) OR 
		([VersionObjectType] = N'cms.alternativeform' AND [VersionObjectID] IN (SELECT [FormID] FROM [CMS_AlternativeForm] WHERE [FormClassID] = @ID))
	);
    -- CMS_Query
    DELETE FROM [CMS_ObjectVersionHistory] WHERE [VersionObjectType] = N'cms.query' AND [VersionObjectID] IN ( SELECT [QueryID] FROM [CMS_Query] WHERE ClassID = @ID);
    -- CMS_Transformation
    DELETE FROM [CMS_ObjectVersionHistory] WHERE [VersionObjectType] = N'cms.transformation' AND [VersionObjectID] IN (SELECT [TransformationID] FROM [CMS_Transformation] WHERE [TransformationClassID] = @ID);    
    -- CMS Alternative forms
    DELETE FROM [CMS_ObjectVersionHistory] WHERE [VersionObjectType] = N'cms.alternativeform' AND [VersionObjectID] IN (SELECT [FormID] FROM [CMS_AlternativeForm] WHERE [FormClassID] = @ID);
    
    COMMIT TRANSACTION;
END


GO
