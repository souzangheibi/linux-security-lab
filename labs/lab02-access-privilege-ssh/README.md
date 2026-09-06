# Lab 02 - Access, Privilege & SSH

## Overview

This lab focuses on fundamental Linux security concepts related to user accounts, file permissions, access control, privilege boundaries, SSH authentication, SSH configuration, and authentication logging.

The lab was designed as a practical security exercise rather than a theoretical demonstration. Each configuration was tested directly on the Ubuntu system, and the results were recorded for later documentation and review.

---

## Objectives

The main objectives of this lab are:

- Create and configure a dedicated Linux test user.
- Understand Linux user and group ownership.
- Configure restrictive file permissions.
- Protect sensitive files from unauthorized users.
- Test access control using a separate user account.
- Understand directory traversal permissions.
- Verify the OpenSSH service.
- Verify the SSH listening port.
- Review important SSH security settings.
- Test SSH authentication.
- Review successful and failed authentication attempts.
- Validate SSH configuration syntax.
- Automate security checks using Bash scripts.
- Document practical security findings.

---

## Lab Environment

| Item | Value |
|---|---|
| Operating System | Ubuntu 26.04 LTS |
| Environment | WSL2 |
| Architecture | x86_64 |
| Hostname | DESKTOP-40SIH9C |
| Primary User | souzan |
| Test User | labuser |
| SSH Server | OpenSSH |
| SSH Port | 22 |

---

# 1. Linux Test User

A dedicated account named `labuser` was used as the test account.

The purpose of using a separate account was to simulate another user attempting to access resources owned by the primary account.

The home directory was verified with:

```bash
ls -ld /home/labuser
```

The account was also tested by switching to the user:

```bash
su - labuser
```

The test confirmed:
- User identity: `labuser`
- Home directory: `/home/labuser`

This confirmed that the dedicated test account was functional and ready for access-control and SSH testing.

## 2. File Permissions

The lab used a protected file named `secret.txt` to demonstrate Linux file permissions and access control.

The file permissions were verified with:

```bash
ls -l secret.txt
```
- Permission mode: 600
- Owner: read and write
- Group: no permissions
- Others: no permissions

Access was tested using the dedicated `labuser` account.
- Owner (souzan): access granted
- labuser: access denied

## 3. Directory Traversal

The home directory of the primary user was configured so that other users cannot traverse it.

The directory permissions were verified with:

```bash
ls -ld /home/souzan
```
- Permission mode: 750
- Owner and group have access; other users have no access.

As a result, labuser could not traverse /home/souzan to reach files stored inside the primary user's home directory.

## 4. SSH Service

The OpenSSH service was verified as active and running.

SSH was confirmed to be listening on TCP port 22.

The SSH listening socket was verified with:

```bash
sudo ss -tlnp
```
- PermitRootLogin: prohibit-password
- PasswordAuthentication: yes
- Direct root password login is restricted.
- Password-based SSH authentication remains enabled and should be reviewed for hardened deployments.

## 5. SSH Authentication Test

The SSH login was tested locally with:

```bash
ssh labuser@localhost
```
- Authentication: successful
- User identity: labuser
- Home directory: /home/labuser

## 6. SSH Log Review

SSH authentication events were reviewed using:

```bash
sudo journalctl -u ssh --since "30 minutes ago"
```
- Successful authentication for labuser was recorded.
- Failed authentication attempts were also recorded.
- The SSH session was opened after successful authentication.

## 7. SSH Configuration Validation

The SSH configuration syntax was validated with:

```bash
sudo sshd -t
```
- SSH configuration syntax: valid
## 8. Automated Security Tests

The lab includes Bash scripts for repeatable security verification.

### setup_lab02.sh

Automates the initial lab setup and verifies the test user, home directory, protected file, and file permissions.

### permission_test.sh

Verifies the protected file permissions, owner access, and unauthorized access prevention.

### ssh_test.sh

Checks the SSH service, listening port, PermitRootLogin, PasswordAuthentication, and SSH configuration syntax.

## 9. Security Findings

### Finding 1 - File Protection

The secret.txt file uses permission mode 600, allowing only the owner to read and modify it.

### Finding 2 - Unauthorized Access Prevention

The labuser account was denied access to the protected file.

### Finding 3 - SSH Root Login Restriction

PermitRootLogin is set to prohibit-password, restricting direct root password authentication.

### Finding 4 - SSH Password Authentication

PasswordAuthentication is enabled. This should be reviewed when hardening a production SSH deployment.

### Finding 5 - Authentication Logging

Both failed and successful SSH authentication attempts were observed in the system journal.

## 10. Test Summary

| Test | Result |
|---|---|
| User verification | PASS |
| File permission test | PASS |
| Unauthorized access prevention | PASS |
| SSH service verification | PASS |
| SSH port verification | PASS |
| SSH authentication | PASS |
| SSH log review | PASS |
| SSH configuration validation | PASS |
| Automated SSH security test | PASS |

## 11. Security Principles Demonstrated

- Least privilege
- Access control
- Authentication
- Logging and monitoring
- Security validation and automation

## 12. Conclusion

This lab demonstrated practical Linux access control, file permissions, user privilege boundaries, SSH authentication, SSH configuration review, and authentication logging.

The practical tests confirmed that protected resources can be restricted from unauthorized users and that SSH activity can be verified and monitored.

The use of Bash scripts also made the security checks repeatable and easier to validate.

The main security consideration identified during the lab is that SSH password authentication remains enabled.

## Final Status

Lab 02 practical tests: PASS
Documentation status: COMPLETE

**Lab Status: Completed**
