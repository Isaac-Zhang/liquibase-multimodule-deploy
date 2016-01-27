--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_ResolveFakeTableNamesForBackwardCompatibility-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_ResolveFakeTableNamesForBackwardCompatibility', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_ResolveFakeTableNamesForBackwardCompatibility](@TableName nvarchar(MAX),@SchemaName nvarchar(MAX)) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_ResolveFakeTableNamesForBackwardCompatibility-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_ResolveFakeTableNamesForBackwardCompatibility] 
 (@TableName NVARCHAR(MAX), @SchemaName NVARCHAR(MAX))
RETURNS TABLE AS 
RETURN
  SELECT QUOTENAME(OBJECT_SCHEMA_NAME(object_id)) AS CleanSchemaName,
         QUOTENAME(OBJECT_NAME(object_id)) AS CleanTableName
     FROM (SELECT CASE
                    WHEN @SchemaName IS NULL THEN OBJECT_ID(@TableName)
                    ELSE COALESCE(OBJECT_ID(@SchemaName + '.' + @TableName),OBJECT_ID(@TableName + '.' + @SchemaName)) 
                  END object_id
          ) ids;
GO