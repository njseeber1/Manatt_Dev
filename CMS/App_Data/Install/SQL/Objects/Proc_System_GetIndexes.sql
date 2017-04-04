SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE Proc_System_GetIndexes
(
    @Table			   nvarchar(200) = NULL,
    @Column			   nvarchar(200) = NULL
)
AS
BEGIN
	DECLARE @Indexes TABLE
	(
		IndexName nvarchar(450),
		DropScript nvarchar(max),
		CreateScript nvarchar(max)
	)

    -- Get all existing indexes, but NOT the primary keys
    DECLARE Indexes_cursor CURSOR
        FOR SELECT SC.Name          AS      SchemaName,
                   SO.Name          AS      TableName,
                   SI.OBJECT_ID     AS      TableId,
                   SI.[Name]         AS  IndexName,
                   SI.Index_ID       AS  IndexId
              FROM sys.indexes SI
              INNER JOIN sys.objects SO
                      ON SI.OBJECT_ID = SO.OBJECT_ID
              INNER JOIN sys.schemas SC
                      ON SC.schema_id = SO.schema_id
             WHERE (SO.[type] = 'U' OR SO.[type] = 'V')			
			   AND SI.[Name] IS NOT NULL
               AND SI.is_primary_key = 0
               AND SI.is_unique_constraint = 0
               AND INDEXPROPERTY(SI.OBJECT_ID, SI.[Name], 'IsStatistics') = 0
			   AND (@Table IS NULL OR SO.Name = @Table)
             ORDER BY OBJECT_NAME(SI.OBJECT_ID), SI.Index_ID

    DECLARE @SchemaName     sysname
    DECLARE @TableName      sysname
    DECLARE @TableId        int
    DECLARE @IndexName      sysname
    DECLARE @IndexId        int

    DECLARE @NewLine nvarchar(4000)
    SET @NewLine = char(13) + char(10)
    DECLARE @Tab  nvarchar(4000)
    SET @Tab = SPACE(4)

    -- Loop through all indexes
    OPEN Indexes_cursor

    FETCH NEXT
     FROM Indexes_cursor
     INTO @SchemaName, @TableName, @TableId, @IndexName, @IndexId

    WHILE (@@FETCH_STATUS = 0)
        BEGIN
			IF EXISTS (
				SELECT SC.[Name] FROM sys.index_columns IC
					INNER JOIN sys.columns SC
						ON IC.OBJECT_ID = SC.OBJECT_ID
							AND IC.Column_ID = SC.Column_ID
					WHERE IC.OBJECT_ID = @TableId
						AND Index_ID = @IndexId
						AND (@Column IS NULL OR SC.[Name] = @Column)
				)
			BEGIN

				DECLARE @sIndexDesc nvarchar(4000)
				DECLARE @sCreateSql nvarchar(4000)
				DECLARE @sDropSql           nvarchar(4000)

				SET @sIndexDesc = '-- Index ' + @IndexName + ' on table ' + @TableName
				SET @sDropSql = 'IF EXISTS(SELECT 1' + @NewLine
							  + '            FROM sysindexes si' + @NewLine
							  + '            INNER JOIN sysobjects so' + @NewLine
							  + '                   ON so.id = si.id' + @NewLine
							  + '           WHERE si.[Name] = N''' + @IndexName + ''' -- Index Name' + @NewLine
							  + '             AND so.[Name] = N''' + @TableName + ''')  -- Table Name' + @NewLine
							  + 'BEGIN' + @NewLine
							  + '    DROP INDEX [' + @IndexName + '] ON [' + @SchemaName + '].[' + @TableName + ']' + @NewLine
							  + 'END' + @NewLine

				SET @sCreateSql =  CAST('CREATE ' AS nvarchar(max))

				-- Check if the index is unique
				IF (IndexProperty(@TableId, @IndexName, 'IsUnique') = 1)
					BEGIN
						SET @sCreateSql = @sCreateSql + 'UNIQUE '
					END
				--END IF
				-- Check if the index is clustered
				IF (IndexProperty(@TableId, @IndexName, 'IsClustered') = 1)
					BEGIN
						SET @sCreateSql = @sCreateSql + 'CLUSTERED '
					END
				--END IF

				SET @sCreateSql = @sCreateSql + 'INDEX [' + @IndexName + '] ON [' + @SchemaName + '].[' + @TableName + ']' + @NewLine + '(' + @NewLine

				-- Get all columns of the index
				DECLARE IndexColumns_cursor CURSOR
					FOR SELECT SC.[Name],
							   IC.[is_included_column],
							   IC.is_descending_key
						  FROM sys.index_columns IC
						 INNER JOIN sys.columns SC
								 ON IC.OBJECT_ID = SC.OBJECT_ID
								AND IC.Column_ID = SC.Column_ID
						 WHERE IC.OBJECT_ID = @TableId
						   AND Index_ID = @IndexId
						 ORDER BY IC.[is_included_column],
								  IC.key_ordinal

				DECLARE @IxColumn      sysname
				DECLARE @IxIncl        bit
				DECLARE @Desc          bit
				DECLARE @IxIsIncl      bit
				SET @IxIsIncl = 0
				DECLARE @IxFirstColumn   bit
				SET @IxFirstColumn = 1

				-- Loop through all columns of the index and append them to the CREATE statement
				OPEN IndexColumns_cursor
				FETCH NEXT
				 FROM IndexColumns_cursor
				 INTO @IxColumn, @IxIncl, @Desc

				WHILE (@@FETCH_STATUS = 0)
					BEGIN
						IF (@IxFirstColumn = 1)
							BEGIN
								SET @IxFirstColumn = 0
							END
						ELSE
							BEGIN
								--check to see if it's an included column
								IF (@IxIsIncl = 0) AND (@IxIncl = 1)
									BEGIN
										SET @IxIsIncl = 1
										SET @sCreateSql = @sCreateSql + @NewLine + ')' + @NewLine + 'INCLUDE' + @NewLine + '(' + @NewLine
									END
								ELSE
									BEGIN
										SET @sCreateSql = @sCreateSql + ',' + @NewLine
									END
								--END IF
							END
						--END IF

						SET @sCreateSql = @sCreateSql + @Tab + '[' + @IxColumn + ']'
						-- check if ASC or DESC
						IF @IxIsIncl = 0
							BEGIN
								IF @Desc = 1
									BEGIN
										SET @sCreateSql = @sCreateSql + ' DESC'
									END
								ELSE
									BEGIN
										SET @sCreateSql = @sCreateSql + ' ASC'
									END
								--END IF
							END
						--END IF
						FETCH NEXT
						 FROM IndexColumns_cursor
						 INTO @IxColumn, @IxIncl, @Desc
					END
				--END WHILE
				CLOSE IndexColumns_cursor
				DEALLOCATE IndexColumns_cursor

				SET @sCreateSql = @sCreateSql + @NewLine + ') '
	
				SET @sCreateSql = @sCreateSql + 'ON [PRIMARY]' + @NewLine
							
				INSERT INTO @Indexes VALUES (@IndexName, @sDropSql, @sCreateSql)
			END

			FETCH NEXT
				 FROM Indexes_cursor
				 INTO @SchemaName, @TableName, @TableId, @IndexName, @IndexId
        END
    --END WHILE
    CLOSE Indexes_cursor
    DEALLOCATE Indexes_cursor

	SELECT * FROM @Indexes
END


GO
