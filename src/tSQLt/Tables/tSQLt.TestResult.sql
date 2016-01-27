--liquibase formatted sql

--changeSet peter.h:tsqlt-intallation endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
CREATE TABLE [tSQLt].[TestResult]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Class] [nvarchar] (max) COLLATE Finnish_Swedish_CI_AS NOT NULL,
[TestCase] [nvarchar] (max) COLLATE Finnish_Swedish_CI_AS NOT NULL,
[Name] AS ((quotename([Class])+'.')+quotename([TestCase])),
[TranName] [nvarchar] (max) COLLATE Finnish_Swedish_CI_AS NOT NULL,
[Result] [nvarchar] (max) COLLATE Finnish_Swedish_CI_AS NULL,
[Msg] [nvarchar] (max) COLLATE Finnish_Swedish_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [tSQLt].[TestResult] ADD CONSTRAINT [PK__TestResu__3214EC07B30EA23E] PRIMARY KEY CLUSTERED  ([Id]) ON [PRIMARY]
GO
