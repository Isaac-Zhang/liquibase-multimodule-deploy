--liquibase formatted sql

--changeSet proc:Initial-tSQLt-AssertEquals-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.AssertEquals', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[AssertEquals] @Expected sql_variant,@Actual sql_variant,@Message nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-AssertEquals-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[AssertEquals]
    @Expected SQL_VARIANT,
    @Actual SQL_VARIANT,
    @Message NVARCHAR(MAX) = ''
AS
BEGIN
    IF ((@Expected = @Actual) OR (@Actual IS NULL AND @Expected IS NULL))
      RETURN 0;

    DECLARE @Msg NVARCHAR(MAX);
    SELECT @Msg = 'Expected: <' + ISNULL(CAST(@Expected AS NVARCHAR(MAX)), 'NULL') + 
                  '> but was: <' + ISNULL(CAST(@Actual AS NVARCHAR(MAX)), 'NULL') + '>';
    IF((COALESCE(@Message,'') <> '') AND (@Message NOT LIKE '% ')) SET @Message = @Message + ' ';
    EXEC tSQLt.Fail @Message, @Msg;
END;
GO