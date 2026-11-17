# PowerShell validation utility

The [`validate-client.ps1`](validate-client.ps1) script provides read-only checks for a Windows workstation joined to an Active Directory domain.

## Checks performed

- Network adapter and DNS configuration
- DNS resolution against the specified domain controller
- TCP connectivity to DNS port 53
- Windows domain membership
- Applied Group Policy results for the current user

## Usage

Run in PowerShell on a Windows workstation with access to the domain controller:

```powershell
.\validate-client.ps1 -DomainName lab.local -DomainControllerIP 192.168.10.10
```

The script does not modify system settings, join computers to a domain, or change security policies.

**Status:** Script included as supporting source code; execution results have not been documented. Independently captured evidence for domain connectivity, domain membership, and Group Policy enforcement is available in the [screenshots directory](../screenshots/README.md).
