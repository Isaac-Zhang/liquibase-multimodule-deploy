--liquibase formatted sql

--changeSet proc:Initial-tSQLt-LogCapturedOutput-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.LogCapturedOutput', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[LogCapturedOutput] @text nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-LogCapturedOutput-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[LogCapturedOutput] @text NVARCHAR(MAX)
AS
BEGIN
  INSERT INTO tSQLt.CaptureOutputLog (OutputText) VALUES (@text);
END;
---Build-
GO