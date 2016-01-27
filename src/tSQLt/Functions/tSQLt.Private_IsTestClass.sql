--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_IsTestClass-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_IsTestClass', 'FN') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_IsTestClass](@TestClassName nvarchar(MAX)) RETURNS int AS BEGIN RETURN 1 END')
GO



--changeSet func:Initial-tSQLt-Private_IsTestClass-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_IsTestClass](@TestClassName NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
  RETURN 
    CASE 
      WHEN EXISTS(
             SELECT 1 
               FROM tSQLt.TestClasses
              WHERE SchemaId = tSQLt.Private_GetSchemaId(@TestClassName)
            )
      THEN 1
      ELSE 0
    END;
END;
GO