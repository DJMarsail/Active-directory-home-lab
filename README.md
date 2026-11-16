# Windows Server Active Directory & Group Policy Home Lab

**Status:** In progress | **Hypervisor:** Oracle VirtualBox | **Server:** Windows Server 2022 Standard Evaluation

## Objective
Build and document a small Windows enterprise environment to practice identity management, organizational units (OUs), security groups, DNS, Group Policy, and domain-joined workstation administration.

## Lab environment

| Component | Configuration |
| --- | --- |
| Domain controller | `DC01`, Windows Server 2022 Standard Evaluation |
| Active Directory domain | `lab.local` |
| Server roles | Active Directory Domain Services (AD DS) and DNS |
| Virtual networking | NAT and isolated VirtualBox Internal Network (`labnet`) |
| Client | `WIN11-CLIENT`, Windows 11 Enterprise Evaluation VM (domain join not yet verified) |

## Completed work
- Installed Windows Server 2022 and promoted `DC01` to domain controller for `lab.local`.
- Installed/configured Active Directory Domain Services and DNS.
- Created the `Lab-Users` organizational unit.
- Created sample users Alice Smith, Bob Jones, and Carol Lee.
- Created global security groups `IT-Support`, `Sales`, and `Human Resources`, and assigned users.
- Created `Lab-Restrict-ControlPanel` GPO and linked it to `Lab-Users`.
- Verified the GPO is configured with **User Configuration → Administrative Templates → Control Panel → Prohibit access to Control Panel and PC settings = Enabled**.
- Created the Windows 11 client VM for later domain joining and policy validation.

## Architecture

```text
                    Oracle VirtualBox
              +---------------------------+
              | Internal Network: labnet  |
              |                           |
              | DC01                      |
              | Windows Server 2022       |
              | AD DS / DNS / lab.local   |
              |     |                     |
              |     +--- WIN11-CLIENT     |
              |          (join pending)   |
              +---------------------------+
```

## Validation checklist
- [ ] Install and boot Windows 11 Enterprise on `WIN11-CLIENT`.
- [ ] Verify internal network connectivity; set client DNS to the DC01 internal IP.
- [ ] Join the Windows 11 client to `lab.local`.
- [ ] Sign in as a domain user and verify applied GPOs using `gpresult /r` or `gpresult /h`.
- [ ] Confirm Control Panel restrictions work for an affected user.
- [ ] Create a shared folder and test access based on group permissions.
- [ ] Capture real screenshots and record troubleshooting steps.

## Project files
- [Lab setup and validation notes](documentation/lab-notes.md)
- [Screenshot checklist](screenshots/README.md)
- [Scripts folder](scripts/README.md)

## Skills demonstrated
Windows Server administration, Active Directory, DNS, user and group management, Group Policy configuration, virtualization, and technical documentation.

**Scope note:** The GPO configuration has been verified in Group Policy Management; client-side policy enforcement has **not** yet been verified. This repository documents an ongoing lab, not a completed production deployment.
