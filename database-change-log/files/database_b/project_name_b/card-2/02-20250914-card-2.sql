-- liquibase formatted sql

-- changeset user-1:20250914-02-1 labels:release_2025_nov,team-3,card-2,02-1 contexts:dev,test
-- comment: create customers table
CREATE TABLE customers
(
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL
);
/* liquibase rollback
DROP TABLE "customers";
*/

-- changeset user-1:20250914-02-2 labels:release_2025_nov,team-3,card-2,02-2 contexts:dev,test
-- comment: create orders table
CREATE TABLE orders
(
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
/* liquibase rollback
DROP TABLE "orders";
*/