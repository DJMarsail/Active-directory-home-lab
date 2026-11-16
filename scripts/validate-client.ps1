#requires -Version 5.1
<#
.SYNOPSIS
    Read-only connectivity and domain validation for the AD home lab.
.DESCRIPTION
    Collects evidence without modifying DNS, domain membership or Group Policy.
    Review results on the actual Windows 11 client before marking tests complete.
.EXAMPLE
    .\validate-client.ps1 -DomainName lab.local -DomainControllerIP 192.168.56.10
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$DomainName = 'lab.local',

    [Parameter(Mandatory = $true)]
    [ValidateScript({ [System.Net.IPAddress]::TryParse($_, [ref]([System.Net.IPAddress]$null)) })]
    [string]$DomainControllerIP
)

$ErrorActionPreference = 'Continue'

function Show-Section {
    param([string]$Title)
    Write-Host "`n=== $Title ===" -ForegroundColor Cyan
}

Show-Section 'Client network configuration'
Get-NetIPConfiguration | Format-List InterfaceAlias,IPv4Address,IPv4DefaultGateway,DNSServer

Show-Section 'DNS resolution'
try {
    Resolve-DnsName -Name $DomainName -Server $DomainControllerIP -ErrorAction Stop |
        Format-Table Name,Type,IPAddress,NameHost -AutoSize
} catch {
    Write-Warning "DNS resolution failed: $($_.Exception.Message)"
}

Show-Section 'Domain controller DNS port (TCP 53)'
try {
    Test-NetConnection -ComputerName $DomainControllerIP -Port 53 -InformationLevel Detailed |
        Select-Object ComputerName,RemoteAddress,RemotePort,TcpTestSucceeded |
        Format-List
} catch {
    Write-Warning "Connectivity test failed: $($_.Exception.Message)"
}

Show-Section 'Computer domain membership'
try {
    Get-CimInstance Win32_ComputerSystem |
        Select-Object Name,PartOfDomain,Domain |
        Format-List
} catch {
    Write-Warning "Could not query domain membership: $($_.Exception.Message)"
}

Show-Section 'Applied Group Policy (current user)'
& gpresult.exe /r
if ($LASTEXITCODE -ne 0) {
    Write-Warning "gpresult exited with code $LASTEXITCODE. Try an appropriate domain-user session."
}

Write-Host "`nValidation collection finished. Review output before updating repository evidence." -ForegroundColor Green
