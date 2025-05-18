# Git

## Undoing Your Last Commit (That Has Not Been Pushed) (keep commit)
``` bash
git reset --soft HEAD~

# To undo the last 2 commits (assuming both have not been pushed)
git reset --soft HEAD~2
```

### Cherry pick a commit from other branch and edit in current branch before commit and push to remote branch
``` bash
# Assume there 2 branch
# 1. develop
# 2. feature

# Switch to current branch
git checkout develop

# View the commit history in feature branch
git log feature

# Copy a specific commit hash in feature branch
# Cherry pick a commit hash
git cherry-pick <commit hash>

# Reset last commit in current branch
git reset --soft HEAD~

# All files in last commit will be in staging area
git status

# When edit complete then run git add
git add .

# Commit
git commit -m "message"

# Push to remote repository
git push {remote} {branch}
```

## Undoing Your Last Remote Commit (That Has Been Pushed) (Discard commit)
``` bash
git reset --hard HEAD~1

# git reset --hard HEAD~n

git push --force {remote} {branch}
```

## Undoing a Specific Commit (That Has Been Pushed)
- The --no-edit option prevents git from asking you to enter in a commit message. If you don't add that option, you'll end up in the VIM text editor. To exit VIM, press : to enter command mode, then q for quit
``` bash
git revert {commit_hash} --no-edit
```

## Commit and push code
``` bash
git add .

git commit -m "{message}"

git push {remote} {branch}
```

## Pull code
**git pull is shorthand for git fetch + git merge**
``` bash
git pull {remote} {branch}

git pull --ff {remote} {branch}

git pull --ff-only {remote} {branch}

git pull --rebase {remote} {branch}
```

## Fetch and checkout
``` bash
git fetch

git checkout {branch_name}
```

## Create new branch
``` bash
git checkout -b {new_branch_name}
```

## Show changes between the working tree and the index or a tree
``` bash
git diff

git diff HEAD~1

git diff --stat

git diff --numstat

git diff --name-status
```

## Show changes in commit 
``` bash
git show {commit_hash}

git show {commit_hash} --compact-summary

git show --color --pretty=format:%b {commit_hash}

git show HEAD
```

## Show the commit logs
``` bash
git log

git log --oneline

git log --graph

git log --oneline --graph
```

## Stash the changes
``` bash
git stash

git stash -m "message"

git stash list

git stash pop
```

## Add file contents to the index
``` bash
git add .

git add {file_name}
```

## Restore working tree files
``` bash
git restore .

git restore {file_name}
```

## Remove untracked files from the working tree
``` bash
# Dry run
git clean -n

git clean -f
```

## Cherry pick
``` bash
git checkout <branch>

# Apply the changes introduced by the commit_1, commit_2 and commit_n commits and create a new commits with these changes
git cherry-pick <commit_1> <commit_2> <commit_n>

git cherry-pick (--continue | --skip | --abort | --quit)
```

## Undo merge conflict
**If a merge has conflict**
``` bash
# Use for cancel merge
git merge --abort

# Use for cancel rebase
git rebase --abort
```