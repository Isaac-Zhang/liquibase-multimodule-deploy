--liquibase formatted sql

--changeSet peter.h:Create-CustomerArchive-Table endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false

CREATE TABLE [dbo].[CustomerArchive]
(
	CustomerID int NOT NULL,
	Name varchar(500),
	ModifiedOn datetime2
);