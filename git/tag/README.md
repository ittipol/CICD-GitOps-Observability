# Tag

**Create a tag**
``` bash
git tag <tagname>

git tag -l

git tag --sort=-creatordate -n

# tags/<tagname> = prevent ambiguous name, when local branch name is same with tag name
git push origin tags/<tagname>
```

**Create a tag for a specific commit hash**
``` bash
git tag <tagname> <commit-hash>

git tag -a <tagname> <commit-hash> -m "<message>"
```

**Push tag to remote repository**
``` bash
git push origin tags/<tagname>

# push all tags
git push origin --tags
```

**View tag commit hash**
``` bash
git rev-list -n 1 tags/<tagname>
```