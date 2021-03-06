---
title: "Safely Re-Create a Directory"
excerpt: "Safely delete a directory before re-creating it within PowerShell."
child_collection: powershell
---

If the directory exists, remove it before re-creating it.

```powershell
function New-Directory($dir)
{
    if (Test-Path "$dir") {
        Remove-Item "$dir" -Recurse -Force
    }

    New-Item "$dir" -ItemType Directory -Force -Path
}
```
