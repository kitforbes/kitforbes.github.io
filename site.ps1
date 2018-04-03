[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 1)]
    [ValidateSet("Up", "Down", "Logs")]
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
