---
title: "Modify Hosts File"
categories: Batch
---

```batch
set DOMAIN=something.example.com
set NEWLINE=^& echo.
set HOSTFILE=%WINDIR%\system32\drivers\etc\hosts

find /C /I "%DOMAIN%" "%HOSTFILE%"
if %ERRORLEVEL% NEQ 0 echo %NEWLINE%^    127.0.0.1       %DOMAIN% >> "%HOSTFILE%"
```
