--liquibase formatted sql

--changeSet proc:Initial-tSQLt-SetFakeViewOff-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.SetFakeViewOff', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[SetFakeViewOff] @SchemaName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-SetFakeViewOff-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[SetFakeViewOff]
  @SchemaName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @ViewName NVARCHAR(MAX);
    
  DECLARE viewNames CURSOR LOCAL FAST_FORWARD FOR
   SELECT QUOTENAME(OBJECT_SCHEMA_NAME(t.parent_id)) + '.' + QUOTENAME(OBJECT_NAME(t.parent_id)) AS viewName
     FROM sys.extended_properties ep
     JOIN sys.triggers t
       on ep.major_id = t.object_id
     WHERE ep.name = N'SetFakeViewOnTrigger'  
  OPEN viewNames;
  
  FETCH NEXT FROM viewNames INTO @ViewName;
  WHILE @@FETCH_STATUS = 0
  BEGIN
    EXEC tSQLt.Private_SetFakeViewOff_SingleView @ViewName;
    
    FETCH NEXT FROM viewNames INTO @ViewName;
  END;
  
  CLOSE viewNames;
  DEALLOCATE viewNames;
END;
GO