--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_MarkObjectBeforeRename-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_MarkObjectBeforeRename', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_MarkObjectBeforeRename] @SchemaName nvarchar(MAX),@OriginalName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_MarkObjectBeforeRename-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[Private_MarkObjectBeforeRename]
    @SchemaName NVARCHAR(MAX), 
    @OriginalName NVARCHAR(MAX)
AS
BEGIN
  INSERT INTO tSQLt.Private_RenamedObjectLog (ObjectId, OriginalName) 
  VALUES (OBJECT_ID(@SchemaName + '.' + @OriginalName), @OriginalName);
END;
---Build-
GO