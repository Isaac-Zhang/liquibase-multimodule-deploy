--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Private_CreateResultTableForCompareTables-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_CreateResultTableForCompareTables', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Private_CreateResultTableForCompareTables] @ResultTable nvarchar(MAX),@ResultColumn nvarchar(MAX),@BaseTable nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Private_CreateResultTableForCompareTables-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---BUILD+
ALTER PROCEDURE [tSQLt].[Private_CreateResultTableForCompareTables]
 @ResultTable NVARCHAR(MAX),
 @ResultColumn NVARCHAR(MAX),
 @BaseTable NVARCHAR(MAX)
AS
BEGIN
  DECLARE @Cmd NVARCHAR(MAX);
  SET @Cmd = '
     SELECT ''='' AS ' + @ResultColumn + ', Expected.* INTO ' + @ResultTable + ' 
       FROM tSQLt.Private_NullCellTable N 
       LEFT JOIN ' + @BaseTable + ' AS Expected ON N.I <> N.I 
     TRUNCATE TABLE ' + @ResultTable + ';' --Need to insert an actual row to prevent IDENTITY property from transfering (IDENTITY_COL can't be NULLable);
  EXEC(@Cmd);
END
---BUILD-
GO