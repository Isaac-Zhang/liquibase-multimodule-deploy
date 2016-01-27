--liquibase formatted sql

--changeSet peter.h:tsqlt-intallation endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false

CREATE TABLE [tSQLt].[Run_LastExecution]
(
[TestName] [nvarchar] (max) COLLATE Finnish_Swedish_CI_AS NULL,
[SessionId] [int] NULL,
[LoginTime] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
