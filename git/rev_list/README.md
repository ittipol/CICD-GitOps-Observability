# rev-list

**list all commits in the current branch**
``` bash
git rev-list --all

git rev-list HEAD

# limit the output to the last 10 commits
git rev-list -n 10 --all

# list only non-merge commits
git rev-list --no-merges HEAD

git rev-list --no-merges HEAD -n 10

# list commits by a specific author
git rev-list --author="<name>" HEAD
```

**list all commits in a specific branch**
``` bash
git rev-list <branch>
```

**Commit formatting** \
`<format>`: oneline, short, medium, full, fuller, reference, email, raw, format:<string> and tformat:<string>
``` bash
--oneline
--pretty[=<format>]
--format=<format>
```
``` bash
git rev-list --no-merges HEAD -n 20 --oneline

git rev-list --no-merges HEAD -n 20 --pretty

git rev-list --no-merges HEAD -n 20 --pretty=oneline --no-abbrev-commit

git rev-list --author="<name>" --all -n 10 --format=short --graph --date-order

git rev-list --no-merges HEAD -n 20 --format=medium --graph

git rev-list --no-merges --all --author="<name>" -n 10 --format=full --graph --date-order
```

**Date formatting**
``` bash
git rev-list --no-merges HEAD -n 20 --format=medium --graph --date=human

git rev-list --no-merges HEAD -n 20 --format=medium --graph --date=short

git rev-list --no-merges HEAD -n 20 --format=medium --graph --date=raw

git rev-list --no-merges HEAD -n 20 --format=medium --graph --date=unix

git rev-list --no-merges HEAD -n 20 --format=medium --graph --date=local

git rev-list --no-merges HEAD -n 20 --format=medium --graph --date=iso8601
```