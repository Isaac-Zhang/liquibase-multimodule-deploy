--liquibase formatted sql

--changeSet peter.h:tsqlt-intallation endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false

CREATE TABLE [tSQLt].[Private_ExpectException]
(
[i] [int] NULL
) ON [PRIMARY]
GO
