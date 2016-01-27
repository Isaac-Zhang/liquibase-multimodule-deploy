--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_CompareTablesFailIfUnequalRowsExists-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_CompareTablesFailIfUnequalRowsExists', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_CompareTablesFailIfUnequalRowsExists] @UnequalRowsExist int,@ResultTable nvarchar(MAX),@ResultColumn nvarchar(MAX),@ColumnList nvarchar(MAX),@FailMsg nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_CompareTablesFailIfUnequalRowsExists-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---BUILD+
ALTER PROCEDURE [tSQLt].[Private_CompareTablesFailIfUnequalRowsExists]
 @UnequalRowsExist INT,
 @ResultTable NVARCHAR(MAX),
 @ResultColumn NVARCHAR(MAX),
 @ColumnList NVARCHAR(MAX),
 @FailMsg NVARCHAR(MAX)
AS
BEGIN
  IF @UnequalRowsExist > 0
  BEGIN
   DECLARE @TableToTextResult NVARCHAR(MAX);
   DECLARE @OutputColumnList NVARCHAR(MAX);
   SELECT @OutputColumnList = '[_m_],' + @ColumnList;
   EXEC tSQLt.TableToText @TableName = @ResultTable, @OrderBy = @ResultColumn, @PrintOnlyColumnNameAliasList = @OutputColumnList, @txt = @TableToTextResult OUTPUT;
   
   DECLARE @Message NVARCHAR(MAX);
   SELECT @Message = @FailMsg + CHAR(13) + CHAR(10);

    EXEC tSQLt.Fail @Message, @TableToTextResult;
  END;
END
---BUILD-
GO