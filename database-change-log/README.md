## Formatted SQL

### Changeset
**Folder structure**

- <env\-folder>
  - database_a
    - config
      - liquibase.changelog.yml
      - liquibase.properties
    - migrations
      - <project\-name> or <story\-card\-number>
        - <task\-id> or <card\-number> (task in story or task in project)
          - <execution\-order>\-YYYYMMDD\-<card\-number>.sql (changeset)
  - database_b
    - config
      - liquibase.changelog.yml
      - liquibase.properties
    - migrations
      - project_name_a
        - card-456
          - 01-20251025-card-456.sql
          - 02-20251025-card-456.sql
          - 03-20251028-card-456.sql
      - project_name_b
        - card-789
          - 01-20251205-card-789.sql
          - 02-20251207-card-789.sql
  - <database\-name>
    - config
      - liquibase.changelog.yml
      - liquibase.properties
    - migrations
      - ...
        - ...
          - ...
          - ...
          - ...
      - ...
        - ...
          - ...

**File naming convention**
- <execution\-order>\-YYYYMMDD\-<card\-number>.sql
- e.g., 01-20250915-card-1.sql

**Changeset infomation**
``` sql
-- e.g.,
-- changeset <author-name>:<changeset-id> labels:<card-number>,<card-number>-<01...n>,<card-number>-<01...n>-<1...n> contexts:dev,test

-- changeset <author-name>:<changeset-id> labels:<card-number>,<card-number>-<01...n>,<card-number>-<01...n>-<1...n> contexts:production
```

- changeset id
  - YYYYMMDD\-<card\-number>\-<execution\-order>\-<changeset\-order>
  - e.g., 20250913-card-1-01-2
- label patterns
  - <card\-number>,<card\-number>\-<execution\-order>,<card\-number>\-<execution\-order>\-<changeset\-order>
  - e.g., card-456,card-456-01,card-456-01-1

### Programming Naming
- Camel Case: projectName
- Pascal Case: ProjectName
- Snake Case: project_name
- Kebab Case: project-name