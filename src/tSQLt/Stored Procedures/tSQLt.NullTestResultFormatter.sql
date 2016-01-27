--liquibase formatted sql

--changeSet proc:Initial-tSQLt-NullTestResultFormatter-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.NullTestResultFormatter', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[NullTestResultFormatter]  AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-NullTestResultFormatter-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[NullTestResultFormatter]
AS
BEGIN
  RETURN 0;
END;
GO