# Multi-module and Multi-database deployment using Liquibase
Multimodule and Multidatabase deployment using Liquibase 

The purpose of this repo is to show how it is possible to handle multi module deployments of Liquibase using maven.
A multi module database solution could be - either several databases - or - using schemas to separate the modules. Each module can be developed, released and deployed independently.

This current setup uses several databases to separate the modules. Each database have their own folder inside the repo where their objects can be managed.

This demo is developed for Microsoft Sql Server but is easily adjusted to work for Postgres or Mysql etc.
You would need to change the driver, url and make sure the sql scripts work on your DBMS.

# To deploy all modules:
Execute from the \src directory:

```Batchfile
mvn install -Ddatabase.server=localhost -Ddatabase.username=liquibase -Ddatabase.password=liquibase
```

# To deploy a single module:
Execute the same command from the root of the module directory (For example in \src\ArchiveDB\):

```Batchfile
mvn install -Ddatabase.server=localhost -Ddatabase.username=liquibase -Ddatabase.password=liquibase
```

# To build and install tsqlt into your local repository.
(The tSQLt module is then available for the rest of the modules.)
Execute from the /src/tsqlt directory:

```Batchfile
mvn install
```

You can then install tSQLt on the modules by running maven using the unit-tests profile.
You can do this on individual modules or on the parent pom to install on all of the modules.

```Batchfile
mvn install -Ddatabase.server=localhost -Ddatabase.username=liquibase -Ddatabase.password=liquibase -Punit-tests
```

# Prerequisites
* Maven installed and preferably in your PATH.
* JAVA_HOME set to a correct java JRE path [http://www.peterhenell.se/msg/Batch---Automatically-set-JAVA_HOME-to-current-installed-version-of-java]
* The databases must exist and be located on the same server (CustomerDB, OrdersDB and ArchiveDB).
* You must have a logon/user with permissions to create tables etc (will probably need sysadmin for production use).

## Additional prerequisites for MSSQL:
* TCP-IP must be enabled
* The server must be in mixed mode (SQL Server and Windows Authentication)

# Easily customizable for other DBMS. 
Simply edit the jdbc-url and the the jdbc driver to match Postgres or Mysql.
