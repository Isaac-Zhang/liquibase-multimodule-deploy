--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetCommaSeparatedColumnList-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetCommaSeparatedColumnList', 'FN') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetCommaSeparatedColumnList](@Table nvarchar(MAX),@ExcludeColumn nvarchar(MAX)) RETURNS int AS BEGIN RETURN 1 END')
GO



--changeSet func:Initial-tSQLt-Private_GetCommaSeparatedColumnList-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---BUILD+
ALTER FUNCTION  [tSQLt].[Private_GetCommaSeparatedColumnList] (@Table NVARCHAR(MAX), @ExcludeColumn NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS 
BEGIN
  RETURN STUFF((
     SELECT ',' + CASE WHEN system_type_id = TYPE_ID('timestamp') THEN ';TIMESTAMP columns are unsupported!;' ELSE QUOTENAME(name) END 
       FROM sys.columns 
      WHERE object_id = OBJECT_ID(@Table) 
        AND name <> @ExcludeColumn 
      ORDER BY column_id
     FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)')
    ,1, 1, '');
        
END;
---BUILD-
GO