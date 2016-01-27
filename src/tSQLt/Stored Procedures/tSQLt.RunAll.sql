--liquibase formatted sql

--changeSet proc:Initial-tSQLt-RunAll-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.RunAll', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[RunAll]  AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-RunAll-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--------------------------------------------------------------------------------
ALTER PROCEDURE [tSQLt].[RunAll]
AS
BEGIN
  DECLARE @TestResultFormatter NVARCHAR(MAX);
  SELECT @TestResultFormatter = tSQLt.GetTestResultFormatter();
  
  EXEC tSQLt.Private_RunAll @TestResultFormatter;
END;
GO