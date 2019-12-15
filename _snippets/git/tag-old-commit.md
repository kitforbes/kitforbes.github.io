---
title: "Tagging old Commits"
excerpt: "Tag an old commit with the correct date."
child_collection: git
---

Changing processes in a repository can sometimes mean that you need to tag old
commits to populate the release history. If you don't roll back the date, this
can mess up the chronological order of your releases. This can be addressed with
the following:

```bash
# Checkout the commit which requires a tag.
git checkout [sha]

# Set GIT_COMMITTER_DATE to the date of the commit and create the tag.
GIT_COMMITTER_DATE="$(git show --format=%aD | head -1)" \
  git tag -a [tag] -m [tag]

# Return to the master branch.
git checkout master
```
