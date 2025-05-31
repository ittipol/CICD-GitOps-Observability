# Rebase

``` bash
git fetch origin main

git checkout main

git pull origin main

git checkout feature-branch

# Optional, Create a backup of feature branch
git checkout -b feature-branch-backup
# or
git branch feature-branch-backup

git rebase origin/main
```

**If merge conflicts exist**

``` bash
# Resolve the conflicts
code .

git add .

# Continue the rebase
git rebase --continue
```

**Cancel merge conflict**

``` bash
git rebase --abort
```

**Force push your changes to the target branch**

``` bash
git push origin feature-branch --force-with-lease
```