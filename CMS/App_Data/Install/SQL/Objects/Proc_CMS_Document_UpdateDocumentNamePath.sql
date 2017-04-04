SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Proc_CMS_Document_UpdateDocumentNamePath]
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
			ref.value('Culture[1]', 'nvarchar(10)') AS DocumentCulture, 
			ref.value('(NamePath/Original)[1]', 'nvarchar(1500)') AS OriginalNamePrefix, 
			ref.value('(NamePath/Current)[1]', 'nvarchar(1500)') AS NamePrefix, 
			ref.value('(UrlPath/Original)[1]', 'nvarchar(450)') AS OriginalUrlPrefix, 
			ref.value('(UrlPath/Current)[1]', 'nvarchar(450)') AS UrlPrefix 
		FROM @Prefixes.nodes('/Prefixes/Prefix') xmlData(ref)
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
				INNER JOIN View_CMS_Tree_Joined V WITH (NOLOCK) ON (SELECT NodeParentID FROM CMS_Tree AS T WHERE T.NodeID = V.NodeOriginalNodeID) = Candidates.NodeID AND V.DocumentNamePath LIKE Prefixes.OriginalNamePrefix + '%'
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
		-- Insert alias for all child documents where original URL path differs from the new one and the alias with same URL path doesn't exist
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
			'' AS AliasExtensions, 
			'' AS AliasWildcardRule, 
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
				CASE WHEN DocumentUseNamePathForUrlPath = 1 AND (ISNULL(DocumentUrlPath, '') <> '')
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
			AND NOT EXISTS (SELECT AliasID FROM CMS_DocumentAlias WHERE AliasURLPath = DocumentUrlPath AND AliasNodeID = D.NodeID AND (AliasCulture = DocumentCulture OR ISNULL(AliasCulture, '') = ''))
	END

	-- Propagate new prefixes to all child documents
	-- Currently modified document is not udpated since the paths were already udpated by API
	UPDATE CMS_Document SET
	DocumentNamePath = NamePrefix + SUBSTRING(DocumentNamePath, LEN(OriginalNamePrefix) + 1, LEN(DocumentNamePath)),
	DocumentUrlPath  = 
		(
		CASE WHEN DocumentUseNamePathForUrlPath = 1 AND (ISNULL(DocumentUrlPath, '') <> '')
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

	END


GO
