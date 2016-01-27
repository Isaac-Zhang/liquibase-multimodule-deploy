--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetQuotedTableNameForConstraint-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetQuotedTableNameForConstraint', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetQuotedTableNameForConstraint](@ConstraintObjectId int) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_GetQuotedTableNameForConstraint-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_GetQuotedTableNameForConstraint](@ConstraintObjectId INT)
RETURNS TABLE
AS
RETURN
  SELECT QUOTENAME(SCHEMA_NAME(newtbl.schema_id)) + '.' + QUOTENAME(OBJECT_NAME(newtbl.object_id)) QuotedTableName,
         SCHEMA_NAME(newtbl.schema_id) SchemaName,
         OBJECT_NAME(newtbl.object_id) TableName,
         OBJECT_NAME(constraints.parent_object_id) OrgTableName
      FROM sys.objects AS constraints
      JOIN sys.extended_properties AS p
      JOIN sys.objects AS newtbl
        ON newtbl.object_id = p.major_id
       AND p.minor_id = 0
       AND p.class_desc = 'OBJECT_OR_COLUMN'
       AND p.name = 'tSQLt.FakeTable_OrgTableName'
        ON OBJECT_NAME(constraints.parent_object_id) = CAST(p.value AS NVARCHAR(4000))
       AND constraints.schema_id = newtbl.schema_id
       AND constraints.object_id = @ConstraintObjectId;
GO