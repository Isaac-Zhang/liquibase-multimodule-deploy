--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Run-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Run', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Run] @TestName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Run-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[Run]
   @TestName NVARCHAR(MAX) = NULL
AS
BEGIN
  DECLARE @TestResultFormatter NVARCHAR(MAX);
  SELECT @TestResultFormatter = tSQLt.GetTestResultFormatter();
  
  EXEC tSQLt.Private_Run @TestName, @TestResultFormatter;
END;
GO