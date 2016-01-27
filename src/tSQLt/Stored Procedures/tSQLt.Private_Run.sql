--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_Run-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_Run', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_Run] @TestName nvarchar(MAX),@TestResultFormatter nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_Run-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[Private_Run]
   @TestName NVARCHAR(MAX),
   @TestResultFormatter NVARCHAR(MAX)
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @FullName NVARCHAR(MAX);
    DECLARE @TestClassId INT;
    DECLARE @IsTestClass BIT;
    DECLARE @IsTestCase BIT;
    DECLARE @IsSchema BIT;
    DECLARE @SetUp NVARCHAR(MAX);SET @SetUp = NULL;
    
    SELECT @TestName = tSQLt.Private_GetLastTestNameIfNotProvided(@TestName);
    EXEC tSQLt.Private_SaveTestNameForSession @TestName;
    
    SELECT @TestClassId = schemaId,
           @FullName = quotedFullName,
           @IsTestClass = isTestClass,
           @IsSchema = isSchema,
           @IsTestCase = isTestCase
      FROM tSQLt.Private_ResolveName(@TestName);
     
    EXEC tSQLt.Private_CleanTestResult;

    IF @IsSchema = 1
    BEGIN
        EXEC tSQLt.Private_RunTestClass @FullName;
    END
    
    IF @IsTestCase = 1
    BEGIN
      DECLARE @SetupProcName NVARCHAR(MAX);
      EXEC tSQLt.Private_GetSetupProcedureName @TestClassId, @SetupProcName OUTPUT;

      EXEC tSQLt.Private_RunTest @FullName, @SetupProcName;
    END;

    EXEC tSQLt.Private_OutputTestResults @TestResultFormatter;
END;
GO