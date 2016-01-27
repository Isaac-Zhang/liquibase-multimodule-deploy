--liquibase formatted sql

--changeSet proc:Initial-tSQLt-RunWithXmlResults-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.RunWithXmlResults', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[RunWithXmlResults] @TestName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-RunWithXmlResults-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[RunWithXmlResults]
   @TestName NVARCHAR(MAX) = NULL
AS
BEGIN
  EXEC tSQLt.Private_Run @TestName, 'tSQLt.XmlResultFormatter';
END;
GO