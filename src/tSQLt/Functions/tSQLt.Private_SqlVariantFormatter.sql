--liquibase formatted sql

--changeSet func:Initial-tSQLt-Private_SqlVariantFormatter-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Private_SqlVariantFormatter', 'FN') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Private_SqlVariantFormatter](@Value sql_variant) RETURNS int AS BEGIN RETURN 1 END')
GO



--changeSet func:Initial-tSQLt-Private_SqlVariantFormatter-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER FUNCTION  [tSQLt].[Private_SqlVariantFormatter](@Value SQL_VARIANT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
  RETURN CASE UPPER(CAST(SQL_VARIANT_PROPERTY(@Value,'BaseType')AS sysname))
           WHEN 'FLOAT' THEN CONVERT(NVARCHAR(MAX),@Value,2)
           WHEN 'REAL' THEN CONVERT(NVARCHAR(MAX),@Value,1)
           WHEN 'MONEY' THEN CONVERT(NVARCHAR(MAX),@Value,2)
           WHEN 'SMALLMONEY' THEN CONVERT(NVARCHAR(MAX),@Value,2)
           WHEN 'DATE' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'DATETIME' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'DATETIME2' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'DATETIMEOFFSET' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'SMALLDATETIME' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'TIME' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'BINARY' THEN CONVERT(NVARCHAR(MAX),@Value,1)
           WHEN 'VARBINARY' THEN CONVERT(NVARCHAR(MAX),@Value,1)
           ELSE CAST(@Value AS NVARCHAR(MAX))
         END;
END
---Build-
GO