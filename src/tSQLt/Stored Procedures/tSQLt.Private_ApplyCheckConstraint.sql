--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_ApplyCheckConstraint-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_ApplyCheckConstraint', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_ApplyCheckConstraint] @ConstraintObjectId int AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_ApplyCheckConstraint-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[Private_ApplyCheckConstraint]
  @ConstraintObjectId INT
AS
BEGIN
  DECLARE @Cmd NVARCHAR(MAX);
  SELECT @Cmd = 'CONSTRAINT ' + QUOTENAME(name) + ' CHECK' + definition 
    FROM sys.check_constraints
   WHERE object_id = @ConstraintObjectId;
  
  DECLARE @QuotedTableName NVARCHAR(MAX);
  
  SELECT @QuotedTableName = QuotedTableName FROM tSQLt.Private_GetQuotedTableNameForConstraint(@ConstraintObjectId);

  EXEC tSQLt.Private_RenameObjectToUniqueNameUsingObjectId @ConstraintObjectId;
  SELECT @Cmd = 'ALTER TABLE ' + @QuotedTableName + ' ADD ' + @Cmd
    FROM sys.objects 
   WHERE object_id = @ConstraintObjectId;

  EXEC (@Cmd);

END;
GO