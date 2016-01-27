--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_ResolveApplyConstraintParameters-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_ResolveApplyConstraintParameters', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_ResolveApplyConstraintParameters](@A nvarchar(MAX),@B nvarchar(MAX),@C nvarchar(MAX)) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_ResolveApplyConstraintParameters-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_ResolveApplyConstraintParameters]
(
  @A NVARCHAR(MAX),
  @B NVARCHAR(MAX),
  @C NVARCHAR(MAX)
)
RETURNS TABLE
AS 
RETURN
  SELECT ConstraintObjectId, ConstraintType
    FROM tSQLt.Private_FindConstraint(OBJECT_ID(@A), @B)
   WHERE @C IS NULL
   UNION ALL
  SELECT *
    FROM tSQLt.Private_FindConstraint(OBJECT_ID(@A + '.' + @B), @C)
   UNION ALL
  SELECT *
    FROM tSQLt.Private_FindConstraint(OBJECT_ID(@C + '.' + @A), @B);
GO