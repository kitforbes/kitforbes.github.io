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
        switch ($Option) {
            "Up" {
                if (Test-Path -Path "$PSScriptRoot/Gemfile.lock") {
                    Remove-Item -Path "$PSScriptRoot/Gemfile.lock"
                }

                & docker-compose.exe up -d
            }
            "Down" {
                & docker-compose.exe down
            }
            "Logs" {
                if ($Follow) {
                    $args = "-f"
                }

                & docker-compose.exe logs $args
            }
            "Start" {
                & Start-Process -FilePath "http://localhost:4000"
            }
            Default {
                throw "Unexpected option: $Option"
            }
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
