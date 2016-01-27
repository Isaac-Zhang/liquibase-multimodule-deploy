--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetLastTestNameIfNotProvided-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetLastTestNameIfNotProvided', 'FN') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetLastTestNameIfNotProvided](@TestName nvarchar(MAX)) RETURNS int AS BEGIN RETURN 1 END')
GO



--changeSet func:Initial-tSQLt-Private_GetLastTestNameIfNotProvided-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----------------------------------------------------------------------
ALTER FUNCTION  [tSQLt].[Private_GetLastTestNameIfNotProvided](@TestName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
  IF(LTRIM(ISNULL(@TestName,'')) = '')
  BEGIN
    SELECT @TestName = TestName 
      FROM tSQLt.Run_LastExecution le
      JOIN sys.dm_exec_sessions es
        ON le.SessionId = es.session_id
       AND le.LoginTime = es.login_time
     WHERE es.session_id = @@SPID;
  END

  RETURN @TestName;
END
GO