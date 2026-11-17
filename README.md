# Windows Server Active Directory & Group Policy Home Lab

A hands-on Windows enterprise administration lab built with **Windows Server 2022**, **Windows 11 Enterprise Evaluation**, and **Oracle VirtualBox**. The project demonstrates centralized identity management, domain networking, Group Policy enforcement, and group-based file access configuration.

## Environment

| Component | Configuration |
| --- | --- |
| Hypervisor | Oracle VirtualBox |
| Domain controller | `DC01` — Windows Server 2022 Standard Evaluation |
| Domain | `lab.local` (NetBIOS: `LAB`) |
| Directory and DNS | Active Directory Domain Services (AD DS), DNS |
| Virtual network | NAT plus isolated Internal Network (`labnet`) |
| Domain controller internal IP | `192.168.10.10/24` |
| Workstation | `WIN11-CLIENT` — Windows 11 Enterprise Evaluation |
| Organizational unit | `Lab-Users` |

## Architecture

```text
                Oracle VirtualBox
        Internal Network: labnet (192.168.10.0/24)
                        |
             +----------+-----------+
             |                      |
        DC01 (Server 2022)     WIN11-CLIENT
        192.168.10.10          Windows 11 Enterprise
        AD DS + DNS            Joined to lab.local
        lab.local              Domain user sign-in
             |
        Lab-Users OU
        Users / security groups / GPO
```

## Implementation

### Active Directory and DNS
- Installed Windows Server 2022 and promoted `DC01` to the domain controller for `lab.local`.
- Configured AD DS and DNS, and organized test accounts within the `Lab-Users` OU.
- Created sample accounts for Alice Smith, Bob Jones, and Carol Lee and departmental security groups including `IT-Support`, `Sales`, and `Human Resources`.
- Configured the Windows 11 workstation to use `DC01` for DNS and successfully joined it to the domain.
- Verified client-to-server connectivity and resolution of `lab.local`.

### Group Policy enforcement
- Created and linked `Lab-Restrict-ControlPanel` to `Lab-Users`.
- Enabled **User Configuration → Administrative Templates → Control Panel → Prohibit access to Control Panel and PC settings**.
- Signed in to Windows 11 as a domain user and verified the GPO under **Applied Group Policy Objects** using `gpresult /r`.
- Confirmed that launching Control Panel produced the administrator restriction message on the client.

### Group-based access control
- Created a `Finance-Access` global security group and added Alice Smith.
- Configured `C:\CompanyFiles` with Modify permissions for `Finance-Access`.
- Captured access-allowed and access-denied evidence for the file-sharing exercise. See the [evidence gallery](screenshots/README.md).

## Evidence

| Test | Evidence |
| --- | --- |
| Domain controller connectivity | [Ping result](screenshots/domain-connectivity-verified.png) |
| DNS resolution | [DNS lookup](screenshots/dns-resolution-verified.png) |
| Windows 11 domain join | [Domain join confirmation](screenshots/domain-joined-verified.png) |
| Group Policy application | [gpresult output](screenshots/gpo-policy-applied.png) |
| Control Panel restriction | [Enforcement result](screenshots/gpo-control-panel-blocked.png) |
| File access allowed | [Access evidence](screenshots/finance-access-allowed.png) |
| File access denied | [Access evidence](screenshots/finance-access-denied.png) |

## Repository contents

- [Technical implementation notes](documentation/lab-notes.md)
- [Lab screenshots and evidence](screenshots/README.md)
- [PowerShell validation utility](scripts/README.md)

## Skills demonstrated

**Windows Server administration · Active Directory · DNS · Domain joining · Organizational units · Security groups · Group Policy · NTFS permissions · Virtual networking · Troubleshooting · Technical documentation**

**Environment:** An isolated educational home lab, not a production corporate deployment.
