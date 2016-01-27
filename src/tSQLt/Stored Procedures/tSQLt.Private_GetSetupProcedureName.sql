--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_GetSetupProcedureName-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetSetupProcedureName', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_GetSetupProcedureName] @TestClassId int,@SetupProcName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_GetSetupProcedureName-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[Private_GetSetupProcedureName]
  @TestClassId INT = NULL,
  @SetupProcName NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SELECT @SetupProcName = tSQLt.Private_GetQuotedFullName(object_id)
      FROM sys.procedures
     WHERE schema_id = @TestClassId
       AND LOWER(name) = 'setup';
END;
GO