--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_ValidateThatAllDataTypesInTableAreSupported-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_ValidateThatAllDataTypesInTableAreSupported', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_ValidateThatAllDataTypesInTableAreSupported] @ResultTable nvarchar(MAX),@ColumnList nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_ValidateThatAllDataTypesInTableAreSupported-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---BUILD+
ALTER PROCEDURE [tSQLt].[Private_ValidateThatAllDataTypesInTableAreSupported]
 @ResultTable NVARCHAR(MAX),
 @ColumnList NVARCHAR(MAX)
AS
BEGIN
    BEGIN TRY
      EXEC('DECLARE @EatResult INT; SELECT @EatResult = COUNT(1) FROM ' + @ResultTable + ' GROUP BY ' + @ColumnList + ';');
    END TRY
    BEGIN CATCH
      RAISERROR('The table contains a datatype that is not supported for tSQLt.AssertEqualsTable. Please refer to http://tsqlt.org/user-guide/assertions/assertequalstable/ for a list of unsupported datatypes.',16,10);
    END CATCH
END;
---BUILD-
GO