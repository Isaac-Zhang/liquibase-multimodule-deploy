--liquibase formatted sql

--changeSet proc:Initial-tSQLt-DropClass-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.DropClass', 'P') IS NULL EXEC('CREATE PROCEDURE [tSQLt].[DropClass] @ClassName nvarchar(MAX) AS BEGIN SELECT ret = 1 END')
GO



--changeSet proc:Initial-tSQLt-DropClass-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
ALTER PROCEDURE [tSQLt].[DropClass]
    @ClassName NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Cmd NVARCHAR(MAX);

    WITH A(name, type) AS
           (SELECT QUOTENAME(SCHEMA_NAME(schema_id))+'.'+QUOTENAME(name) , type
              FROM sys.objects
             WHERE schema_id = SCHEMA_ID(@ClassName)
          ),
         B(no,cmd) AS
           (SELECT 0,'DROP ' +
                    CASE type WHEN 'P' THEN 'PROCEDURE'
                              WHEN 'PC' THEN 'PROCEDURE'
                              WHEN 'U' THEN 'TABLE'
                              WHEN 'IF' THEN 'FUNCTION'
                              WHEN 'TF' THEN 'FUNCTION'
                              WHEN 'FN' THEN 'FUNCTION'
                              WHEN 'V' THEN 'VIEW'
                     END +
                   ' ' + name + ';'
              FROM A
             UNION ALL
            SELECT -1,'DROP SCHEMA ' + QUOTENAME(name) +';'
              FROM sys.schemas
             WHERE schema_id = SCHEMA_ID(@ClassName)
           ),
         C(xml)AS
           (SELECT cmd [text()]
              FROM B
             ORDER BY no DESC
               FOR XML PATH(''), TYPE
           )
    SELECT @Cmd = xml.value('/', 'NVARCHAR(MAX)') 
      FROM C;

    EXEC(@Cmd);
END;
---Build-
GO