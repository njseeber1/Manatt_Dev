SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Proc_SM_UpdateInsightHits]
	@insightID int, 
	@periodDateTime datetime,
	@value bigint,
	@periodType nvarchar(10),
	@firstDayOfWeek int
as
begin
	set nocount on
	-- change the first day of week
	declare @originalFirstDayOfWeek int
	set @originalFirstDayOfWeek = @@datefirst
	set datefirst @firstDayOfWeek
	-- work with the date part only
	declare @periodFrom datetime
	declare @periodTo datetime
	set @periodDateTime = convert(date, @periodDateTime)
	-- store the value, if applicable, and update the aggregated hits
	if not exists(select InsightHitID from SM_InsightHit_Day where InsightHitInsightID = @insightID and InsightHitPeriodFrom = @periodDateTime)
	begin
		set @periodFrom = @periodDateTime
		set @periodTo = dateadd(day, 1, @periodFrom)
		insert into SM_InsightHit_Day(InsightHitInsightID, InsightHitPeriodFrom, InsightHitPeriodTo, InsightHitValue) values (@insightID, @periodFrom, @periodTo, @value)
		-- weeks
		set @periodFrom = dateadd(day, 1 - datepart(weekday, @periodDateTime), @periodDateTime)
		set @periodTo = dateadd(week, 1, @periodFrom)
		if not exists(select InsightHitID from SM_InsightHit_Week where InsightHitInsightID = @insightID and InsightHitPeriodFrom = @periodFrom)
		begin
			insert into SM_InsightHit_Week(InsightHitInsightID, InsightHitPeriodFrom, InsightHitPeriodTo, InsightHitValue) values (@insightID, @periodFrom, @periodTo, @value)
		end
			else
		begin
			if @periodType = 'lifetime'
				update SM_InsightHit_Week set InsightHitValue = @value where InsightHitInsightID = @insightID and InsightHitPeriodFrom = @periodFrom
			else if @periodType = 'day'
				update SM_InsightHit_Week set InsightHitValue = InsightHitValue + @value where InsightHitInsightID = @insightID and InsightHitPeriodFrom = @periodFrom
		end
		-- months
		set @periodFrom = dateadd(day, 1 - datepart(day, @periodDateTime), @periodDateTime)
		set @periodTo = dateadd(month, 1, @periodFrom)
		if not exists(select InsightHitID from SM_InsightHit_Month where InsightHitInsightID = @insightID and InsightHitPeriodFrom = @periodFrom)
		begin
			insert into SM_InsightHit_Month(InsightHitInsightID, InsightHitPeriodFrom, InsightHitPeriodTo, InsightHitValue) values (@insightID, @periodFrom, @periodTo, @value)
		end
			else
		begin
			if @periodType = 'lifetime'
				update SM_InsightHit_Month set InsightHitValue = @value where InsightHitInsightID = @insightID and InsightHitPeriodFrom = @periodFrom
			else if @periodType = 'day'
				update SM_InsightHit_Month set InsightHitValue = InsightHitValue + @value where InsightHitInsightID = @insightID and InsightHitPeriodFrom = @periodFrom
		end
		-- years
		set @periodFrom = dateadd(day, 1 - datepart(dayofyear, @periodDateTime), @periodDateTime)
		set @periodTo = dateadd(year, 1, @periodFrom)
		if not exists(select InsightHitID from SM_InsightHit_Year where InsightHitInsightID = @insightID and InsightHitPeriodFrom = @periodFrom)
		begin
			insert into SM_InsightHit_Year(InsightHitInsightID, InsightHitPeriodFrom, InsightHitPeriodTo, InsightHitValue) values (@insightID, @periodFrom, @periodTo, @value)
		end
			else
		begin
			if @periodType = 'lifetime'
				update SM_InsightHit_Year set InsightHitValue = @value where InsightHitInsightID = @insightID and InsightHitPeriodFrom = @periodFrom
			else if @periodType = 'day'
				update SM_InsightHit_Year set InsightHitValue = InsightHitValue + @value where InsightHitInsightID = @insightID and InsightHitPeriodFrom = @periodFrom
		end
	end
	set datefirst @originalFirstDayOfWeek
end


GO
