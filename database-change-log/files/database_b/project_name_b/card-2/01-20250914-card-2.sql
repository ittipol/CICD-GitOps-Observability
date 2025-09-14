-- liquibase formatted sql

-- changeset user-2:20250914-01-1 labels:release_2025_nov,team-3,card-2,01-1 contexts:dev,test
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