--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_MarkSchemaAsTestClass-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_MarkSchemaAsTestClass', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_MarkSchemaAsTestClass] @QuotedClassName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_MarkSchemaAsTestClass-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[Private_MarkSchemaAsTestClass]
  @QuotedClassName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @UnquotedClassName NVARCHAR(MAX);

  SELECT @UnquotedClassName = name
    FROM sys.schemas
   WHERE QUOTENAME(name) = @QuotedClassName;

  EXEC sp_addextendedproperty @name = N'tSQLt.TestClass', 
                              @value = 1,
                              @level0type = 'SCHEMA',
                              @level0name = @UnquotedClassName;
END;
---Build-
GO