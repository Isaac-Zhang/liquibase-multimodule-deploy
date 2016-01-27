--liquibase formatted sql

--changeSet proc:Initial-tSQLt-FakeTable-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.FakeTable', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[FakeTable] @TableName nvarchar(MAX),@SchemaName nvarchar(MAX),@Identity bit,@ComputedColumns bit,@Defaults bit AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-FakeTable-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[FakeTable]
    @TableName NVARCHAR(MAX),
    @SchemaName NVARCHAR(MAX) = NULL, --parameter preserved for backward compatibility. Do not use. Will be removed soon.
    @Identity BIT = NULL,
    @ComputedColumns BIT = NULL,
    @Defaults BIT = NULL
AS
BEGIN
   DECLARE @OrigSchemaName NVARCHAR(MAX);
   DECLARE @OrigTableName NVARCHAR(MAX);
   DECLARE @NewNameOfOriginalTable NVARCHAR(4000);
   
   SELECT @OrigSchemaName = @SchemaName,
          @OrigTableName = @TableName
   
   SELECT @SchemaName = CleanSchemaName,
          @TableName = CleanTableName
     FROM tSQLt.Private_ResolveFakeTableNamesForBackwardCompatibility(@TableName, @SchemaName);
   
   EXEC tSQLt.Private_ValidateFakeTableParameters @SchemaName,@OrigTableName,@OrigSchemaName;

   EXEC tSQLt.PrepareTableForFaking @TableName, @SchemaName;

   EXEC tSQLt.Private_RenameObjectToUniqueName @SchemaName, @TableName, @NewNameOfOriginalTable OUTPUT;

   EXEC tSQLt.Private_CreateFakeOfTable @SchemaName, @TableName, @NewNameOfOriginalTable, @Identity, @ComputedColumns, @Defaults;

   EXEC tSQLt.Private_MarkFakeTable @SchemaName, @TableName, @NewNameOfOriginalTable;
END
---Build-
GO