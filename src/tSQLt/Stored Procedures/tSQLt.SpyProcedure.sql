--liquibase formatted sql

--changeSet proc:Initial-tSQLt-SpyProcedure-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.SpyProcedure', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[SpyProcedure] @ProcedureName nvarchar(MAX),@CommandToExecute nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-SpyProcedure-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[SpyProcedure]
    @ProcedureName NVARCHAR(MAX),
    @CommandToExecute NVARCHAR(MAX) = NULL
AS
BEGIN
    DECLARE @ProcedureObjectId INT;
    SELECT @ProcedureObjectId = OBJECT_ID(@ProcedureName);

    EXEC tSQLt.Private_ValidateProcedureCanBeUsedWithSpyProcedure @ProcedureName;

    DECLARE @LogTableName NVARCHAR(MAX);
    SELECT @LogTableName = QUOTENAME(OBJECT_SCHEMA_NAME(@ProcedureObjectId)) + '.' + QUOTENAME(OBJECT_NAME(@ProcedureObjectId)+'_SpyProcedureLog');

    EXEC tSQLt.Private_RenameObjectToUniqueNameUsingObjectId @ProcedureObjectId;

    EXEC tSQLt.Private_CreateProcedureSpy @ProcedureObjectId, @ProcedureName, @LogTableName, @CommandToExecute;

    RETURN 0;
END;
---Build-
GO