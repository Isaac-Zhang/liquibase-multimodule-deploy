--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetSchemaId-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetSchemaId', 'FN') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetSchemaId](@SchemaName nvarchar(MAX)) RETURNS int AS BEGIN RETURN 1 END')
GO



--changeSet func:Initial-tSQLt-Private_GetSchemaId-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_GetSchemaId](@SchemaName NVARCHAR(MAX))
RETURNS INT
AS
BEGIN
  RETURN (
    SELECT TOP(1) schema_id
      FROM sys.schemas
     WHERE @SchemaName IN (name, QUOTENAME(name), QUOTENAME(name, '"'))
     ORDER BY 
        CASE WHEN name = @SchemaName THEN 0 ELSE 1 END
  );
END;
GO