--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_MarkFakeTable-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_MarkFakeTable', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_MarkFakeTable] @SchemaName nvarchar(MAX),@TableName nvarchar(MAX),@NewNameOfOriginalTable nvarchar(4000) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_MarkFakeTable-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[Private_MarkFakeTable]
  @SchemaName NVARCHAR(MAX),
  @TableName NVARCHAR(MAX),
  @NewNameOfOriginalTable NVARCHAR(4000)
AS
BEGIN
   DECLARE @UnquotedSchemaName NVARCHAR(MAX);SET @UnquotedSchemaName = OBJECT_SCHEMA_NAME(OBJECT_ID(@SchemaName+'.'+@TableName));
   DECLARE @UnquotedTableName NVARCHAR(MAX);SET @UnquotedTableName = OBJECT_NAME(OBJECT_ID(@SchemaName+'.'+@TableName));

   EXEC sys.sp_addextendedproperty 
      @name = N'tSQLt.FakeTable_OrgTableName', 
      @value = @NewNameOfOriginalTable, 
      @level0type = N'SCHEMA', @level0name = @UnquotedSchemaName, 
      @level1type = N'TABLE',  @level1name = @UnquotedTableName;
END;
---Build-
GO