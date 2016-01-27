--liquibase formatted sql

--changeSet proc:Initial-tSQLt-SetTestResultFormatter-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.SetTestResultFormatter', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[SetTestResultFormatter] @Formatter nvarchar(4000) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-SetTestResultFormatter-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[SetTestResultFormatter]
    @Formatter NVARCHAR(4000)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM sys.extended_properties WHERE [name] = N'tSQLt.ResultsFormatter')
    BEGIN
        EXEC sp_dropextendedproperty @name = N'tSQLt.ResultsFormatter',
                                    @level0type = 'SCHEMA',
                                    @level0name = 'tSQLt',
                                    @level1type = 'PROCEDURE',
                                    @level1name = 'Private_OutputTestResults';
    END;

    EXEC sp_addextendedproperty @name = N'tSQLt.ResultsFormatter', 
                                @value = @Formatter,
                                @level0type = 'SCHEMA',
                                @level0name = 'tSQLt',
                                @level1type = 'PROCEDURE',
                                @level1name = 'Private_OutputTestResults';
END;
GO