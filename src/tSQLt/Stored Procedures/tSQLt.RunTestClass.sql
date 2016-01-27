--liquibase formatted sql

--changeSet proc:Initial-tSQLt-RunTestClass-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.RunTestClass', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[RunTestClass] @TestClassName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-RunTestClass-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[RunTestClass]
   @TestClassName NVARCHAR(MAX)
AS
BEGIN
    EXEC tSQLt.Run @TestClassName;
END
GO