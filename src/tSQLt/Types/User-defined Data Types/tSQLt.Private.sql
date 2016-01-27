--liquibase formatted sql

--changeSet peter.h:tsqlt-intallation endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false

CREATE TYPE [tSQLt].[Private]
EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.tSQLtPrivate]
GO
