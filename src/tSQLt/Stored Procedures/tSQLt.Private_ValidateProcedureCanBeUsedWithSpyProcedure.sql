--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_ValidateProcedureCanBeUsedWithSpyProcedure-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_ValidateProcedureCanBeUsedWithSpyProcedure', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_ValidateProcedureCanBeUsedWithSpyProcedure] @ProcedureName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_ValidateProcedureCanBeUsedWithSpyProcedure-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[Private_ValidateProcedureCanBeUsedWithSpyProcedure]
    @ProcedureName NVARCHAR(MAX)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM sys.procedures WHERE object_id = OBJECT_ID(@ProcedureName))
    BEGIN
      RAISERROR('Cannot use SpyProcedure on %s because the procedure does not exist', 16, 10, @ProcedureName) WITH NOWAIT;
    END;
    
    IF (1020 < (SELECT COUNT(*) FROM sys.parameters WHERE object_id = OBJECT_ID(@ProcedureName)))
    BEGIN
      RAISERROR('Cannot use SpyProcedure on procedure %s because it contains more than 1020 parameters', 16, 10, @ProcedureName) WITH NOWAIT;
    END;
END;
GO