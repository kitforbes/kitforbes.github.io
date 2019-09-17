---
title: "Conditional Git Configuration"
excerpt: "Load conditional Git settings based on your working directory."
categories:
  - articles
tags:
  - git
---

I recently had the need to use multiple identities when writing commits in Git
from a single laptop. I have a standard `.gitconfig` file which contains my
preferred settings for colours, aliases, etc. This file also holds my personal
email address that I use for GitHub.

```ini
# ~/.gitconfig
[user]
  email = chris@mydomain.com
  name = Chris Forbes
```

As I wanted to use my work email for work related projects, I did some quick
research to find that Git has offered [conditional inclusion][1] of settings since
version 2.13.

With this in mind, I can update my `.gitconfig` file to have my default settings,
but also include a reference to a separate file to
be used when in a sub-directory of a particular path.

```ini
# ~/.gitconfig
[user]
  email = chris@mydomain.com
  name = Chris Forbes

[includeIf "gitdir:~/dev/work/"]
  path = ~/.gitconfig.work
```

The included file contains any settings that need to be overridden.

```ini
# ~/.gitconfig.work
[user]
  email = chris@example.com
```

This means that when I am in a directory like `~/dev/work/some-project`,
and I make a commit, it will use the work email address instead of the personal
email address. A nice little addition that makes working with different
identities much simpler.

<!-- References -->
[1]: https://git-scm.com/docs/git-config#_conditional_includes "Git - Conditional Includes"
