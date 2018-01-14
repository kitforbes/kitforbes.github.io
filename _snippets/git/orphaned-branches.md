---
title: "Orphaned Branches"
excerpt: "Forget about the past with an orphaned branch."
child_collection: git
---

An orphaned branch is a branch which does not share the same history as that of
the other branches. Situations like GitHub Pages may require an orphaned branch
in your Git repository to function. These are the steps to achieve this in Bash.

```bash
BRANCH=gh-pages

# Create the new orphaned branch.
git checkout --orphan $BRANCH

# Remove all files.
git rm -rf .

# Add and commit any files.
echo "Root Page" > index.html
git add index.html
git commit -am "Initial commit"

# Push the branch to the remote ("-u" sets the upstream).
git push -u origin $BRANCH
```
