# Git

## Undoing Your Last Commit (That Has Not Been Pushed)
``` bash
git reset --soft HEAD~

# To undo the last 2 commits (assuming both have not been pushed)
git reset --soft HEAD~2
```

## Undoing a Specific Commit (That Has Been Pushed)
- The --no-edit option prevents git from asking you to enter in a commit message. If you don't add that option, you'll end up in the VIM text editor. To exit VIM, press : to enter command mode, then q for quit
``` bash
git revert {commit_hash} --no-edit
```