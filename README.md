# Multi-module and Multi-database deployment using Liquibase
Multimodule and Multidatabase deployment using Liquibase 

This demo is developed for Microsoft Sql Server but is easily adjusted to work for Postgres or Mysql.

# To deploy all modules:
Execute from the \src directory:

''''mvn install -Ddatabase.server=localhost -Ddatabase.username=liquibase -Ddatabase.password=liquibase''''

# To deploy a single module:
Execute the same command from the root of the module directory (For example in \src\ArchiveDB\):

'''mvn install -Ddatabase.server=localhost -Ddatabase.username=liquibase -Ddatabase.password=liquibase'''


# Prerequisites
* Maven installed and preferably in your PATH.
* The databases must exist and be located on the same server (CustomerDB, OrdersDB and ArchiveDB).
* You must have a logon/user with permissions to create tables etc (will probably need sysadmin for production use).

# Easily customizable for other DBMS. 
Simply edit the jdbc-url and the the jdbc driver to match Postgres or Mysql.
