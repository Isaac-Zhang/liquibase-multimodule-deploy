--liquibase formatted sql

--changeSet proc:Initial-tSQLt-Uninstall-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.Uninstall', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[Uninstall]  AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-Uninstall-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER PROCEDURE [tSQLt].[Uninstall]
AS
BEGIN
  DROP TYPE tSQLt.Private;

  EXEC tSQLt.DropClass 'tSQLt';  
  
  DROP ASSEMBLY tSQLtCLR;
END;
GO