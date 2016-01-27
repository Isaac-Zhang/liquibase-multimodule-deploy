--liquibase formatted sql

--changeSet proc:Initial-tSQLt-DefaultResultFormatter-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.DefaultResultFormatter', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[DefaultResultFormatter]  AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-DefaultResultFormatter-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[DefaultResultFormatter]
AS
BEGIN
    DECLARE @Msg1 NVARCHAR(MAX);
    DECLARE @Msg2 NVARCHAR(MAX);
    DECLARE @Msg3 NVARCHAR(MAX);
    DECLARE @Msg4 NVARCHAR(MAX);
    DECLARE @IsSuccess INT;
    DECLARE @SuccessCnt INT;
    DECLARE @Severity INT;
    
    SELECT ROW_NUMBER() OVER(ORDER BY Result DESC, Name ASC) No,Name [Test Case Name], Result
      INTO #Tmp
      FROM tSQLt.TestResult;
    
    EXEC tSQLt.TableToText @Msg1 OUTPUT, '#Tmp', 'No';

    SELECT @Msg3 = Msg, 
           @IsSuccess = 1 - SIGN(FailCnt + ErrorCnt),
           @SuccessCnt = SuccessCnt
      FROM tSQLt.TestCaseSummary();
      
    SELECT @Severity = 16*(1-@IsSuccess);
    
    SELECT @Msg2 = REPLICATE('-',LEN(@Msg3)),
           @Msg4 = CHAR(13)+CHAR(10);
    
    
    EXEC tSQLt.Private_Print @Msg4,0;
    EXEC tSQLt.Private_Print '+----------------------+',0;
    EXEC tSQLt.Private_Print '|Test Execution Summary|',0;
    EXEC tSQLt.Private_Print '+----------------------+',0;
    EXEC tSQLt.Private_Print @Msg4,0;
    EXEC tSQLt.Private_Print @Msg1,0;
    EXEC tSQLt.Private_Print @Msg2,0;
    EXEC tSQLt.Private_Print @Msg3, @Severity;
    EXEC tSQLt.Private_Print @Msg2,0;
END;
GO