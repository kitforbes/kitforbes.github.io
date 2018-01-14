---
title: "Modify Hosts File"
excerpt: "Add an entry to the Windows hosts file with a Batch file."
child_collection: batch
---

TODO: This needs to be made more rhobust.

```batch
set DOMAIN=something.example.com
set NEWLINE=^& echo.
set HOSTFILE=%WINDIR%\system32\drivers\etc\hosts

find /C /I "%DOMAIN%" "%HOSTFILE%"
if %ERRORLEVEL% NEQ 0 echo %NEWLINE%^    127.0.0.1       %DOMAIN% >> "%HOSTFILE%"
```
