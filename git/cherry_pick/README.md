# Cherry pick

``` bash
# Switch to current branch
git checkout develop

# View the commit history in feature branch
git log feature-branch

# Copy a specific commit hash in feature branch
# Cherry pick a commit hash
git cherry-pick <commit hash>

# To cherry-pick multiple commits
git cherry-pick commit1 commit2 commit3 commit4 commit5
```

**cherry-pick multiple commits example**
``` bash
# e.g.,
git cherry-pick commit n ... commit1 commit2

# After run cherry-pick multiple commits process
# In working tree
commit2 (HEAD)
commit1
.
.
.
commit n
```

**Conflicts**
``` bash
# After Resolve the conflicts

git status

# Add resolved file in staging area
git add <filename>

# To complete the cherry-pick process
git cherry-pick --continue

# vim
# To write (save) and quit
:wq

# To skip this commit
git cherry-pick --skip

# To cancel the cherry-pick process and get back to the state before "git cherry-pick"
git cherry-pick --abort
```