--liquibase formatted sql

--changeSet func:Initial-tSQLt-Info-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Info', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[Info]() RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-Info-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER FUNCTION  [tSQLt].[Info]()
RETURNS TABLE
AS
RETURN
SELECT
Version = '1.0.5137.39257',
ClrVersion = (SELECT tSQLt.Private::Info());
---Build-
GO