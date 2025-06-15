# Merge conflict

``` bash
git fetch origin main

git checkout main

git pull origin main

git checkout feature-branch

git merge main

# Resolve the conflicts

# Add resolved file in staging area
git add <filename>

# To modify the commit message
git commit

# To complete the merge
git merge --continue

# To cancel the merge
git merge --abort
```