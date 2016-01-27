--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetForeignKeyRefColumns-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetForeignKeyRefColumns', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetForeignKeyRefColumns](@ConstraintObjectId int) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_GetForeignKeyRefColumns-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_GetForeignKeyRefColumns](
    @ConstraintObjectId INT
)
RETURNS TABLE
AS
RETURN SELECT STUFF((
                 SELECT ','+QUOTENAME(rci.name) FROM sys.foreign_key_columns c
                   JOIN sys.columns rci
                  ON rci.object_id = c.referenced_object_id
                  AND rci.column_id = c.referenced_column_id
                   WHERE @ConstraintObjectId = c.constraint_object_id
                   FOR XML PATH(''),TYPE
                   ).value('.','NVARCHAR(MAX)'),1,1,'')  AS ColNames;
GO