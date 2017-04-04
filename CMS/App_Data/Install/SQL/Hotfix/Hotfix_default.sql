-- HF9-51 Replacing wrong default statistics code name for daily exit page report
DECLARE @HOTFIXVERSION INT;
SET @HOTFIXVERSION = (SELECT [KeyValue] FROM [CMS_SettingsKey] WHERE [KeyName] = N'CMSHotfixVersion')
IF @HOTFIXVERSION < 1
BEGIN

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columntype="datetime" guid="c4fb5fa9-d4c9-4e2a-8729-5128296b5cd5" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddMonths(-1).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><controlname>calendarcontrol</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columntype="datetime" guid="a003a89e-90e2-4325-8c6f-ea227a01939b" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><controlname>calendarcontrol</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="65080419-ff4e-45db-bd16-947473425d6e" publicfield="false" reftype="Required" visibility="none"><properties><defaultvalue>exitpage</defaultvalue></properties><settings><controlname>dropdownlistcontrol</controlname><Query>SELECT DISTINCT StatisticsCode, StatisticsCode FROM Analytics_Statistics</Query></settings></field></form>'
    WHERE [ReportGUID] = 'b147a0d3-b309-4be8-b94d-77dd45a21288'

END
GO

-- HF9-50 - Remove test page templates
DECLARE @HOTFIXVERSION INT;
SET @HOTFIXVERSION = (SELECT [KeyValue] FROM [CMS_SettingsKey] WHERE [KeyName] = N'CMSHotfixVersion')
IF @HOTFIXVERSION < 1
BEGIN
	DELETE FROM [CMS_PageTemplate]
	WHERE [PageTemplateGUID] IN (
		'C233553F-4DEC-4B51-A82A-47B3552CABC8',
		'F267096C-8192-46D4-8554-FD938AF405F4',
		'E1259A99-20BD-44D5-862E-29F98FB2A43F',
		'A99B808C-47C8-4338-9C00-ABAA8C77BD0F',
		'73F867CD-7790-404E-B606-AB12516F41F8',
		'1274ED06-D591-4760-ABF2-6DCAB721A5C1',
		'ECE89CFE-1700-4203-90CE-6803901A8A25',
		'D58963A4-32AA-4CAF-8269-A15A626CC176'
	)
END
GO

-- HF9-47 - DocumentNamePath inconsistency after recreating different
DECLARE @HOTFIXVERSION INT;
SET @HOTFIXVERSION = (SELECT [KeyValue] FROM [CMS_SettingsKey] WHERE [KeyName] = N'CMSHotfixVersion')
IF @HOTFIXVERSION < 1
BEGIN
	declare @alterScript NVARCHAR(MAX)
	select @alterScript =
'ALTER PROCEDURE [dbo].[Proc_CMS_Document_UpdateDocumentNamePath]
	 @NodeID int,
	 @DocumentID int,
	 @PrefixesXML nvarchar(max),
	 @DefaultCultureCode nvarchar(10),
	 @GenerateAliases bit,
	 @CurrentDate datetime2(7)
	AS
	BEGIN

	-- Get XML from the string representation
	DECLARE @Prefixes xml = CAST(@PrefixesXML as XML);

	-- Prepare temp table for the results
	DECLARE @Documents TABLE
	(
	  NodeID int, 
	  DocumentID int, 
	  OriginalNamePrefix nvarchar(1500), 
	  NamePrefix nvarchar(1500), 
	  OriginalUrlPrefix nvarchar(450), 
	  UrlPrefix nvarchar(450)
	);

	WITH 
	Prefixes AS
	(
		SELECT 
			ref.value(''Culture[1]'', ''nvarchar(10)'') AS DocumentCulture, 
			ref.value(''(NamePath/Original)[1]'', ''nvarchar(1500)'') AS OriginalNamePrefix, 
			ref.value(''(NamePath/Current)[1]'', ''nvarchar(1500)'') AS NamePrefix, 
			ref.value(''(UrlPath/Original)[1]'', ''nvarchar(450)'') AS OriginalUrlPrefix, 
			ref.value(''(UrlPath/Current)[1]'', ''nvarchar(450)'') AS UrlPrefix 
		FROM @Prefixes.nodes(''/Prefixes/Prefix'') xmlData(ref)
	),
	Base AS
	(
		SELECT DocumentID, NodeID, NodeLinkedNodeID, TopDocumentCulture, OriginalNamePrefix, NamePrefix, OriginalUrlPrefix, UrlPrefix 
		FROM
		(
			SELECT 
				V.DocumentID, V.NodeID, V.NodeLinkedNodeID,
				V.DocumentCulture AS TopDocumentCulture,
				OriginalNamePrefix, NamePrefix, OriginalUrlPrefix, UrlPrefix,
				-- Prefer parent data in culture of the document, than in default culture, any other culture at least 
				ROW_NUMBER() OVER (PARTITION BY V.DocumentID, V.NodeID ORDER BY CASE WHEN P.DocumentCulture = V.DocumentCulture THEN 1 WHEN P.DocumentCulture = @DefaultCultureCode THEN 2 ELSE 3 END, P.DocumentCulture) AS CMS_C
	 		FROM View_CMS_Tree_Joined AS V WITH (NOLOCK)
					-- Get original and current prefix
					INNER JOIN Prefixes ON V.DocumentCulture = Prefixes.DocumentCulture
					-- Get parent values
					INNER JOIN View_CMS_Tree_Joined as P WITH (NOLOCK) ON (SELECT NodeParentID FROM CMS_Tree AS T WITH (NOLOCK) WHERE T.NodeID = V.NodeOriginalNodeID) = P.NodeID
			-- Get either all culture versions or just the one based on DocumentID
			WHERE (@NodeID <> 0 AND V.NodeOriginalNodeID = @NodeID) OR (@DocumentID <> 0 AND V.DocumentID = @DocumentID)
		) AS B
		-- Get data with best matching parent data
		WHERE CMS_C = 1
	),
	Candidates AS
	(
		SELECT * FROM Base

		UNION ALL

		SELECT DocumentID, NodeID, NodeLinkedNodeID, TopDocumentCulture, OriginalNamePrefix, NamePrefix, OriginalUrlPrefix, UrlPrefix FROM
		(
			SELECT 
				V.DocumentID, V.NodeID, V.NodeLinkedNodeID, 
				Candidates.TopDocumentCulture, Candidates.DocumentID AS CandidatesParentDocumentID,
				P.DocumentID AS ParentDocumentID,
				Prefixes.OriginalNamePrefix, Prefixes.NamePrefix, Prefixes.OriginalUrlPrefix, Prefixes.UrlPrefix,
				-- Prefer parent data in culture of the document, than in default culture, any other culture at least 
				ROW_NUMBER() OVER (PARTITION BY V.DocumentID, V.NodeID ORDER BY CASE WHEN P.DocumentCulture = V.DocumentCulture THEN 1 WHEN P.DocumentCulture = @DefaultCultureCode THEN 2 ELSE 3 END, P.DocumentCulture) AS CMS_C
			FROM Candidates
				-- Get original and current prefix
				INNER JOIN Prefixes ON Candidates.TopDocumentCulture = Prefixes.DocumentCulture
				-- Get all child documents (for links get the originals) of the current one having the original prefix
				INNER JOIN View_CMS_Tree_Joined V WITH (NOLOCK) ON (SELECT NodeParentID FROM CMS_Tree AS T WHERE T.NodeID = V.NodeOriginalNodeID) = Candidates.NodeID AND V.DocumentNamePath LIKE Prefixes.OriginalNamePrefix + ''%''
				-- Get all combinations with their parents
				INNER JOIN View_CMS_Tree_Joined as P WITH (NOLOCK) ON (SELECT NodeParentID FROM CMS_Tree AS T WHERE T.NodeID = V.NodeOriginalNodeID) = P.NodeID
		) AS LevelCandidates
		-- Include only those whose primary parents are included in the current scope
		WHERE CandidatesParentDocumentID = ParentDocumentID AND LevelCandidates.CMS_C = 1 AND LevelCandidates.DocumentID NOT IN (SELECT DocumentID FROM Base)
	),
	Items AS
	(
		-- Filter links since the originals are incldued as well
		SELECT DISTINCT NodeID, DocumentID, OriginalNamePrefix, NamePrefix, OriginalUrlPrefix, UrlPrefix 
		FROM Candidates
		WHERE NodeLinkedNodeID IS NULL
	)

	-- Get the final result set
	INSERT INTO @Documents SELECT NodeID, DocumentID, OriginalNamePrefix, NamePrefix, OriginalUrlPrefix, UrlPrefix FROM Items

	-- Generate document aliases
	IF (@GenerateAliases = 1)
	BEGIN
		-- Insert alias for all child documents where original URL path differs from the new one and the alias with same URL path doesn''t exist
		INSERT INTO CMS_DocumentAlias 
		(
			AliasNodeID, 
			AliasCulture, 
			AliasURLPath, 
			AliasExtensions, 
			AliasWildcardRule, 
			AliasPriority, 
			AliasGUID, 
			AliasLastModified, 
			AliasSiteID
		)
		SELECT 
			D.NodeID AS AliasNodeID, 
			DocumentCulture AS AliasCulture, 
			DocumentURLPath AS AliasURLPath, 
			'''' AS AliasExtensions, 
			'''' AS AliasWildcardRule, 
			1 AS AliasPriority, 
			NEWID() AS AliasGUID, 
			@CurrentDate AS AliasLastModified, 
			NodeSiteID AS AliasSiteID
		FROM @Documents AS D INNER JOIN View_CMS_Tree_Joined AS V ON D.DocumentID = V.DocumentID
		WHERE 
			-- Aliases were already generated for updated culture version
			-- Do not include links since the aliases are same as for originals included in the results
			D.DocumentID <> @DocumentID  AND NodeLinkedNodeID IS NULL
			-- Do not generate aliases for content-only pages
			AND NodeIsContentOnly = 0
			-- URL path is generated and differs from the original one
			AND DocumentUrlPath <> 
				(
				CASE WHEN DocumentUseNamePathForUrlPath = 1 AND (ISNULL(DocumentUrlPath, '''') <> '''')
				THEN
					-- Path starts with original URL path prefix
					CASE WHEN LEFT(DocumentUrlPath, LEN(OriginalUrlPrefix)) = OriginalUrlPrefix 
					THEN
						-- Replace original URL prefix with new URL path prefix
						UrlPrefix + SUBSTRING(DocumentUrlPath, LEN(OriginalUrlPrefix) + 1, LEN(DocumentUrlPath)) 
					-- Path starts with original name path prefix
					WHEN LEFT(DocumentUrlPath, LEN(OriginalNamePrefix)) = OriginalNamePrefix 
					THEN
						-- Replace original Name prefix with new URL path prefix (when new document is created, DocumentNamePath of the parent is used to build the URL path)
						UrlPrefix + SUBSTRING(DocumentUrlPath, LEN(OriginalNamePrefix) + 1, LEN(DocumentUrlPath)) 
					END
			  	ELSE DocumentUrlPath END
				)
			-- There is no alias with the same URL path
			AND NOT EXISTS (SELECT AliasID FROM CMS_DocumentAlias WHERE AliasURLPath = DocumentUrlPath AND AliasNodeID = D.NodeID AND (AliasCulture = DocumentCulture OR ISNULL(AliasCulture, '''') = ''''))
	END

	-- Propagate new prefixes to all child documents
	-- Currently modified document is not udpated since the paths were already udpated by API
	UPDATE CMS_Document SET
	DocumentNamePath = 
		(
		-- Path starts with original name prefix
		CASE WHEN LEFT(DocumentNamePath, LEN(OriginalNamePrefix)) = OriginalNamePrefix
		THEN
			NamePrefix + SUBSTRING(DocumentNamePath, LEN(OriginalNamePrefix) + 1, LEN(DocumentNamePath))
		ELSE DocumentNamePath END
		),
	DocumentUrlPath = 
		(
		CASE WHEN DocumentUseNamePathForUrlPath = 1 AND (ISNULL(DocumentUrlPath, '''') <> '''')
		THEN
			-- Path starts with original URL path prefix
			CASE WHEN LEFT(DocumentUrlPath, LEN(OriginalUrlPrefix)) = OriginalUrlPrefix 
			THEN
				-- Replace original URL prefix with new URL path prefix
				UrlPrefix + SUBSTRING(DocumentUrlPath, LEN(OriginalUrlPrefix) + 1, LEN(DocumentUrlPath)) 
			-- Path starts with original name path prefix
			WHEN LEFT(DocumentUrlPath, LEN(OriginalNamePrefix)) = OriginalNamePrefix 
			THEN
				-- Replace original Name prefix with new URL path prefix (when new document is created, DocumentNamePath of the parent is used to build the URL path)
				UrlPrefix + SUBSTRING(DocumentUrlPath, LEN(OriginalNamePrefix) + 1, LEN(DocumentUrlPath)) 
			END
		ELSE DocumentUrlPath END
		)
    FROM CMS_Document AS D INNER JOIN @Documents AS R ON D.DocumentID = R.DocumentID
	WHERE R.DocumentID <> @DocumentID

	END';

	exec(@alterScript)
END
GO


-- HF9-24 Update reports default properties to correct values
DECLARE @HOTFIXVERSION INT;
SET @HOTFIXVERSION = (SELECT [KeyValue] FROM [CMS_SettingsKey] WHERE [KeyName] = N'CMSHotfixVersion')
IF @HOTFIXVERSION < 1
BEGIN

DECLARE @reportCategoryID int;
SET @reportCategoryID = (SELECT TOP 1 [CategoryID] FROM [Reporting_ReportCategory] WHERE [CategoryGUID] = '0521d2b1-6b4a-47eb-bc6d-c8f9540f7c7c')
IF @reportCategoryID IS NOT NULL BEGIN

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddMonths(-1).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" reftype="Required" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>java</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = '2c996cda-9dd3-4817-afaa-caa9b89e2c03'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddDays(-1)%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>True</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>True</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>java</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = 'fe248a73-bea3-4709-91be-638dd8f516a1'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddYears(-1).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columntype="date" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>java</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = 'c61fbe1f-77a9-402f-94a7-cbcafe87e635'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddWeeks(-15).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>java</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = '61dc4d4a-b81c-49c7-9944-b56235abdcc3'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" reftype="Required" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddYears(-6).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><controlname>calendarcontrol</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>java</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = '0afebb85-80bf-4790-aeea-b55203d34217'

END

SET @reportCategoryID = (SELECT TOP 1 [CategoryID] FROM [Reporting_ReportCategory] WHERE [CategoryGUID] = '1d197150-65da-44ea-9dab-473e445fabd8')
IF @reportCategoryID IS NOT NULL BEGIN

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddMonths(-1).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" reftype="Required" visibility="none"><properties><defaultvalue>screenresolution</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = '410cdbd5-ad0b-4cf6-81fc-f9ff0683361c'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" reftype="Required" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddDays(-1)%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>True</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>True</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>screenresolution</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = '7fcf03e2-1b74-4a6a-8287-b4c0323d8e34'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddYears(-1).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>screenresolution</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = 'a49ae785-9d9f-4bb7-b901-dda143686d62'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddWeeks(-15).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>screenresolution</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = '28343399-8990-4475-a82d-820651e02302'

END

SET @reportCategoryID = (SELECT TOP 1 [CategoryID] FROM [Reporting_ReportCategory] WHERE [CategoryGUID] = '4522b3bf-43a9-4b69-a542-2fcd2d188724')
IF @reportCategoryID IS NOT NULL BEGIN

UPDATE [Reporting_Report] SET 
        [ReportDisplayName] = 'Screen colors - Daily report', 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddMonths(-1).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" reftype="Required" visibility="none"><properties><defaultvalue>screencolor</defaultvalue></properties></field></form>', 
        [ReportConnectionString] = ''
    WHERE [ReportGUID] = '0aca6cd2-5adb-4a8c-9f11-7aa9d990401b'

UPDATE [Reporting_Report] SET 
        [ReportDisplayName] = 'Screen colors - Hourly report', 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddDays(-1)%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>True</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><controlname>calendarcontrol</controlname><DisplayNow>True</DisplayNow><EditTime>True</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" reftype="Required" visibility="none"><properties><defaultvalue>screencolor</defaultvalue></properties></field></form>', 
        [ReportConnectionString] = ''
    WHERE [ReportGUID] = '02a3cc26-2357-4cad-b2bc-493c99d434fe'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddYears(-1).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" reftype="Required" visibility="none"><properties><defaultvalue>screencolor</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = '3c75bfb6-06d3-4509-85ca-cb54d397f1ec'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddWeeks(-15).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" reftype="Required" visibility="none"><properties><defaultvalue>screencolor</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = 'c17c8152-b4bb-4c4f-ad99-80d03a55c276'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddYears(-6).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><controlname>calendarcontrol</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><controlname>calendarcontrol</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" reftype="Required" visibility="none"><properties><defaultvalue>screencolor</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = '2d7d5375-f401-4993-b60b-8f1fee424bd7'

END

SET @reportCategoryID = (SELECT TOP 1 [CategoryID] FROM [Reporting_ReportCategory] WHERE [CategoryGUID] = '4cf57600-fef9-4e51-8cdc-f2b07429607a')
IF @reportCategoryID IS NOT NULL BEGIN

UPDATE [Reporting_Report] SET 
        [ReportDisplayName] = 'Operating system - Daily report', 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddMonths(-1).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>operatingsystem</defaultvalue></properties></field></form>', 
        [ReportConnectionString] = ''
    WHERE [ReportGUID] = 'e7a8e1ce-d320-4814-a470-b5c5ca7d1ca0'

UPDATE [Reporting_Report] SET 
        [ReportDisplayName] = 'Operating system - Hourly report', 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddDays(-1)%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>True</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>True</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>operatingsystem</defaultvalue></properties></field></form>', 
        [ReportConnectionString] = ''
    WHERE [ReportGUID] = '3e1dd045-1dca-439a-b960-fec535974c17'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddYears(-1).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>operatingsystem</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = '2ad2d3af-0e74-4943-9cb5-9e6b873f8e0d'

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columnprecision="7" columntype="datetime" guid="3a2bc443-7e96-4929-8f85-d09e0d4e47d3" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddWeeks(-15).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columnprecision="7" columntype="datetime" guid="ed1cb074-89d2-4576-a6c8-f451121f5269" publicfield="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><CheckRange>True</CheckRange><controlname>CalendarControl</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="ac0084c9-b77f-4711-8bea-0465c2346d1d" publicfield="false" visibility="none"><properties><defaultvalue>operatingsystem</defaultvalue></properties></field></form>'
    WHERE [ReportGUID] = '582744dc-d9fa-4492-a63f-cfc9a87db8ba'

END

SET @reportCategoryID = (SELECT TOP 1 [CategoryID] FROM [Reporting_ReportCategory] WHERE [CategoryGUID] = '6e36495b-2934-4118-bc0b-2fab27305a51')
IF @reportCategoryID IS NOT NULL BEGIN

UPDATE [Reporting_Report] SET 
        [ReportParameters] = '<form version="2"><field column="FromDate" columntype="datetime" guid="c4fb5fa9-d4c9-4e2a-8729-5128296b5cd5" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddMonths(-1).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><controlname>calendarcontrol</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columntype="datetime" guid="a003a89e-90e2-4325-8c6f-ea227a01939b" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><controlname>calendarcontrol</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="65080419-ff4e-45db-bd16-947473425d6e" publicfield="false" reftype="Required" visibility="none"><properties><defaultvalue>exitpage</defaultvalue></properties><settings><controlname>dropdownlistcontrol</controlname><Query>SELECT DISTINCT StatisticsCode, StatisticsCode FROM Analytics_Statistics</Query></settings></field></form>'
    WHERE [ReportGUID] = 'b147a0d3-b309-4be8-b94d-77dd45a21288'

END

END
GO


-- HF9-58 Update to obtain campaigns by its UTM code instead of the code name
DECLARE @HOTFIXVERSION INT;
SET @HOTFIXVERSION = (SELECT [KeyValue] FROM [CMS_SettingsKey] WHERE [KeyName] = N'CMSHotfixVersion')
IF @HOTFIXVERSION < 1
BEGIN

DECLARE @tableReportID int;
SET @tableReportID = (SELECT TOP 1 [ReportID] FROM [Reporting_Report] WHERE [ReportGUID] = 'a4f498f3-bd0c-4470-bae1-1b9e07ed3e05')
IF @tableReportID IS NOT NULL BEGIN

UPDATE [Reporting_ReportTable] SET 
        [TableQuery] = 'SET @FromDate ={%DatabaseSchema%}.Func_Analytics_DateTrim(@FromDate,''day''); 
SET @ToDate ={%DatabaseSchema%}.Func_Analytics_EndDateTrim(@ToDate,''day''); 

IF (@ConversionName IS NULL OR @ConversionName = '''')
BEGIN

SELECT TOP 100 ConversionDisplayName AS ''{$reports_conversion.name_header$}'', SUM(HitsCount) AS
''{$reports_conversion.hits_header$}'',SUM(HitsValue) AS ''{$reports_conversion.value_header$}''  FROM
Analytics_Statistics 
JOIN Analytics_DayHits  ON HitsStatisticsID = StatisticsID
JOIN Analytics_Conversion ON ConversionName  = StatisticsObjectName AND ConversionSiteID = @CMSContextCurrentSiteID
WHERE (StatisticsSiteID = @CMSContextCurrentSiteID) AND
(StatisticsCode=N''conversion'') AND (StatisticsID = HitsStatisticsID) 
AND (@FromDate IS NULL OR @FromDate <= HitsStartTime) AND (@ToDate IS NULL OR @ToDate >= HitsStartTime)	
 GROUP BY ConversionDisplayName ORDER BY SUM(HitsCount) DESC
END

ELSE
BEGIN

SELECT
 ISNULL(CampaignDisplayName,''-'') AS ''{$campaign.campaign.list$}'',
 ISNULL(SUM(HitsCount),0) AS ''{$conversion.conversion.list$}'',
 ISNULL(SUM (HitsValue),0) AS ''{$conversions.value$}'',
 ISNULL(CAST (CAST (CAST (SUM(HitsCount) AS DECIMAL (15,2)) / Visits * 100 AS DECIMAL(15,1)) AS NVARCHAR(20))+''%'',''0.0%'') AS ''{$abtesting.conversionsrate$}'', 
 ISNULL(ROUND (SUM (HitsValue)  / NULLIF (Visits,0), 1),0) AS ''{$conversions.valuepervisit$}'',
 ISNULL(Visits,0) AS ''{$analytics_codename.visits$}''
 
FROM Analytics_Statistics JOIN Analytics_DayHits ON HitsStatisticsID = StatisticsID
LEFT JOIN 
(SELECT CampaignDisplayName,CampaignUTMCode,CampaignSiteID, SUM (HitsCount) AS Visits FROM Analytics_Campaign 
	LEFT JOIN Analytics_Statistics ON StatisticsCode = ''campaign'' AND StatisticsObjectName = CampaignUTMCode  AND CampaignSiteID = StatisticsSiteID 
	LEFT JOIN Analytics_DayHits ON HitsStatisticsID = StatisticsID
	WHERE CampaignSiteID = @CMSContextCurrentSiteID
	AND (@FromDate IS NULL OR @FromDate <= HitsStartTime) AND (@ToDate IS NULL OR @ToDate >= HitsStartTime)	
	GROUP BY CampaignDisplayName,CampaignUTMCode,CampaignSiteID)
 AS Campaigns 
ON Campaigns.CampaignUTMCode = SUBSTRING(StatisticsCode,16,LEN(StatisticsCode)) AND Campaigns.CampaignSiteID = StatisticsSiteID

WHERE StatisticsObjectName = @ConversionName AND StatisticsSiteID = @CMSContextCurrentSiteID AND 
(StatisticsCode=N''conversion'' OR StatisticsCode LIKE N''campconversion;%'')
AND (@FromDate IS NULL OR @FromDate <= HitsStartTime) AND (@ToDate IS NULL OR @ToDate >= HitsStartTime)	
GROUP BY CampaignDisplayName,Visits
ORDER BY SUM(HitsValue) DESC, CampaignDisplayName

END'
    WHERE [TableGUID] = 'f95992d3-ebeb-44c2-9b58-82a6523367ed'

END

END
GO

-- HF9-30 - Update webanalytics week country graph name and legend position
DECLARE @HOTFIXVERSION INT;
SET @HOTFIXVERSION = (SELECT [KeyValue] FROM [CMS_SettingsKey] WHERE [KeyName] = N'CMSHotfixVersion')
IF @HOTFIXVERSION < 1
BEGIN
	UPDATE [Reporting_ReportGraph] SET 
        [GraphDisplayName] = 'graph',
		[GraphSettings] = '<customdata><displayitemvalue>True</displayitemvalue><legendtitle></legendtitle><yaxistitleposition>Center</yaxistitleposition><xaxislabelfont></xaxislabelfont><yaxislabelfont></yaxislabelfont><itemvalueformat>#PERCENT{P1} (#VALY)</itemvalueformat><seriessecbgcolor></seriessecbgcolor><legendbgcolor></legendbgcolor><xaxisinterval>1</xaxisinterval><xaxissort>True</xaxissort><yaxisusexaxissettings>True</yaxisusexaxissettings><reverseyaxis>False</reverseyaxis><legendposition>Right</legendposition><seriesitemlink></seriesitemlink><pieothervalue></pieothervalue><xaxisfont></xaxisfont><xaxistitleposition>Center</xaxistitleposition><xaxisformat></xaxisformat><yaxisfont></yaxisfont><querynorecordtext>No data found</querynorecordtext><plotareasecbgcolor></plotareasecbgcolor><seriesitemtooltip>#VALX  -   #PERCENT{P1}</seriesitemtooltip><rotatey></rotatey><stackedbarmaxstacked>False</stackedbarmaxstacked><scalemax></scalemax><titlefontnew></titlefontnew><exportenabled>True</exportenabled><subscriptionenabled>True</subscriptionenabled><plotareagradient>None</plotareagradient><titleposition>Center</titleposition><seriesgradient>None</seriesgradient><showmajorgrid>True</showmajorgrid><seriesprbgcolor></seriesprbgcolor><yaxisformat></yaxisformat><linedrawinstyle>Line</linedrawinstyle><tenpowers>False</tenpowers><plotareaprbgcolor></plotareaprbgcolor><valuesaspercent>False</valuesaspercent><rotatex></rotatex><legendinside>False</legendinside><xaxisangle></xaxisangle><showas3d>False</showas3d><baroverlay>False</baroverlay><yaxisangle></yaxisangle><scalemin></scalemin><barorientation>Vertical</barorientation></customdata>'
    WHERE [GraphGUID] = '263b6ed4-27fb-4626-a275-59d850b5ee9f'
END
GO

-- HF9-67 - DocumentNamePath inconsistency after recreating different
DECLARE @HOTFIXVERSION INT;
SET @HOTFIXVERSION = (SELECT [KeyValue] FROM [CMS_SettingsKey] WHERE [KeyName] = N'CMSHotfixVersion')
IF @HOTFIXVERSION < 2
BEGIN
	declare @alterScript NVARCHAR(MAX)
	select @alterScript =
'ALTER PROCEDURE [dbo].[Proc_CMS_Document_UpdateDocumentNamePath]
	 @NodeID int,
	 @DocumentID int,
	 @PrefixesXML nvarchar(max),
	 @DefaultCultureCode nvarchar(10),
	 @UpdateUrlPath bit,
	 @GenerateAliases bit,
	 @CurrentDate datetime2(7)
	AS
	BEGIN

	-- Get XML from the string representation
	DECLARE @Prefixes xml = CAST(@PrefixesXML as XML);

	-- Prepare temp table for the results
	DECLARE @Documents TABLE
	(
	  NodeID int, 
	  DocumentID int, 
	  OriginalNamePrefix nvarchar(1500), 
	  NamePrefix nvarchar(1500), 
	  OriginalUrlPrefix nvarchar(450), 
	  UrlPrefix nvarchar(450)
	);

	WITH 
	Prefixes AS
	(
		SELECT 
			ref.value(''Culture[1]'', ''nvarchar(10)'') AS DocumentCulture, 
			ref.value(''(NamePath/Original)[1]'', ''nvarchar(1500)'') AS OriginalNamePrefix, 
			ref.value(''(NamePath/Current)[1]'', ''nvarchar(1500)'') AS NamePrefix, 
			ref.value(''(UrlPath/Original)[1]'', ''nvarchar(450)'') AS OriginalUrlPrefix, 
			ref.value(''(UrlPath/Current)[1]'', ''nvarchar(450)'') AS UrlPrefix 
		FROM @Prefixes.nodes(''/Prefixes/Prefix'') xmlData(ref)
	),
	Base AS
	(
		SELECT DocumentID, NodeID, NodeLinkedNodeID, TopDocumentCulture, OriginalNamePrefix, NamePrefix, OriginalUrlPrefix, UrlPrefix 
		FROM
		(
			SELECT 
				V.DocumentID, V.NodeID, V.NodeLinkedNodeID,
				V.DocumentCulture AS TopDocumentCulture,
				OriginalNamePrefix, NamePrefix, OriginalUrlPrefix, UrlPrefix,
				-- Prefer parent data in culture of the document, than in default culture, any other culture at least 
				ROW_NUMBER() OVER (PARTITION BY V.DocumentID, V.NodeID ORDER BY CASE WHEN P.DocumentCulture = V.DocumentCulture THEN 1 WHEN P.DocumentCulture = @DefaultCultureCode THEN 2 ELSE 3 END, P.DocumentCulture) AS CMS_C
	 		FROM View_CMS_Tree_Joined AS V WITH (NOLOCK)
					-- Get original and current prefix
					INNER JOIN Prefixes ON V.DocumentCulture = Prefixes.DocumentCulture
					-- Get parent values
					INNER JOIN View_CMS_Tree_Joined as P WITH (NOLOCK) ON (SELECT NodeParentID FROM CMS_Tree AS T WITH (NOLOCK) WHERE T.NodeID = V.NodeOriginalNodeID) = P.NodeID
			-- Get either all culture versions or just the one based on DocumentID
			WHERE (@NodeID <> 0 AND V.NodeOriginalNodeID = @NodeID) OR (@DocumentID <> 0 AND V.DocumentID = @DocumentID)
		) AS B
		-- Get data with best matching parent data
		WHERE CMS_C = 1
	),
	Candidates AS
	(
		SELECT * FROM Base

		UNION ALL

		SELECT DocumentID, NodeID, NodeLinkedNodeID, TopDocumentCulture, OriginalNamePrefix, NamePrefix, OriginalUrlPrefix, UrlPrefix FROM
		(
			SELECT 
				V.DocumentID, V.NodeID, V.NodeLinkedNodeID, 
				Candidates.TopDocumentCulture, Candidates.DocumentID AS CandidatesParentDocumentID,
				P.DocumentID AS ParentDocumentID,
				Prefixes.OriginalNamePrefix, Prefixes.NamePrefix, Prefixes.OriginalUrlPrefix, Prefixes.UrlPrefix,
				-- Prefer parent data in culture of the document, than in default culture, any other culture at least 
				ROW_NUMBER() OVER (PARTITION BY V.DocumentID, V.NodeID ORDER BY CASE WHEN P.DocumentCulture = V.DocumentCulture THEN 1 WHEN P.DocumentCulture = @DefaultCultureCode THEN 2 ELSE 3 END, P.DocumentCulture) AS CMS_C
			FROM Candidates
				-- Get original and current prefix
				INNER JOIN Prefixes ON Candidates.TopDocumentCulture = Prefixes.DocumentCulture
				-- Get all child documents (for links get the originals) of the current one having the original prefix
				INNER JOIN View_CMS_Tree_Joined V WITH (NOLOCK) ON (SELECT NodeParentID FROM CMS_Tree AS T WHERE T.NodeID = V.NodeOriginalNodeID) = Candidates.NodeID AND V.DocumentNamePath LIKE Prefixes.OriginalNamePrefix + ''%''
				-- Get all combinations with their parents
				INNER JOIN View_CMS_Tree_Joined as P WITH (NOLOCK) ON (SELECT NodeParentID FROM CMS_Tree AS T WHERE T.NodeID = V.NodeOriginalNodeID) = P.NodeID
		) AS LevelCandidates
		-- Include only those whose primary parents are included in the current scope
		WHERE CandidatesParentDocumentID = ParentDocumentID AND LevelCandidates.CMS_C = 1 AND LevelCandidates.DocumentID NOT IN (SELECT DocumentID FROM Base)
	),
	Items AS
	(
		-- Filter links since the originals are incldued as well
		SELECT DISTINCT NodeID, DocumentID, OriginalNamePrefix, NamePrefix, OriginalUrlPrefix, UrlPrefix 
		FROM Candidates
		WHERE NodeLinkedNodeID IS NULL
	)

	-- Get the final result set
	INSERT INTO @Documents SELECT NodeID, DocumentID, OriginalNamePrefix, NamePrefix, OriginalUrlPrefix, UrlPrefix FROM Items

	-- Generate document aliases
	IF (@UpdateUrlPath = 1 AND @GenerateAliases = 1)
	BEGIN
		-- Insert alias for all child documents where original URL path differs from the new one and the alias with same URL path doesn''t exist
		INSERT INTO CMS_DocumentAlias 
		(
			AliasNodeID, 
			AliasCulture, 
			AliasURLPath, 
			AliasExtensions, 
			AliasWildcardRule, 
			AliasPriority, 
			AliasGUID, 
			AliasLastModified, 
			AliasSiteID
		)
		SELECT 
			D.NodeID AS AliasNodeID, 
			DocumentCulture AS AliasCulture, 
			DocumentURLPath AS AliasURLPath, 
			'''' AS AliasExtensions, 
			'''' AS AliasWildcardRule, 
			1 AS AliasPriority, 
			NEWID() AS AliasGUID, 
			@CurrentDate AS AliasLastModified, 
			NodeSiteID AS AliasSiteID
		FROM @Documents AS D INNER JOIN View_CMS_Tree_Joined AS V ON D.DocumentID = V.DocumentID
		WHERE 
			-- Aliases were already generated for updated culture version
			-- Do not include links since the aliases are same as for originals included in the results
			D.DocumentID <> @DocumentID  AND NodeLinkedNodeID IS NULL
			-- Do not generate aliases for content-only pages
			AND NodeIsContentOnly = 0
			-- URL path is generated and differs from the original one
			AND DocumentUrlPath <> 
				(
				CASE WHEN DocumentUseNamePathForUrlPath = 1 AND (ISNULL(DocumentUrlPath, '''') <> '''')
				THEN
					-- Path starts with original URL path prefix
					CASE WHEN LEFT(DocumentUrlPath, LEN(OriginalUrlPrefix)) = OriginalUrlPrefix 
					THEN
						-- Replace original URL prefix with new URL path prefix
						UrlPrefix + SUBSTRING(DocumentUrlPath, LEN(OriginalUrlPrefix) + 1, LEN(DocumentUrlPath)) 
					-- Path starts with original name path prefix
					WHEN LEFT(DocumentUrlPath, LEN(OriginalNamePrefix)) = OriginalNamePrefix 
					THEN
						-- Replace original Name prefix with new URL path prefix (when new document is created, DocumentNamePath of the parent is used to build the URL path)
						UrlPrefix + SUBSTRING(DocumentUrlPath, LEN(OriginalNamePrefix) + 1, LEN(DocumentUrlPath)) 
					ELSE
						DocumentUrlPath
					END
			  	ELSE DocumentUrlPath END
				)
			-- There is no alias with the same URL path
			AND NOT EXISTS (SELECT AliasID FROM CMS_DocumentAlias WHERE AliasURLPath = DocumentUrlPath AND AliasNodeID = D.NodeID AND (AliasCulture = DocumentCulture OR ISNULL(AliasCulture, '''') = ''''))
	END

	-- Propagate new prefixes to all child documents
	-- Currently modified document is not udpated since the paths were already udpated by API
	UPDATE CMS_Document SET
	DocumentNamePath = 
		(
		-- Path starts with original name prefix
		CASE WHEN LEFT(DocumentNamePath, LEN(OriginalNamePrefix)) = OriginalNamePrefix
		THEN
			NamePrefix + SUBSTRING(DocumentNamePath, LEN(OriginalNamePrefix) + 1, LEN(DocumentNamePath))
		ELSE DocumentNamePath END
		),
	DocumentUrlPath = 
		(
		CASE WHEN @UpdateUrlPath = 1 AND DocumentUseNamePathForUrlPath = 1 AND (ISNULL(DocumentUrlPath, '''') <> '''')
		THEN
			-- Path starts with original URL path prefix
			CASE WHEN LEFT(DocumentUrlPath, LEN(OriginalUrlPrefix)) = OriginalUrlPrefix 
			THEN
				-- Replace original URL prefix with new URL path prefix
				UrlPrefix + SUBSTRING(DocumentUrlPath, LEN(OriginalUrlPrefix) + 1, LEN(DocumentUrlPath)) 
			-- Path starts with original name path prefix
			WHEN LEFT(DocumentUrlPath, LEN(OriginalNamePrefix)) = OriginalNamePrefix 
			THEN
				-- Replace original Name prefix with new URL path prefix (when new document is created, DocumentNamePath of the parent is used to build the URL path)
				UrlPrefix + SUBSTRING(DocumentUrlPath, LEN(OriginalNamePrefix) + 1, LEN(DocumentUrlPath)) 
			ELSE
				DocumentUrlPath
			END
		ELSE DocumentUrlPath END
		)
    FROM CMS_Document AS D INNER JOIN @Documents AS R ON D.DocumentID = R.DocumentID
	WHERE R.DocumentID <> @DocumentID

	END';

	exec(@alterScript)
END
GO


-- HF9-73 - Hide A/B test field when license is lower than EMS
DECLARE @HOTFIXVERSION INT;
SET @HOTFIXVERSION = (SELECT [KeyValue] FROM [CMS_SettingsKey] WHERE [KeyName] = N'CMSHotfixVersion')
IF @HOTFIXVERSION < 2
BEGIN

UPDATE [CMS_AlternativeForm]
  SET [FormDefinition] = '<form version="2"><field column="IssueID" isunique="true" visible="" /><field column="IssueVariantName" order="1"><settings><controlname>LabelControl</controlname><Transformation>#htmlencode</Transformation></settings><properties><fieldcaption>{$general.name$}</fieldcaption><visiblemacro ismacro="true">{%!String.IsNullOrEmpty(Value)%}</visiblemacro></properties></field><field column="IssueSubject" order="2"><settings><controlname>LabelControl</controlname><Transformation>#htmlencode</Transformation></settings><properties><fieldcaption>{$general.subject$}</fieldcaption></properties></field><field column="IssueStatus" columnprecision="" columnsize="" order="3"><settings><controlname>LabelControl</controlname><OutputFormat>{% GetResourceString("newsletterissuestatus." + ToStringRepresentation(Value, "CMS.Newsletters", "CMS.Newsletters.IssueStatusEnum"))%}</OutputFormat></settings><properties><fieldcaption>{$general.status$}</fieldcaption></properties></field><field column="IssueMailoutTime" order="4"><settings><controlname>LabelControl</controlname></settings><properties><fieldcaption>{$unigrid.newsletter_issue.columns.issuemailouttime$}</fieldcaption></properties></field><field column="IssueIsABTest" reftype="Required" order="5"><settings><controlname>LabelControl</controlname><Transformation>#yesno</Transformation></settings><properties><fieldcaption>{$newsletters.isabtest$}</fieldcaption><visiblemacro ismacro="true">{%LicenseHelper.CheckFeature(FeatureEnum.CampaignAndConversions)%}</visiblemacro></properties></field><field column="IssueSenderName" order="6"><settings><controlname>LabelControl</controlname><Transformation>#htmlencode</Transformation></settings><properties><fieldcaption>{$newsletterissue.sender.name$}</fieldcaption></properties></field><field column="IssueSenderEmail" order="7"><settings><controlname>LabelControl</controlname><Transformation>#htmlencode</Transformation></settings><properties><fieldcaption>{$newsletterissue.sender.email$}</fieldcaption></properties></field><field column="IssueUTMSource" order="8"><settings><controlname>LabelControl</controlname><Transformation>#htmlencode</Transformation></settings><properties><fieldcaption>{$newsletterissue.utm.source$}</fieldcaption><visiblemacro ismacro="true">{%IssueUseUTM%}</visiblemacro></properties></field><field allowempty="true" column="IssueUTMMedium" columnsize="200" columntype="text" dummy="altform" guid="1a0ce2e0-9178-4aa8-af6f-bf3e9d9243db" publicfield="false" system="true" visible="true" order="9"><properties><defaultvalue>email</defaultvalue><fieldcaption>{$newsletterissue.utm.medium$}</fieldcaption><visiblemacro ismacro="true">{%IssueUseUTM%}</visiblemacro></properties><settings><controlname>LabelControl</controlname><Transformation>#htmlencode</Transformation></settings></field><field column="IssueUTMCampaign" order="10"><settings><controlname>LabelControl</controlname></settings><properties><fieldcaption>{$newsletterissue.utm.campaign$}</fieldcaption><visiblemacro ismacro="true">{%IssueUseUTM%}</visiblemacro></properties></field><field column="IssueText" visible="" order="11" /><field column="IssueUnsubscribed" visible="" order="12" /><field column="IssueNewsletterID" visible="" order="13" /><field column="IssueTemplateID" visible="" order="14" /><field column="IssueSentEmails" visible="" order="15" /><field column="IssueShowInNewsletterArchive" visible="" order="16" /><field column="IssueGUID" visible="" order="17"><settings><controlname>UploadControl</controlname><Extensions>inherit</Extensions></settings></field><field column="IssueLastModified" visible="" order="18" /><field column="IssueSiteID" visible="" order="19" /><field column="IssueOpenedEmails" visible="" order="20" /><field column="IssueBounces" visible="" order="21" /><field column="IssueVariantOfIssueID" visible="" order="22" /><field column="IssueScheduledTaskID" visible="" order="23" /><field column="IssueUseUTM" visible="" order="24"><properties><defaultvalue>False</defaultvalue></properties></field></form>'
  WHERE [FormGUID] = '34AD0618-4CD7-44C0-8D57-AB32EDEC95A9'

END
GO


-- HF9-76 - Top landing pages - Weekly report is showing wrong data (for page views)
DECLARE @HOTFIXVERSION INT;
SET @HOTFIXVERSION = (SELECT [KeyValue] FROM [CMS_SettingsKey] WHERE [KeyName] = N'CMSHotfixVersion')
IF @HOTFIXVERSION < 2
BEGIN
	UPDATE [Reporting_Report]
	SET [ReportParameters] = '<form version="2"><field column="FromDate" columntype="datetime" guid="adf581b8-eec1-46ad-ba0a-f7290add200a" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime.AddWeeks(-15).Date%}</defaultvalue><fieldcaption>{$general.from$}</fieldcaption></properties><settings><controlname>calendarcontrol</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="ToDate" columntype="datetime" guid="70aa642a-6385-4739-8a7b-e5d9e15d2df4" publicfield="false" spellcheck="false" visibility="none" visible="true"><properties><defaultvalue ismacro="true">{%CurrentDateTime%}</defaultvalue><fieldcaption>{$general.to$}</fieldcaption></properties><settings><controlname>calendarcontrol</controlname><DisplayNow>True</DisplayNow><EditTime>False</EditTime><TimeZoneType>inherit</TimeZoneType></settings></field><field column="CodeName" columnsize="50" columntype="text" guid="00000000-0000-0000-0000-000000000000" publicfield="false" reftype="Required" spellcheck="false"><properties><defaultvalue>landingpage</defaultvalue><fieldcaption>Code Name</fieldcaption></properties><settings><controlname>dropdownlistcontrol</controlname><query>SELECT DISTINCT StatisticsCode, StatisticsCode FROM Analytics_Statistics</query></settings></field></form>'
	WHERE [ReportGUID] = '5B4C69DC-5A1E-4FAF-9A65-81F2FF5714FB'
END
GO


-- HF9-92 - remove analytics page in Pages application when campaign module is not available
DECLARE @HOTFIXVERSION INT;
SET @HOTFIXVERSION = (SELECT [KeyValue] FROM [CMS_SettingsKey] WHERE [KeyName] = N'CMSHotfixVersion')
IF @HOTFIXVERSION < 3
BEGIN
	UPDATE [CMS_UIElement] SET 
			[ElementDescription] = NULL, 
			[ElementFeature] = 'WebAnalytics', 
			[ElementIconClass] = '', 
			[ElementVisibilityCondition] = '{%System.IsModuleLoaded("CMS.WebAnalytics")%}'
	WHERE [ElementGUID] = 'f6413e96-fb74-40fa-bd7d-d987eee2ac3a'

	UPDATE [CMS_UIElement] SET 
			[ElementDescription] = NULL, 
			[ElementFeature] = 'CampaignAndConversions', 
			[ElementIconClass] = '', 
			[ElementVisibilityCondition] = '{%System.IsModuleLoaded("CMS.WebAnalytics")%}'
	WHERE [ElementGUID] = '993d8225-c9e9-48cd-ba70-d996d43155da'
END
GO


-- HF9-114 - "Check bounced emails" task doesn't update its status if external scheduler is used
DECLARE @HOTFIXVERSION INT;
SET @HOTFIXVERSION = (SELECT [KeyValue] FROM [CMS_SettingsKey] WHERE [KeyName] = N'CMSHotfixVersion')
IF @HOTFIXVERSION < 5
BEGIN
	UPDATE [CMS_ScheduledTask] SET 
			[TaskUseExternalService] = 0 
	WHERE [TaskClass] = 'CMS.Newsletters.BounceChecker'
END
GO
/* ----------------------------------------------------------------------------*/
/* This SQL command must be at the end and must contain current hotfix version */
/* ----------------------------------------------------------------------------*/
UPDATE [CMS_SettingsKey] SET KeyValue = '9' WHERE KeyName = N'CMSHotfixVersion'
GO
