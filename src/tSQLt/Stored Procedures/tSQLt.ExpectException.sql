--liquibase formatted sql

--changeSet proc:Initial-tSQLt-ExpectException-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.ExpectException', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[ExpectException] @ExpectedMessage nvarchar(MAX),@ExpectedSeverity int,@ExpectedState int,@Message nvarchar(MAX),@ExpectedMessagePattern nvarchar(MAX),@ExpectedErrorNumber int AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-ExpectException-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[ExpectException]
@ExpectedMessage NVARCHAR(MAX) = NULL,
@ExpectedSeverity INT = NULL,
@ExpectedState INT = NULL,
@Message NVARCHAR(MAX) = NULL,
@ExpectedMessagePattern NVARCHAR(MAX) = NULL,
@ExpectedErrorNumber INT = NULL
AS
BEGIN
 IF(EXISTS(SELECT 1 FROM #ExpectException))
 BEGIN
   RAISERROR('Each test can only contain one call to tSQLt.ExpectException or tSQLt.ExpectNoException.',16,10);
 END;
 
 INSERT INTO #ExpectException(ExpectException, ExpectedMessage, ExpectedSeverity, ExpectedState, ExpectedMessagePattern, ExpectedErrorNumber, FailMessage)
 VALUES(1, @ExpectedMessage, @ExpectedSeverity, @ExpectedState, @ExpectedMessagePattern, @ExpectedErrorNumber, @Message);
END;
---Build-
GO