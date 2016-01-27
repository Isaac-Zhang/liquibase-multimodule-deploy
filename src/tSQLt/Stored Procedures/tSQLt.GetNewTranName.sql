--liquibase formatted sql

--changeSet proc:Initial-tSQLt-GetNewTranName-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.GetNewTranName', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[GetNewTranName] @TranName char(32) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-GetNewTranName-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[GetNewTranName]
  @TranName CHAR(32) OUTPUT
AS
BEGIN
  SELECT @TranName = LEFT('tSQLtTran'+REPLACE(CAST(NEWID() AS NVARCHAR(60)),'-',''),32);
END;
GO