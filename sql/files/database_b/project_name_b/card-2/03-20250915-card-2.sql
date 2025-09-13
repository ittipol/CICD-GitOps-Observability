-- liquibase formatted sql

-- changeset user-3:20250915-03-1 labels:release_2025_nov,team-3,card-2,03-1 contexts:dev,test
-- comment: create carts table
CREATE TABLE carts
(
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
/* liquibase rollback
DROP TABLE "carts";
*/