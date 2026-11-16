# Lab setup and validation notes

## Environment
- Hypervisor: Oracle VirtualBox
- Domain controller: DC01 (Windows Server 2022 Standard Evaluation)
- Domain: lab.local
- Server roles: Active Directory Domain Services (AD DS), DNS
- Internal VirtualBox network: labnet
- Client: WIN11-CLIENT (Windows 11 Enterprise Evaluation)

## Work completed (as documented)
- Promoted DC01 to domain controller for lab.local.
- Configured AD DS and DNS.
- Created Lab-Users organizational unit.
- Created Alice Smith, Bob Jones and Carol Lee test accounts.
- Created IT-Support, Sales and Human Resources global security groups.
- Created and linked Lab-Restrict-ControlPanel GPO to Lab-Users.
- Enabled **User Configuration > Administrative Templates > Control Panel > Prohibit access to Control Panel and PC settings**.
- Created Windows 11 client VM; domain join and enforcement remain unverified.

## Next validation session
1. Start DC01 and WIN11-CLIENT and confirm both are attached to labnet.
2. On DC01, run `ipconfig /all` and note the IPv4 address for the internal adapter.
3. Configure the client DNS server to the DC01 internal IPv4 address.
4. On the client, run `ipconfig /all`, `nslookup lab.local` and `Test-NetConnection <DC01-IP> -Port 53`.
5. Join WIN11-CLIENT to lab.local using authorized domain credentials, then restart.
6. Sign in as a test user in Lab-Users and run `gpupdate /force` followed by `gpresult /r`.
7. Confirm the Control Panel restriction is actually enforced for that user.
8. Test a shared folder with access granted through an AD security group; record allowed and denied access.
9. Save sanitized evidence in screenshots/ and update the checklist in the main README.

## Evidence log
| Test | Expected result | Actual result | Status |
| --- | --- | --- | --- |
| Client resolves lab.local | DNS resolves via DC01 | Not tested | Pending |
| Client joins lab.local | Domain join succeeds | Not tested | Pending |
| GPO applies to domain user | GPO appears in gpresult | Not tested | Pending |
| Control Panel blocked | Restricted user cannot access settings | Not tested | Pending |
| Group-based share access | Authorized group allowed, other user denied | Not tested | Pending |

> Record actual results only after running the tests. Do not commit passwords, tokens, personal data or sensitive configuration details.
