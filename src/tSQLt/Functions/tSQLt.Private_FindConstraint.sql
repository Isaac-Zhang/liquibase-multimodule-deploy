--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_FindConstraint-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_FindConstraint', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_FindConstraint](@TableObjectId int,@ConstraintName nvarchar(MAX)) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_FindConstraint-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_FindConstraint]
(
  @TableObjectId INT,
  @ConstraintName NVARCHAR(MAX)
)
RETURNS TABLE
AS
RETURN
  SELECT TOP(1) constraints.object_id AS ConstraintObjectId, type_desc AS ConstraintType
    FROM sys.objects constraints
    CROSS JOIN tSQLt.Private_GetOriginalTableInfo(@TableObjectId) orgTbl
   WHERE @ConstraintName IN (constraints.name, QUOTENAME(constraints.name))
     AND constraints.parent_object_id = orgTbl.OrgTableObjectId
   ORDER BY LEN(constraints.name) ASC;
GO