SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Proc_CMS_BannerManagement_GetRandomBanner]
	@BannerCategoryID INT,
	@DecrementHitsLeft BIT
AS
BEGIN
	-- query taken from: http://stackoverflow.com/questions/58457/random-weighted-choice-in-t-sql/454454#454454
	SET NOCOUNT ON;
	
	DECLARE @id int, @weight_sum float, @weight_point float
	DECLARE @banners TABLE (bannerID int, bannerWeight float)
	
	INSERT INTO @banners
	(
		bannerID, bannerWeight
	)
	(
		SELECT [CMS_Banner].[BannerID], [CMS_Banner].[BannerWeight]
		FROM [CMS_Banner]
		WHERE BannerCategoryID = @BannerCategoryID
            AND BannerEnabled = 1
            AND (BannerFrom IS NULL OR BannerFrom <= GETDATE())
            AND (BannerTo IS NULL OR BannerTo >= GETDATE())
            AND (BannerHitsLeft IS NULL OR BannerHitsLeft > 0)
            AND (BannerClicksLeft IS NULL OR BannerClicksLeft > 0)
	)
	
	SELECT @weight_sum = SUM(bannerWeight)
	FROM @banners

	SELECT @weight_point = (@weight_sum * RAND())

	SELECT
		@id = CASE WHEN @weight_point < 0 THEN @id ELSE bannerID END,
		@weight_point = @weight_point - bannerWeight
	FROM
		@banners

	-- Decrement hits left if neede
	IF (@DecrementHitsLeft = 1)
	BEGIN
		UPDATE [CMS_Banner] 
		SET BannerHitsLeft = BannerHitsLeft - 1 
		WHERE [CMS_Banner].[BannerID] = @id
	END

	SELECT * 
		FROM [CMS_Banner]
		WHERE [CMS_Banner].[BannerID] = @id
END



GO
