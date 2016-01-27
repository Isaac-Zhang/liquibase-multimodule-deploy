--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_PrintXML-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_PrintXML', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_PrintXML] @Message xml AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_PrintXML-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[Private_PrintXML]
    @Message XML
AS 
BEGIN
    SELECT @Message FOR XML PATH('');--Required together with ":XML ON" sqlcmd statement to allow more than 1mb to be returned
    RETURN 0;
END;
GO