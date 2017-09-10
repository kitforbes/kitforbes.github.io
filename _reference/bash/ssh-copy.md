---
title: "SSH Copy"
categories: Bash
---

```bash
# Usage:
scp -i "<path-to-private-key>" \
  "<source-directory>" \
  "<user>@<host>:<destination-directory>"

# Example:

# Copy from local to remote.
scp -i "/home/user/.ssh/id_rsa.pem" \
  "/home/user" \
  "centos@1.2.3.4:/home/centos"

# Copy from remote to local.
scp -i "/home/user/.ssh/id_rsa.pem" \
  "centos@1.2.3.4:/home/centos" \
  "/home/user"
```
