--liquibase formatted sql

--changeSet peter.h:tsqlt-intallation endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [tSQLt].[Tests]
AS
  SELECT classes.SchemaId, classes.Name AS TestClassName, 
         procs.object_id AS ObjectId, procs.name AS Name
    FROM tSQLt.TestClasses classes
    JOIN sys.procedures procs ON classes.SchemaId = procs.schema_id
   WHERE LOWER(procs.name) LIKE 'test%';
GO
