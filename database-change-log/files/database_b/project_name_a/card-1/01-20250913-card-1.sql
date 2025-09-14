-- liquibase formatted sql

-- changeset author-name:20250913-01-1 labels:release_2025_sep,team-2,card-1,01-1 contexts:dev,test
-- comment: create users table
CREATE TABLE users
(
    id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL
);
/* liquibase rollback
DROP TABLE "users";
*/

-- changeset author-name:20250913-01-2 labels:release_2025_sep,team-2,card-1,01-2 contexts:dev,test
-- comment: create addresses table
CREATE TABLE addresses
(
    id INTEGER PRIMARY KEY NOT NULL,
    description TEXT NOT NULL
);
/* liquibase rollback
DROP TABLE "addresses";
*/