[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 1)]
    [ValidateSet("Up", "Down", "Logs", "Start")]
    [String]
    $Option,
    [Parameter(Mandatory = $false)]
    [Alias("F")]
    [Switch]
    $Follow
)

begin {
    Write-Verbose -Message "$($MyInvocation.MyCommand): Execution started."
}

process {
    try {
        if ($Option -eq "Up") {
            Remove-Item -Path "$PSScriptRoot/Gemfile.lock"
            & docker-compose.exe up -d
        }
        elseif ($Option -eq "Down") {
            & docker-compose.exe down
        }
        elseif ($Option -eq "Logs") {
            if ($Follow) {
                $args = "-f"
            }

            & docker-compose.exe logs $args
        }
        elseif ($Option -eq "Start") {
            & Start-Process -FilePath "http://localhost:4000"
        }

        exit 0
    }
    catch {
        Write-Output "$($_.Exception.Message)"
        exit 1
    }
}

end {
    Write-Verbose -Message "$($MyInvocation.MyCommand): Execution finished."
}
