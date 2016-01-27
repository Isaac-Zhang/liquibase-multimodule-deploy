--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetOriginalTableName-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetOriginalTableName', 'FN') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetOriginalTableName](@SchemaName nvarchar(MAX),@TableName nvarchar(MAX)) RETURNS int AS BEGIN RETURN 1 END')
GO



--changeSet func:Initial-tSQLt-Private_GetOriginalTableName-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
ALTER FUNCTION  [tSQLt].[Private_GetOriginalTableName](@SchemaName NVARCHAR(MAX), @TableName NVARCHAR(MAX)) --DELETE!!!
RETURNS NVARCHAR(MAX)
AS
BEGIN
  RETURN (SELECT CAST(value AS NVARCHAR(4000))
    FROM sys.extended_properties
   WHERE class_desc = 'OBJECT_OR_COLUMN'
     AND major_id = OBJECT_ID(@SchemaName + '.' + @TableName)
     AND minor_id = 0
     AND name = 'tSQLt.FakeTable_OrgTableName');
END;
GO