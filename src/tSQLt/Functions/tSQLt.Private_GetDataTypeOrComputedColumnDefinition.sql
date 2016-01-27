--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_GetDataTypeOrComputedColumnDefinition-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_GetDataTypeOrComputedColumnDefinition', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_GetDataTypeOrComputedColumnDefinition](@UserTypeId int,@MaxLength int,@Precision int,@Scale int,@ObjectId int,@ColumnId int,@ReturnDetails bit,@CollationName nvarchar(MAX)) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Private_GetDataTypeOrComputedColumnDefinition-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[Private_GetDataTypeOrComputedColumnDefinition](@UserTypeId INT, @MaxLength INT, @Precision INT, @Scale INT, @CollationName NVARCHAR(MAX), @ObjectId INT, @ColumnId INT, @ReturnDetails BIT)
RETURNS TABLE
AS
RETURN SELECT 
              COALESCE(IsComputedColumn, 0) AS IsComputedColumn,
              COALESCE(ComputedColumnDefinition, TypeName) AS ColumnDefinition
        FROM tSQLt.Private_GetFullTypeName(@UserTypeId, @MaxLength, @Precision, @Scale, @CollationName)
        LEFT JOIN (SELECT 1 AS IsComputedColumn,' AS '+ definition + CASE WHEN is_persisted = 1 THEN ' PERSISTED' ELSE '' END AS ComputedColumnDefinition,object_id,column_id
                     FROM sys.computed_columns 
                  )cc
               ON cc.object_id = @ObjectId
              AND cc.column_id = @ColumnId
              AND @ReturnDetails = 1;               
---Build-
GO