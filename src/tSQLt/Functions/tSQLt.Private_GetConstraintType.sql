--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetConstraintType-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetConstraintType', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetConstraintType](@TableObjectId int,@ConstraintName nvarchar(MAX)) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_GetConstraintType-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_GetConstraintType](@TableObjectId INT, @ConstraintName NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN
  SELECT object_id,type,type_desc
    FROM sys.objects 
   WHERE object_id = OBJECT_ID(SCHEMA_NAME(schema_id)+'.'+@ConstraintName)
     AND parent_object_id = @TableObjectId;
GO