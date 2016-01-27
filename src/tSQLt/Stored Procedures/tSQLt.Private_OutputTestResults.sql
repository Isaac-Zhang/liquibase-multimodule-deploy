--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_OutputTestResults-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_OutputTestResults', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_OutputTestResults] @TestResultFormatter nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_OutputTestResults-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[Private_OutputTestResults]
  @TestResultFormatter NVARCHAR(MAX) = NULL
AS
BEGIN
    DECLARE @Formatter NVARCHAR(MAX);
    SELECT @Formatter = COALESCE(@TestResultFormatter, tSQLt.GetTestResultFormatter());
    EXEC (@Formatter);
END
GO