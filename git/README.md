# Git

## Undoing Your Last Commit (That Has Not Been Pushed) (keep commit)
``` bash
git reset --soft HEAD~

# To undo the last 2 commits (assuming both have not been pushed)
git reset --soft HEAD~2
```

## Undoing Your Last Commit (That Has Not Been Pushed) (Discard commit)
``` bash
git reset --hard HEAD~1

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