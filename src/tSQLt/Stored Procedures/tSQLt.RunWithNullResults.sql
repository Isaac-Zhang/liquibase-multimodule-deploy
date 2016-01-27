--liquibase formatted sql

--changeSet proc:Initial-tSQLt-RunWithNullResults-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.RunWithNullResults', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[RunWithNullResults] @TestName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-RunWithNullResults-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[RunWithNullResults]
    @TestName NVARCHAR(MAX) = NULL
AS
BEGIN
  EXEC tSQLt.Private_Run @TestName, 'tSQLt.NullTestResultFormatter';
END;
GO