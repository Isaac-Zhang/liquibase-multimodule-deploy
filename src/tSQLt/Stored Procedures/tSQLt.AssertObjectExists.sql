--liquibase formatted sql

--changeSet proc:Initial-tSQLt-AssertObjectExists-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.AssertObjectExists', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[AssertObjectExists] @ObjectName nvarchar(MAX),@Message nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-AssertObjectExists-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[AssertObjectExists]
    @ObjectName NVARCHAR(MAX),
    @Message NVARCHAR(MAX) = ''
AS
BEGIN
    DECLARE @Msg NVARCHAR(MAX);
    IF(@ObjectName LIKE '#%')
    BEGIN
     IF OBJECT_ID('tempdb..'+@ObjectName) IS NULL
     BEGIN
         SELECT @Msg = '''' + COALESCE(@ObjectName, 'NULL') + ''' does not exist';
         EXEC tSQLt.Fail @Message, @Msg;
         RETURN 1;
     END;
    END
    ELSE
    BEGIN
     IF OBJECT_ID(@ObjectName) IS NULL
     BEGIN
         SELECT @Msg = '''' + COALESCE(@ObjectName, 'NULL') + ''' does not exist';
         EXEC tSQLt.Fail @Message, @Msg;
         RETURN 1;
     END;
    END;
    RETURN 0;
END;
GO