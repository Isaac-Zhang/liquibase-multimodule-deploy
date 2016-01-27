--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_CleanTestResult-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_CleanTestResult', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_CleanTestResult]  AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_CleanTestResult-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[Private_CleanTestResult]
AS
BEGIN
   DELETE FROM tSQLt.TestResult;
END;
GO