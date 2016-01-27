--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetCleanSchemaName-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetCleanSchemaName', 'FN') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetCleanSchemaName](@SchemaName nvarchar(MAX),@ObjectName nvarchar(MAX)) RETURNS int AS BEGIN RETURN 1 END')
GO



--changeSet func:Initial-tSQLt-Private_GetCleanSchemaName-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
ALTER FUNCTION  [tSQLt].[Private_GetCleanSchemaName](@SchemaName NVARCHAR(MAX), @ObjectName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN (SELECT SCHEMA_NAME(schema_id) 
              FROM sys.objects 
             WHERE object_id = CASE WHEN ISNULL(@SchemaName,'') in ('','[]')
                                    THEN OBJECT_ID(@ObjectName)
                                    ELSE OBJECT_ID(@SchemaName + '.' + @ObjectName)
                                END);
END;
GO