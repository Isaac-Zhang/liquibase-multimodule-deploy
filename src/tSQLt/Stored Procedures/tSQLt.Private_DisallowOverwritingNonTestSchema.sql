--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_DisallowOverwritingNonTestSchema-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_DisallowOverwritingNonTestSchema', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_DisallowOverwritingNonTestSchema] @ClassName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_DisallowOverwritingNonTestSchema-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[Private_DisallowOverwritingNonTestSchema]
  @ClassName NVARCHAR(MAX)
AS
BEGIN
  IF SCHEMA_ID(@ClassName) IS NOT NULL AND tSQLt.Private_IsTestClass(@ClassName) = 0
  BEGIN
    RAISERROR('Attempted to execute tSQLt.NewTestClass on ''%s'' which is an existing schema but not a test class', 16, 10, @ClassName);
  END
END;
---Build-
GO