--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetForeignKeyParColumns-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetForeignKeyParColumns', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetForeignKeyParColumns](@ConstraintObjectId int) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_GetForeignKeyParColumns-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER FUNCTION  [tSQLt].[Private_GetForeignKeyParColumns](
    @ConstraintObjectId INT
)
RETURNS TABLE
AS
RETURN SELECT STUFF((
                 SELECT ','+QUOTENAME(pci.name) FROM sys.foreign_key_columns c
                   JOIN sys.columns pci
                   ON pci.object_id = c.parent_object_id
                  AND pci.column_id = c.parent_column_id
                   WHERE @ConstraintObjectId = c.constraint_object_id
                   FOR XML PATH(''),TYPE
                   ).value('.','NVARCHAR(MAX)'),1,1,'')  AS ColNames
GO