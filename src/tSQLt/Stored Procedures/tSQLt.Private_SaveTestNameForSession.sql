--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_SaveTestNameForSession-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_SaveTestNameForSession', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_SaveTestNameForSession] @TestName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_SaveTestNameForSession-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[Private_SaveTestNameForSession] 
  @TestName NVARCHAR(MAX)
AS
BEGIN
  DELETE FROM tSQLt.Run_LastExecution
   WHERE SessionId = @@SPID;  

  INSERT INTO tSQLt.Run_LastExecution(TestName, SessionId, LoginTime)
  SELECT TestName = @TestName,
         session_id,
         login_time
    FROM sys.dm_exec_sessions
   WHERE session_id = @@SPID;
END
GO