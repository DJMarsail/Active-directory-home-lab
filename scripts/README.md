# PowerShell lab scripts

These scripts support repeatable verification in the Windows Server / Windows 11 Active Directory home lab.

## validate-client.ps1

Run from an elevated PowerShell session on **WIN11-CLIENT** after the client is configured for the isolated `labnet` network.

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\validate-client.ps1 -DomainName lab.local -DomainControllerIP 192.168.56.10
```

Replace `192.168.56.10` with the **actual DC01 internal-network IP**. The address above is an example, not a verified lab configuration. If running from inside the scripts folder, use `.\validate-client.ps1` instead.

The script reports local DNS settings, DNS lookup, domain-controller reachability over DNS port 53, domain membership and Group Policy results. It is **read-only** and does not join the domain, change settings, or claim that policies are enforced.

Run the script in the Windows client itself; GitHub stores code but cannot execute commands inside your local VirtualBox VMs.
