--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_QuoteClassNameForNewTestClass-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_QuoteClassNameForNewTestClass', 'FN') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_QuoteClassNameForNewTestClass](@ClassName nvarchar(MAX)) RETURNS int AS BEGIN RETURN 1 END')
GO



--changeSet func:Initial-tSQLt-Private_QuoteClassNameForNewTestClass-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER FUNCTION  [tSQLt].[Private_QuoteClassNameForNewTestClass](@ClassName NVARCHAR(MAX))
  RETURNS NVARCHAR(MAX)
AS
BEGIN
  RETURN 
    CASE WHEN @ClassName LIKE '[[]%]' THEN @ClassName
         ELSE QUOTENAME(@ClassName)
     END;
END;
---Build-
GO