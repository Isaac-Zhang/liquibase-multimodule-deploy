--liquibase formatted sql

--changeSet proc:Initial-tSQLt-ExpectNoException-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.ExpectNoException', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[ExpectNoException] @Message nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-ExpectNoException-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[ExpectNoException]
  @Message NVARCHAR(MAX) = NULL
AS
BEGIN
 IF(EXISTS(SELECT 1 FROM #ExpectException))
 BEGIN
   RAISERROR('Each test can only contain one call to tSQLt.ExpectException or tSQLt.ExpectNoException.',16,10);
 END;
 
 INSERT INTO #ExpectException(ExpectException, FailMessage)
 VALUES(0, @Message);
END;
---Build-
GO