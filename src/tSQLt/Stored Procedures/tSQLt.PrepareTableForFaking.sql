--liquibase formatted sql

--changeSet proc:Initial-tSQLt-PrepareTableForFaking-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.PrepareTableForFaking', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[PrepareTableForFaking] @TableName nvarchar(MAX),@SchemaName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-PrepareTableForFaking-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[PrepareTableForFaking]
        @TableName NVARCHAR(MAX),
        @SchemaName NVARCHAR(MAX)
AS
BEGIN
 
  --remove brackets
  select @TableName = (REPLACE(REPLACE(@TableName, '[', ''), ']', ''));
  select @SchemaName = (REPLACE(REPLACE(@SchemaName, '[', ''), ']', ''));
 
-- delete temptable
  IF EXISTS(SELECT * FROM tempdb..sysobjects WHERE id = OBJECT_ID('tempdb.dbo.#temp'))
    DROP TABLE #TEMP
 
  --recursively get all referencing dependencies
;WITH ReferencedDependencies (parentId, name, LEVEL)
  AS(
      SELECT DISTINCT o.object_id AS parentId, o.name, 0 AS LEVEL
        FROM sys.sql_expression_dependencies AS d
        JOIN sys.objects AS o
          ON d.referencing_id = o.object_id
            AND o.type IN ('FN','IF','TF', 'V', 'P')
            AND is_schema_bound_reference = 1
        WHERE
          d.referencing_class = 1 AND referenced_entity_name = @TableName AND referenced_schema_name = @SchemaName
      UNION ALL
      SELECT o.object_id AS parentId, o.name, LEVEL +1
        FROM sys.sql_expression_dependencies AS d
        JOIN sys.objects AS o
                ON d.referencing_id = o.object_id
            AND o.type IN ('FN','IF','TF', 'V', 'P')
            AND is_schema_bound_reference = 1
        JOIN ReferencedDependencies AS RD
                ON d.referenced_id = rd.parentId
  )
 
  -- select all objects referencing this table in reverse level order
  SELECT DISTINCT IDENTITY(INT, 1,1) AS id, name, OBJECT_DEFINITION(parentId) as obj_def, parentId as obj_Id , LEVEL
  INTO #TEMP
  FROM ReferencedDependencies
  WHERE OBJECT_DEFINITION(parentId) LIKE '%SCHEMABINDING%'
  ORDER BY LEVEL DESC
  OPTION (Maxrecursion 1000);
 
  --prepere the query to remove all dependent indexes (this is nessesary to removing (with schemabinding) later)
  DECLARE @qryRemoveIndexes NVARCHAR(MAX);
  SELECT @qryRemoveIndexes = (
  SELECT 'DROP INDEX ' + i.name + ' ON ' + OBJECT_SCHEMA_NAME (o.id) +'.' + OBJECT_NAME(o.id) + '; ' FROM sys.sysobjects AS o
  INNER JOIN #TEMP ON o.id = #TEMP.obj_Id
  INNER JOIN sys.sysindexes AS i ON i.id = o.id
  where i.indid = 1 -- 1 = Clustered index (we are only interested in clusterd indexes)
  FOR XML PATH(''));
  --excute @qryRemoveIndexes
  exec sp_executesql @qryRemoveIndexes;
 
  --change the definition for removing (with schemabinding) from those objects
  DECLARE @currentRecord INT
  DECLARE @qryRemoveWithSchemabinding NVARCHAR(MAX)
  SET @currentRecord = 1
  WHILE (@currentRecord <= (SELECT COUNT(1) FROM #TEMP) )
  BEGIN
          SET @qryRemoveWithSchemabinding = ''
          SELECT @qryRemoveWithSchemabinding = #TEMP.obj_def
            FROM #TEMP
            WHERE #TEMP.id = @currentRecord
          SET @qryRemoveWithSchemabinding = REPLACE(@qryRemoveWithSchemabinding,'CREATE', 'ALTER')
          SET @qryRemoveWithSchemabinding = REPLACE(@qryRemoveWithSchemabinding,'with schemabinding', ''); -- remove schema binding
          --excute @qryRemoveWithSchemabinding
          EXEC sp_executeSQL @qryRemoveWithSchemabinding;
          SET @currentRecord = @currentRecord + 1
  END
 
END
GO