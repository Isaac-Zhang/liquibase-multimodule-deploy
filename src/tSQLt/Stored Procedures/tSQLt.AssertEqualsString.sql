--liquibase formatted sql

--changeSet proc:Initial-tSQLt-AssertEqualsString-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.AssertEqualsString', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[AssertEqualsString] @Expected nvarchar(MAX),@Actual nvarchar(MAX),@Message nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-AssertEqualsString-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[AssertEqualsString]
    @Expected NVARCHAR(MAX),
    @Actual NVARCHAR(MAX),
    @Message NVARCHAR(MAX) = ''
AS
BEGIN
    IF ((@Expected = @Actual) OR (@Actual IS NULL AND @Expected IS NULL))
      RETURN 0;

    DECLARE @Msg NVARCHAR(MAX);
    SELECT @Msg = 'Expected: <' + ISNULL(@Expected, 'NULL') + 
                  '> but was: <' + ISNULL(@Actual, 'NULL') + '>';
    EXEC tSQLt.Fail @Message, @Msg;
END;
GO