# Undo commit

## Undoing a last commit (That Has Not Been Pushed) (keep commit)
``` bash
git reset --soft HEAD~

# To undo the last 2 commits (assuming both have not been pushed)
git reset --soft HEAD~2
```

## Undoing a last remote commit (That Has Been Pushed) (Discard commit)
``` bash
git reset --hard HEAD~1

# git reset --hard HEAD~n

git push --force <remote> <branch>
```