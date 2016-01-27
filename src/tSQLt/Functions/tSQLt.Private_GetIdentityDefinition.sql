--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetIdentityDefinition-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetIdentityDefinition', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetIdentityDefinition](@ObjectId int,@ColumnId int,@ReturnDetails bit) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_GetIdentityDefinition-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER FUNCTION  [tSQLt].[Private_GetIdentityDefinition](@ObjectId INT, @ColumnId INT, @ReturnDetails BIT)
RETURNS TABLE
AS
RETURN SELECT 
              COALESCE(IsIdentity, 0) AS IsIdentityColumn,
              COALESCE(IdentityDefinition, '') AS IdentityDefinition
        FROM (SELECT 1) X(X)
        LEFT JOIN (SELECT 1 AS IsIdentity,
                          ' IDENTITY(' + CAST(seed_value AS NVARCHAR(MAX)) + ',' + CAST(increment_value AS NVARCHAR(MAX)) + ')' AS IdentityDefinition, 
                          object_id, 
                          column_id
                     FROM sys.identity_columns
                  ) AS id
               ON id.object_id = @ObjectId
              AND id.column_id = @ColumnId
              AND @ReturnDetails = 1;               
---Build-
GO