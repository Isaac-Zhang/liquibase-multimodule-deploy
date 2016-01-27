--liquibase formatted sql

--changeSet proc:Initial-tSQLt-TableToText-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.TableToText', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[TableToText] @txt nvarchar(MAX),@TableName nvarchar(MAX),@OrderBy nvarchar(MAX),@PrintOnlyColumnNameAliasList nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-TableToText-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[TableToText]
    @txt NVARCHAR(MAX) OUTPUT,
    @TableName NVARCHAR(MAX),
    @OrderBy NVARCHAR(MAX) = NULL,
    @PrintOnlyColumnNameAliasList NVARCHAR(MAX) = NULL
AS
BEGIN
    SET @txt = tSQLt.Private::TableToString(@TableName, @OrderBy, @PrintOnlyColumnNameAliasList);
END;
---Build-
GO