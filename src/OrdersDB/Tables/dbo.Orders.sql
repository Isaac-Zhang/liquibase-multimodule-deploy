--liquibase formatted sql

--changeSet peter.h:Create-Orders-Table endDelimiter:\nGO splitStatements:true stripComments:false runOnChange:false

CREATE TABLE [dbo].[Orders]
(
	OrderID int identity(1, 1) constraint [PK_Orders] primary key,
	Amount  decimal(19,6) not null
);