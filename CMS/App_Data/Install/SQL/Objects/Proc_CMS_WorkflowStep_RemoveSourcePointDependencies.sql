SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_CMS_WorkflowStep_RemoveSourcePointDependencies]
	@StepID int,
	@SourcePointGuid uniqueidentifier
AS
BEGIN
  -- Remove step roles
  DELETE FROM CMS_WorkflowStepRoles WHERE StepID = @StepID AND StepSourcePointGUID = @SourcePointGuid;
  -- Remove step users
  DELETE FROM CMS_WorkflowStepUser WHERE StepID = @StepID AND StepSourcePointGUID = @SourcePointGuid;
  -- Remove step transitions
  DELETE FROM CMS_WorkflowTransition WHERE TransitionStartStepID = @StepID AND TransitionSourcePointGUID = @SourcePointGuid;
END


GO
