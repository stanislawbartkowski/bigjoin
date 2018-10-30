# Simple test to present the power of partiton elimination in BigSQL

## Test scenario

1. Create a simple dimension table containing a subset of values.
1. Create a huge non-partitoned table.
1. Run a join query between non-partitioned table and dimension table and get the execution time.
1. Create an indentical huge table but partitoned.
1. Run identical join query between partitioned table and dimension table and get the execution time.
1. The execution time for the second query should be much better.

## File description
|| File || Description
------------ | -------------
bigsqltest.rc | Property file, should be configured before running the query
bigsqltest.sh | Contains bash shell code for the test
createdimtable.sql | Template for SQL DDL statement to create a dimension table.
createnonpartitionedtable.sql | Template for SQL DDL statemant to create a nonpartitioned table.
createpartitionedtable.sql | Template for SQL DDL statement to create a partitioned table.
droptable.sql | SQL DML statement to drop the tables before recreation.
insertrows.sql | SQL DML statement to insert rows into hige tables. The same code is used to populate partitoned and nonpartitioned table.
runnonquery.sql | Template SQL DML statement containing join query. The same query is used for both joins.
run.sh | The executable bash file for bigsqltest.sh

## Prerequisties

The test can be executed using local or remote connection. For remote connection a DB2 client should be installed and access to remote BigSQL instance should be cataloged and working.

## Configuration

Modify bigsqltest.rc property file
```bash
#BIGSQLUSER=bigsql
#BIGSQLPASSWORD=bigsql

BIGSQLUSER=sb
BIGSQLPASSWORD=secret123?

#TABLESTORAGE="STORED AS PARQUETFILE"
TABLESTORAGE="STORED AS ORC"

#BIGSQLSIZE1=5000
BIGSQLSIZE1=50000000
#BIGSQLSIZE1=100000000
#BIGSQLSIZE1=200000000
#BIGSQLSIZE1=500000000
#BIGSQLSIZE1=2000000000

BIGSQLDIMTABLE=monit.testdim

BIGSQLTABLE1=monit.testnon
BIGSQLTABLE2=monit.testpart
```
Parameter name | Description | Sample value
------------ | ------------- | ---
BIGSQLUSER | User name for remote connection. For local connection should be commented out  |
BIGSQLPASSWORD | User password for remote connection. For local connection should be commented out
TABLESTORAGE | Storage type for Hive table | "STORED AS PARQUETFILE"
BIGSQLSIZE1 | Number of rows created in huge table | 50000000
BIGSQLDIMTABLE | The name of dimension table | monit.testdim
BIGSQLTABLE1 | The name of non-partitoned table | monit.testnon
BIGSQLTABLE2 | The name of non-partitoned table | monit.testpart

## Run the test

Modify the run.sh file and execute.

Step | Action 
----- | -----
./bigsqltest.sh dimtable | Create dimension table
./bigsqltest.sh nontable | Create huge non-partitioned table
./bigsqltest.sh nonquery | Run join query against non-partitoned table and get the time
./bigsqltest.sh parttable | Create a huge partitoned table
./bigsqltest.sh partquery | Run a join query against partitoned table and get the time

Compare both execution times and be amazed by the power of BigSQL !

