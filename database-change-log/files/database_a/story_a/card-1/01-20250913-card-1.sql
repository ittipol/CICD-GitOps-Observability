-- liquibase formatted sql

-- changeset author-name:20250913-01-1 labels:release_2025_dec,team-1,card-1,01-1 contexts:dev,test
-- comment: create products table
CREATE TABLE products
(
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(5,2) NOT NULL,
    stock INTEGER NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
/* liquibase rollback
DROP TABLE "products";
*/

-- changeset author-name:20250913-01-2 labels:release_2025_dec,team-1,card-1,01-2 contexts:dev,test
-- comment: create customers table
CREATE TABLE customers
(
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL
);
/* liquibase rollback
DROP TABLE "customers";
*/