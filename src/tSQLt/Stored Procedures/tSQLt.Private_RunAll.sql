--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_RunAll-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_RunAll', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_RunAll] @TestResultFormatter nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_RunAll-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[Private_RunAll]
  @TestResultFormatter NVARCHAR(MAX)
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @TestClassName NVARCHAR(MAX);
  DECLARE @TestProcName NVARCHAR(MAX);

  EXEC tSQLt.Private_CleanTestResult;

  DECLARE tests CURSOR LOCAL FAST_FORWARD FOR
   SELECT Name
     FROM tSQLt.TestClasses;

  OPEN tests;
  
  FETCH NEXT FROM tests INTO @TestClassName;
  WHILE @@FETCH_STATUS = 0
  BEGIN
    EXEC tSQLt.Private_RunTestClass @TestClassName;
    
    FETCH NEXT FROM tests INTO @TestClassName;
  END;
  
  CLOSE tests;
  DEALLOCATE tests;
  
  EXEC tSQLt.Private_OutputTestResults @TestResultFormatter;
END;
GO