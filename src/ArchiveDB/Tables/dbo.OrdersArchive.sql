--liquibase formatted sql

--changeSet peter.h:Create-OrdersArchive-Table endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false

CREATE TABLE [dbo].[OrdersArchive]
(
	CustomerID  int NOT NULL,
	Amount  decimal(19,6) not null,
	ModifiedOn datetime2
);