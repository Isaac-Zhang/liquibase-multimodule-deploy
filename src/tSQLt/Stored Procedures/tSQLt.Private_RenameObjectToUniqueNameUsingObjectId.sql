--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_RenameObjectToUniqueNameUsingObjectId-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_RenameObjectToUniqueNameUsingObjectId', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_RenameObjectToUniqueNameUsingObjectId] @ObjectId int,@NewName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_RenameObjectToUniqueNameUsingObjectId-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[Private_RenameObjectToUniqueNameUsingObjectId]
    @ObjectId INT,
    @NewName NVARCHAR(MAX) = NULL OUTPUT
AS
BEGIN
   DECLARE @SchemaName NVARCHAR(MAX);
   DECLARE @ObjectName NVARCHAR(MAX);
   
   SELECT @SchemaName = QUOTENAME(OBJECT_SCHEMA_NAME(@ObjectId)), @ObjectName = QUOTENAME(OBJECT_NAME(@ObjectId));
   
   EXEC tSQLt.Private_RenameObjectToUniqueName @SchemaName,@ObjectName, @NewName OUTPUT;
END;
---Build-
GO