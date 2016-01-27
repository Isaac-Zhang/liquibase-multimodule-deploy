--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetOriginalTableInfo-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetOriginalTableInfo', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetOriginalTableInfo](@TableObjectId int) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_GetOriginalTableInfo-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_GetOriginalTableInfo](@TableObjectId INT)
RETURNS TABLE
AS
  RETURN SELECT CAST(value AS NVARCHAR(4000)) OrgTableName,
                OBJECT_ID(QUOTENAME(OBJECT_SCHEMA_NAME(@TableObjectId)) + '.' + QUOTENAME(CAST(value AS NVARCHAR(4000)))) OrgTableObjectId
    FROM sys.extended_properties
   WHERE class_desc = 'OBJECT_OR_COLUMN'
     AND major_id = @TableObjectId
     AND minor_id = 0
     AND name = 'tSQLt.FakeTable_OrgTableName';
GO