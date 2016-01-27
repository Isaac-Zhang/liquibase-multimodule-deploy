--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetDefaultConstraintDefinition-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetDefaultConstraintDefinition', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetDefaultConstraintDefinition](@ObjectId int,@ColumnId int,@ReturnDetails bit) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_GetDefaultConstraintDefinition-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_GetDefaultConstraintDefinition](@ObjectId INT, @ColumnId INT, @ReturnDetails BIT)
RETURNS TABLE
AS
RETURN SELECT 
              COALESCE(IsDefault, 0) AS IsDefault,
              COALESCE(DefaultDefinition, '') AS DefaultDefinition
        FROM (SELECT 1) X(X)
        LEFT JOIN (SELECT 1 AS IsDefault,' DEFAULT '+ definition AS DefaultDefinition,parent_object_id,parent_column_id
                     FROM sys.default_constraints
                  )dc
               ON dc.parent_object_id = @ObjectId
              AND dc.parent_column_id = @ColumnId
              AND @ReturnDetails = 1;               
---Build-
GO