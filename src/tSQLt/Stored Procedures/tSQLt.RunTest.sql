--liquibase formatted sql

--changeSet proc:Initial-tSQLt-RunTest-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.RunTest', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[RunTest] @TestName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-RunTest-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[RunTest]
   @TestName NVARCHAR(MAX)
AS
BEGIN
  RAISERROR('tSQLt.RunTest has been retired. Please use tSQLt.Run instead.', 16, 10);
END;
GO