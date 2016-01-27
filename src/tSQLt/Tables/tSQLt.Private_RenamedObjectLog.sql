--liquibase formatted sql

--changeSet peter.h:tsqlt-intallation endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false

CREATE TABLE [tSQLt].[Private_RenamedObjectLog]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[ObjectId] [int] NOT NULL,
[OriginalName] [nvarchar] (max) COLLATE Finnish_Swedish_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [tSQLt].[Private_RenamedObjectLog] ADD CONSTRAINT [PK__Private_RenamedObjectLog__Id] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
