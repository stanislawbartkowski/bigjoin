# Simple test to present the power of partiton elimination in BigSQL

## Test scenario

1. Create a simple dimension table containing a subset of values.
1. Create a huge non-partitoned table.
1. Run a join query for non-partitioned table and dimension table and get the execution time.
1. Create a huge partitoned table.
1. Run identical join query for partitioned table and dimension table and get the execution time.
1. The execution time for the second query should be much better.

## File description
* bigsqltest.rc Property file, should be configured before running the query
* bigsqltest.sh Contains bash shell code for the test
* createdimtable.sql Template for SQL DDL statement to create a dimension table.
* createnonpartitionedtable.sql Template for SQL DDL statemant to create a nonpartitioned table.
* createpartitionedtable.sql Template for SQL DDL statement to create a partitioned table.
* droptable.sql SQL DML statement to drop the tables before recreation.
* insertrows.sql SQL DML statement to insert rows into hige tables. The same code is used to populate partitoned and nonpartitioned table.
* runnonquery.sql Template SQL DML statement containing join query. The same query is used for both joins.
* run.sh The executable bash file for bigsqltest.sh

## Configuration
