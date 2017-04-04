SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Proc_Analytics_ConversionCampaignSource_AddUTMParameters]
    @ConversionCampaignSourceTable Type_Analytics_ConversionCampaignSourceTable READONLY
AS
BEGIN
	MERGE 
	   Analytics_ConversionCampaignSource AS target
	USING
		@ConversionCampaignSourceTable AS source
	ON target.CampaignID = source.CampaignID 
	   AND target.ConversionID = source.ConversionID 
	   AND target.SourceName = source.SourceName 
	WHEN MATCHED THEN
	   UPDATE SET ConversionHits = target.ConversionHits + source.ConversionHits
	WHEN NOT MATCHED THEN
	   INSERT (CampaignID, ConversionID, SourceName, ConversionHits)
	   VALUES (source.CampaignID, source.ConversionID, source.SourceName, source.ConversionHits)
	;
END





GO
