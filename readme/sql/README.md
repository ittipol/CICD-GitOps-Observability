# SQL

## Difference Between Clustered and Non-Clustered Index

**Clustered Index**
- A clustered Index is most suitable for column that are frequently used for range-based queries, such as date or sequential ID columns, as it provides efficient data retrieval for these types of queries
- A table can have only one clustered index
- Faster for range-based queries and sorting

**Non-Clustered Index**
- Non-Clustered Index are useful when you need to improve the performance of specific queries that involve columns not covered by the clustered index or when you frequently search for values in a particular column like name column
- A table can have multiple non-clustered indexes
- The non-clustered index stores the index structure (B-tree) on disk with pointers to the data pages
- Slower for range-based queries but faster for specific lookups
- Suitable for optimizing lookups and queries on non-primary columns

## Syntax
### Index
``` sql
CREATE INDEX idx_name ON table(column);
```

### Partition
``` sql
PARTITION BY RANGE(column)
```

### Dry run
**Before you execute your script**
``` sql
BEGIN TRANSACTION transaction_name;
```

**After you execute your script and have done your checking**
``` sql
-- Every change in your script will then be undone
ROLLBACK TRANSACTION transaction_name;
```
Make sure you don't have a `COMMIT` in your script

``` sql
CREATE TABLE users (ID INT, name varchar(100));
BEGIN TRANSACTION;
    INSERT INTO user (ID, name) VALUES (123, 'AAA');
    INSERT INTO user (ID, name) VALUES (124, 'BBB');
ROLLBACK;
```

**Use `TRANSACTION` with `try/catch`**
``` sql
BEGIN TRANSACTION Tran1

  BEGIN TRY

      INSERT INTO user (ID, name)
      VALUES (123, 'AAA'), (124, 'BBB')

      UPDATE products
      SET name = 'CCC', description = 'ABCDEF'
      WHERE category_id = 456;

      COMMIT TRANSACTION Tran1

  END TRY

  BEGIN CATCH

      ROLLBACK TRANSACTION Tran1

  END CATCH 
```

**Commit a transaction**
``` sql
BEGIN TRANSACTION;
    UPDATE products
        SET name = 'CCC', description = 'ABCDEF'
        WHERE category_id = 456;
COMMIT;
```