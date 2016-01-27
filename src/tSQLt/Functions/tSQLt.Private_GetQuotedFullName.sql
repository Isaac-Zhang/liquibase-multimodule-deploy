--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetQuotedFullName-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetQuotedFullName', 'FN') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetQuotedFullName](@Objectid int) RETURNS int AS BEGIN RETURN 1 END')
GO



--changeSet func:Initial-tSQLt-Private_GetQuotedFullName-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_GetQuotedFullName](@Objectid INT)
RETURNS NVARCHAR(517)
AS
BEGIN
    DECLARE @QuotedName NVARCHAR(517);
    SELECT @QuotedName = QUOTENAME(OBJECT_SCHEMA_NAME(@Objectid)) + '.' + QUOTENAME(OBJECT_NAME(@Objectid));
    RETURN @QuotedName;
END;
GO