--liquibase formatted sql

--changeSet func:Initial-tSQLt-GetTestResultFormatter-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.GetTestResultFormatter', 'FN') IS NULL EXEC('CREATE FUNCTION [tSQLt].[GetTestResultFormatter]() RETURNS int AS BEGIN RETURN 1 END')
GO



--changeSet func:Initial-tSQLt-GetTestResultFormatter-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[GetTestResultFormatter]()
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @FormatterName NVARCHAR(MAX);
    
    SELECT @FormatterName = CAST(value AS NVARCHAR(MAX))
    FROM sys.extended_properties
    WHERE name = N'tSQLt.ResultsFormatter'
      AND major_id = OBJECT_ID('tSQLt.Private_OutputTestResults');
      
    SELECT @FormatterName = COALESCE(@FormatterName, 'tSQLt.DefaultResultFormatter');
    
    RETURN @FormatterName;
END;
GO