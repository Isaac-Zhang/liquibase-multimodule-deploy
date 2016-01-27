--liquibase formatted sql

--changeSet proc:Initial-tSQLt-AssertResultSetsHaveSameMetaData-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true

CREATE PROCEDURE [tSQLt].[AssertResultSetsHaveSameMetaData] (@expectedCommand [nvarchar] (max), @actualCommand [nvarchar] (max))
WITH EXECUTE AS CALLER
AS EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[AssertResultSetsHaveSameMetaData]
GO