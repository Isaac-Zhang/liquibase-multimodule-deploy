--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_SetFakeViewOff_SingleView-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_SetFakeViewOff_SingleView', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_SetFakeViewOff_SingleView] @ViewName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_SetFakeViewOff_SingleView-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[Private_SetFakeViewOff_SingleView]
  @ViewName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @Cmd NVARCHAR(MAX),
          @SchemaName NVARCHAR(MAX),
          @TriggerName NVARCHAR(MAX);
          
  SELECT @SchemaName = QUOTENAME(OBJECT_SCHEMA_NAME(ObjId)),
         @TriggerName = QUOTENAME(OBJECT_NAME(ObjId) + '_SetFakeViewOn')
    FROM (SELECT OBJECT_ID(@ViewName) AS ObjId) X;
  
  SET @Cmd = 'DROP TRIGGER %SCHEMA_NAME%.%TRIGGER_NAME%;';
      
  SET @Cmd = REPLACE(@Cmd, '%SCHEMA_NAME%', @SchemaName);
  SET @Cmd = REPLACE(@Cmd, '%TRIGGER_NAME%', @TriggerName);
  
  EXEC(@Cmd);
END;
GO