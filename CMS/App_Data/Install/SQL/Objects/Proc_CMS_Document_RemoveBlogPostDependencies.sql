SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_CMS_Document_RemoveBlogPostDependencies]
	@DocumentID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM Blog_Comment WHERE CommentPostDocumentID = @DocumentID; 
	DELETE FROM Blog_PostSubscription WHERE SubscriptionPostDocumentID = @DocumentID;
END


GO
