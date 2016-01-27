--liquibase formatted sql

--changeSet proc:Initial-tSQLt-AssertLike-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.AssertLike', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[AssertLike] @ExpectedPattern nvarchar(MAX),@Actual nvarchar(MAX),@Message nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-AssertLike-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[AssertLike] 
  @ExpectedPattern NVARCHAR(MAX),
  @Actual NVARCHAR(MAX),
  @Message NVARCHAR(MAX) = ''
AS
BEGIN
  IF (LEN(@ExpectedPattern) > 4000)
  BEGIN
    RAISERROR ('@ExpectedPattern may not exceed 4000 characters.', 16, 10);
  END;

  IF ((@Actual LIKE @ExpectedPattern) OR (@Actual IS NULL AND @ExpectedPattern IS NULL))
  BEGIN
    RETURN 0;
  END

  DECLARE @Msg NVARCHAR(MAX);
  SELECT @Msg = CHAR(13) + CHAR(10) + 'Expected: <' + ISNULL(@ExpectedPattern, 'NULL') + '>' +
                CHAR(13) + CHAR(10) + ' but was: <' + ISNULL(@Actual, 'NULL') + '>';
  EXEC tSQLt.Fail @Message, @Msg;
END;
GO