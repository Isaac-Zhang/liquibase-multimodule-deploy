--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_RenameObjectToUniqueName-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_RenameObjectToUniqueName', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_RenameObjectToUniqueName] @SchemaName nvarchar(MAX),@ObjectName nvarchar(MAX),@NewName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_RenameObjectToUniqueName-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[Private_RenameObjectToUniqueName]
    @SchemaName NVARCHAR(MAX),
    @ObjectName NVARCHAR(MAX),
    @NewName NVARCHAR(MAX) = NULL OUTPUT
AS
BEGIN
   SET @NewName=tSQLt.Private::CreateUniqueObjectName();

   DECLARE @RenameCmd NVARCHAR(MAX);
   SET @RenameCmd = 'EXEC sp_rename ''' + 
                          @SchemaName + '.' + @ObjectName + ''', ''' + 
                          @NewName + ''';';
   
   EXEC tSQLt.Private_MarkObjectBeforeRename @SchemaName, @ObjectName;


   EXEC tSQLt.SuppressOutput @RenameCmd;

END;
---Build-
GO