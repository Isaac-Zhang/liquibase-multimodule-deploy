--liquibase formatted sql

--changeSet peter.h:Create-Customer-Table endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false

CREATE TABLE [dbo].[Customer]
(
	CustomerID int identity(1, 1) constraint [PK_Customer] primary key,
	Name varchar(500)
);