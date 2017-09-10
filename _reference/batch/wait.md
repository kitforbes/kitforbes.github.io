---
title: "Command Line Wait"
categories: Batch
---

There is currently no built in method for waiting other than `sleep`.
Here is an alternative approach.

```batch
set SECONDS_TO_WAIT=10
ping -n %SECONDS_TO_WAIT% 127.0.0.1 > nul
```
