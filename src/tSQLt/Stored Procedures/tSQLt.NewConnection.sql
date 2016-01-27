--liquibase formatted sql

--changeSet proc:Initial-tSQLt-NewConnection-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO
CREATE PROCEDURE [tSQLt].[NewConnection] (@command [nvarchar] (max))
WITH EXECUTE AS CALLER
AS EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[NewConnection]
GO