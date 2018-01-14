---
title: "Symlinks"
excerpt: "All the ways of linking files and directories on Windows."
child_collection: batch
---

**Soft-Link to File**

```batch
rem Usage:
mklink <link> <target>

rem Example:
mklink "C:\Pretender\File" "C:\Actual\File"
```

**Soft-Link to Directory**

```batch
rem Usage:
mklink /D <link> <target>

rem Example:
mklink /D "C:\Pretender" "C:\Actual"
```

**Hard-Link to File**

```batch
rem Usage:
mklink /H <link> <target>

rem Example:
mklink /H "C:\Pretender\File" "C:\Actual\File"
```

**Hard-Link to Directory (directory junction)**

```batch
rem Usage:
mklink /J <link> <target>

rem Example:
mklink /J "C:\Pretender" "C:\Actual"
```
