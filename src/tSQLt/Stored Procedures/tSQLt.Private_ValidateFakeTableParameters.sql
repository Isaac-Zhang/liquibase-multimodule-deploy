--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_ValidateFakeTableParameters-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_ValidateFakeTableParameters', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_ValidateFakeTableParameters] @SchemaName nvarchar(MAX),@OrigTableName nvarchar(MAX),@OrigSchemaName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_ValidateFakeTableParameters-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[Private_ValidateFakeTableParameters]
  @SchemaName NVARCHAR(MAX),
  @OrigTableName NVARCHAR(MAX),
  @OrigSchemaName NVARCHAR(MAX)
AS
BEGIN
   IF @SchemaName IS NULL
   BEGIN
        DECLARE @FullName NVARCHAR(MAX); SET @FullName = @OrigTableName + COALESCE('.' + @OrigSchemaName, '');
        
        RAISERROR ('FakeTable could not resolve the object name, ''%s''. Be sure to call FakeTable and pass in a single parameter, such as: EXEC tSQLt.FakeTable ''MySchema.MyTable''', 
                   16, 10, @FullName);
   END;
END;
---Build-
GO