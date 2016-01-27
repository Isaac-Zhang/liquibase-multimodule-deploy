--liquibase formatted sql

--changeSet peter.h:tsqlt-intallation endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
CREATE SCHEMA [tSQLt]
AUTHORIZATION [dbo]
GO
