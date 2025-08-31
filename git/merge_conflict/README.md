# Merge conflict

``` bash
git fetch origin main

git checkout main

git pull origin main

git checkout feature-branch

git merge main

# Add resolved file in staging area
git add <filename>

# ======== After resolving the conflict

# To modify the commit message
git commit

# To complete the merge
git merge --continue

# To cancel the merge
git merge --abort
```

## deleted by them
### Resolving a "deleted by them" conflict
**There are 2 options to resolve this conflict**

To keep the file (accept your changes)
``` bash
git add <file_path>
```

To delete the file (accept their deletion)
``` bash
git rm <file_path>
```