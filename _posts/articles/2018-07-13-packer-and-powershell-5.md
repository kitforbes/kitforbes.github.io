---
title: "Packer and PowerShell 5.1"
excerpt: "Installing PowerShell 5.1 on Windows Server 2012 R2 during a Packer build - not as simple as you would like."
categories:
  - articles
tags:
  - packer
  - powershell
  - windows-server
---

Recently, I have been putting together a local [Packer][1] template repository to create a number of base images for testing. While creating the template for Windows Server 2012 R2, I was attempting to [install PowerShell 5.1][3] with Chocolatey. During this, I learned that these types of updates cannot be installed through a WinRM session due to some intentional limitations imposed by Microsoft. Installing with Chocolatey returns the following error:

> Installing PowerShell...
>
> WARNING: User (you) cancelled the installation.
>
> Opps we had a error.
>
> Found the following error(s) and warnings in the MSU log "C:\Users\vagrant\AppData\Local\Temp\chocolatey\PowerShell-Install-201807130652.evtx"
>
>
> ERROR: Running ["C:\Windows\System32\wusa.exe" "C:\Users\vagrant\AppData\Local\Temp\chocolatey\PowerShell\5.1.14409.20180105\Win8.1AndW2K12R2-KB3191564-x64.msu" /quiet /norestart /log:"C:\Users\vagrant\AppData\Local\Temp\chocolatey\PowerShell-Install-201807130652.evtx" ] was not successful. Exit code was '5'. Exit code indicates the following: User (you) cancelled the installation.

Exit code *5* actually means *Access denied* here, which I found out from trying to install the `msu` file with `wusa.exe`.

```powershell
wusa.exe <path-to-package.msu> /quiet
```

I spent a number of evenings looking around for solutions to this and I came across a handful of approaches. I initially tried creating a scheduled task to run as the local `SYSTEM` account to execute the install, but this didn't seem to work either.

After going back and forth, moving execution from provisioners to the `Autounattend.xml` file, I used some of the commands described in [this article][2]. The solution is to unpack the `msu` with `wusa.exe` and then install the `cab` file with `Dism.exe`.

My simplified implementation follows.

**template.json**

```json
{
  "builders": [],
  "provisioners": [
    {
      "type": "powershell",
      "script": "scripts/install_powershell.ps1",
      "elevated_user": "vagrant",
      "elevated_password": "vagrant",
      "valid_exit_codes": [
        0,
        3010
      ]
    },
    {
      "type": "windows-restart",
      "restart_timeout": "1h"
    }
  ],
  "post-processors": [],
  "variables": {}
}
```

**scripts/install_powershell.ps1**

```powershell
$url = 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu'
$checksum = 'a8d788fa31b02a999cc676fb546fc782e86c2a0acd837976122a1891ceee42c0'
$output = "$env:WinDir\Temp\Win8.1AndW2K12R2-KB3191564-x64.msu"

# Ensure the Windows Update service is running.
Get-Service -Name wuauserv | Start-Service

# Download the update.
(New-Object System.Net.WebClient).DownloadFile($url, $output)

# Validate the checksum.
if ((Get-FileHash -Path $output -Algorithm SHA256).Hash.ToLower() -ne $checksum) {
    Write-Output "Checksum does not match."
    exit 1
}

# Extract the contents of the msu package.
$env:WinDir\System32\wusa.exe `
    $env:WinDir\Temp\Win8.1AndW2K12R2-KB3191564-x64.msu `
    /extract:$env:WinDir\Temp

# Install the cab file wih Dism.
$env:WinDir\System32\Dism.exe `
    /online /add-package `
    /PackagePath:$env:WinDir\Temp\WindowsBlue-KB3191564-x64.cab `
    /Quiet /NoRestart
# Returns 3010 to signify "reboot required"

# Stop the Windows Update service.
Get-Service -Name wuauserv | Stop-Service
```

My actual implementation will be published on GitHub once completed.

<!-- References -->
[1]: https://www.packer.io/ "Packer.io"
[2]: https://support.microsoft.com/en-us/help/2773898/windows-update-standalone-installer-wusa-returns-0x5-error-access-deni "Windows Update Standalone Installer (WUSA) returns 0x5 ERROR_ACCESS_DENIED when deploying .msu files through WinRM and Windows Remote Shell"
[3]: https://docs.microsoft.com/en-us/powershell/wmf/5.1/install-configure "Install and Configure WMF 5.1"
