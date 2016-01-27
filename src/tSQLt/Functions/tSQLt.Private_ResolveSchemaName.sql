--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_ResolveSchemaName-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_ResolveSchemaName', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_ResolveSchemaName](@Name nvarchar(MAX)) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_ResolveSchemaName-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_ResolveSchemaName](@Name NVARCHAR(MAX))
RETURNS TABLE 
AS
RETURN
  WITH ids(schemaId) AS
       (SELECT tSQLt.Private_GetSchemaId(@Name)
       ),
       idsWithNames(schemaId, quotedSchemaName) AS
        (SELECT schemaId,
         QUOTENAME(SCHEMA_NAME(schemaId))
         FROM ids
        )
  SELECT schemaId, 
         quotedSchemaName,
         CASE WHEN EXISTS(SELECT 1 FROM tSQLt.TestClasses WHERE TestClasses.SchemaId = idsWithNames.schemaId)
               THEN 1
              ELSE 0
         END AS isTestClass, 
         CASE WHEN schemaId IS NOT NULL THEN 1 ELSE 0 END AS isSchema
    FROM idsWithNames;
GO