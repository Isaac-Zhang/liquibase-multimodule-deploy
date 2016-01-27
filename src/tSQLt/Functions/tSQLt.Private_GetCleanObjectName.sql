--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetCleanObjectName-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetCleanObjectName', 'FN') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetCleanObjectName](@ObjectName nvarchar(MAX)) RETURNS int AS BEGIN RETURN 1 END')
GO



--changeSet func:Initial-tSQLt-Private_GetCleanObjectName-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_GetCleanObjectName](@ObjectName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN (SELECT OBJECT_NAME(OBJECT_ID(@ObjectName)));
END;
GO