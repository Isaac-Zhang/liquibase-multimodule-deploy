--liquibase formatted sql

--changeSet proc:Initial-tSQLt-FakeFunction-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.FakeFunction', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[FakeFunction] @FunctionName nvarchar(MAX),@FakeFunctionName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-FakeFunction-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[FakeFunction]
  @FunctionName NVARCHAR(MAX),
  @FakeFunctionName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @FunctionObjectId INT;
  DECLARE @FakeFunctionObjectId INT;
  DECLARE @IsScalarFunction BIT;

  EXEC tSQLt.Private_ValidateObjectsCompatibleWithFakeFunction 
               @FunctionName = @FunctionName,
               @FakeFunctionName = @FakeFunctionName,
               @FunctionObjectId = @FunctionObjectId OUT,
               @FakeFunctionObjectId = @FakeFunctionObjectId OUT,
               @IsScalarFunction = @IsScalarFunction OUT;

  EXEC tSQLt.RemoveObject @ObjectName = @FunctionName;

  EXEC tSQLt.Private_CreateFakeFunction 
               @FunctionName = @FunctionName,
               @FakeFunctionName = @FakeFunctionName,
               @FunctionObjectId = @FunctionObjectId,
               @FakeFunctionObjectId = @FakeFunctionObjectId,
               @IsScalarFunction = @IsScalarFunction;

END;
GO