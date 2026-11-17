# Technical implementation notes

## Lab architecture

The environment runs on Oracle VirtualBox with a Windows Server 2022 domain controller (`DC01`) and a Windows 11 Enterprise Evaluation workstation (`WIN11-CLIENT`).

| Item | Configuration |
| --- | --- |
| Active Directory domain | `lab.local` |
| NetBIOS domain | `LAB` |
| Internal network | `labnet` |
| Domain controller internal IPv4 | `192.168.10.10` |
| Workstation IPv4 configured for testing | `192.168.10.20/24` |
| Workstation DNS | `192.168.10.10` |
| Workstation gateway on isolated adapter | None |
| Server roles | AD DS and DNS |

## Directory configuration

`DC01` was promoted to a domain controller for `lab.local`. The `Lab-Users` OU contains test users Alice Smith, Bob Jones, and Carol Lee, along with departmental groups `IT-Support`, `Sales`, and `Human Resources`. A `Finance-Access` security group was subsequently created and Alice Smith was added as a member.

## Domain networking and workstation enrollment

The workstation was connected to the VirtualBox internal network, configured to use the domain controller for DNS, and joined to `lab.local`. Connectivity to `192.168.10.10` returned four successful ICMP replies with no packet loss. A DNS query resolved `lab.local` to `192.168.10.10`. Windows displayed the successful domain join confirmation.

## Group Policy configuration and validation

The `Lab-Restrict-ControlPanel` GPO is linked to `Lab-Users`. It enables:

```text
User Configuration
  > Administrative Templates
    > Control Panel
      > Prohibit access to Control Panel and PC settings: Enabled
```

After signing in to `WIN11-CLIENT` using Alice Smith's domain account, `gpresult /r` listed `Lab-Restrict-ControlPanel` under **Applied Group Policy Objects** and identified `DC01.lab.local` as the Group Policy source.

Opening Control Panel on the client produced the message:

> This operation has been cancelled due to restrictions in effect on this computer. Please contact your system administrator.

Together, these results demonstrate both policy application and client-side enforcement.

## Group-based file permissions

A `C:\CompanyFiles` folder was created on `DC01`. The `Finance-Access` global security group was assigned Modify permissions, and Alice Smith was added to the group. The repository includes screenshots named `finance-access-allowed.png` and `finance-access-denied.png` documenting the access-control exercise.

Effective access depends on both NTFS and, for network access, share permissions. The screenshots are retained as the record of the access tests; no additional command-level audit is claimed here.

## Evidence

The [screenshots directory](../screenshots/README.md) contains domain networking, DNS, domain join, Group Policy, and file-access evidence.

A [read-only PowerShell validation utility](../scripts/validate-client.ps1) is included as reusable lab tooling. Its execution is not represented as a completed test in this document.
