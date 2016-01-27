--liquibase formatted sql

--changeSet func:Initial-tSQLt-F_Num-0 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false
IF OBJECT_ID('tSQLt.F_Num', 'IF') IS NULL EXEC('CREATE FUNCTION [tSQLt].[F_Num](@N int) RETURNS TABLE AS RETURN (SELECT ret = 1)')
GO



--changeSet func:Initial-tSQLt-F_Num-1 endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:true
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
ALTER FUNCTION  [tSQLt].[F_Num](
       @N INT
)
RETURNS TABLE 
AS 
RETURN WITH C0(c) AS (SELECT 1 UNION ALL SELECT 1),
            C1(c) AS (SELECT 1 FROM C0 AS A CROSS JOIN C0 AS B),
            C2(c) AS (SELECT 1 FROM C1 AS A CROSS JOIN C1 AS B),
            C3(c) AS (SELECT 1 FROM C2 AS A CROSS JOIN C2 AS B),
            C4(c) AS (SELECT 1 FROM C3 AS A CROSS JOIN C3 AS B),
            C5(c) AS (SELECT 1 FROM C4 AS A CROSS JOIN C4 AS B),
            C6(c) AS (SELECT 1 FROM C5 AS A CROSS JOIN C5 AS B)
       SELECT TOP(CASE WHEN @N>0 THEN @N ELSE 0 END) ROW_NUMBER() OVER (ORDER BY c) no
         FROM C6;
GO