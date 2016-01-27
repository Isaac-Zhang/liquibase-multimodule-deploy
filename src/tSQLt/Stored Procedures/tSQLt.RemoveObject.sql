--liquibase formatted sql

--changeSet proc:Initial-tSQLt-RemoveObject-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.RemoveObject', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[RemoveObject] @ObjectName nvarchar(MAX),@NewName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-RemoveObject-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---BUILD+
ALTER PROCEDURE [tSQLt].[RemoveObject] 
    @ObjectName NVARCHAR(MAX),
    @NewName NVARCHAR(MAX) = NULL OUTPUT
AS
BEGIN
  DECLARE @ObjectId INT;
  SELECT @ObjectId = OBJECT_ID(@ObjectName);
  
  IF(@ObjectId IS NULL)
  BEGIN
    RAISERROR('%s does not exist!',16,10,@ObjectName);
  END;

  EXEC tSQLt.Private_RenameObjectToUniqueNameUsingObjectId @ObjectId, @NewName = @NewName OUTPUT;
END;
---Build-
GO