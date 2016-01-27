--liquibase formatted sql

--changeSet proc:Initial-tSQLt-AssertNotEquals-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.AssertNotEquals', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[AssertNotEquals] @Expected sql_variant,@Actual sql_variant,@Message nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-AssertNotEquals-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[AssertNotEquals]
    @Expected SQL_VARIANT,
    @Actual SQL_VARIANT,
    @Message NVARCHAR(MAX) = ''
AS
BEGIN
  IF (@Expected = @Actual)
  OR (@Expected IS NULL AND @Actual IS NULL)
  BEGIN
    DECLARE @msg NVARCHAR(MAX);
    SET @msg = 'Expected actual value to not ' + 
               COALESCE('equal <' + tSQLt.Private_SqlVariantFormatter(@Expected)+'>', 'be NULL') + 
               '.';
    EXEC tSQLt.Fail @msg, @Message;
  END;
  RETURN 0;
END;
---Build-
GO