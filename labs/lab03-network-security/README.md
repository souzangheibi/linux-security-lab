# Lab 03 - Network Security, Hardening & Monitoring

## Objective

Assess a Linux system from a security analyst perspective by identifying network exposure, reviewing running services, hardening SSH, monitoring network and authentication activity, and automating security checks.

## Lab Environment

- OS: Ubuntu 26.04 LTS
- Environment: WSL2
- Hostname: DESKTOP-40SIH9C
- Network Interface: eth0
- SSH Server: OpenSSH

## Security Workflow

**Discover → Analyze → Harden → Monitor → Automate → Test → Document**

---

## 1. Network Reconnaissance

Listening services were identified using:

```bash
sudo ss -tulpn
```

### Findings

The SSH service was listening on TCP port 22 on all IPv4 and IPv6 interfaces.

The DNS resolver and chrony service were bound to loopback addresses and were not exposed through the network interface.

The network configuration was reviewed using:

```bash
ip addr
ip route
```

---

## 2. Firewall Assessment

Linux firewall management tools were checked to determine whether UFW, nftables, or iptables were available.

The following commands were used:

```bash
sudo ufw status verbose
sudo nft list ruleset
sudo iptables -L -n -v
```

The standard firewall management tools were not installed in the Ubuntu WSL2 environment.

Because this system runs under WSL2, the absence of these Linux firewall tools was not interpreted as proof that the environment had no network-level filtering. Windows Firewall and the WSL virtual networking layer were also considered during the assessment.

---

## 3. SSH Security Assessment & Hardening

The effective SSH configuration was reviewed before applying hardening measures.

```bash
sudo sshd -T | grep -E '^(port|listenaddress|permitrootlogin|passwordauthentication|pubkeyauthentication)'
```

Before hardening, SSH password authentication was enabled and direct root login was restricted but not fully disabled.

An Ed25519 SSH key pair was generated and public-key authentication was tested successfully before disabling password authentication.

SSH hardening was then applied by disabling password authentication and direct root login.

The configuration was validated and the SSH service was reloaded:

```bash
sudo sshd -t
sudo systemctl reload ssh
```

The effective configuration was verified using:

```bash
sudo sshd -T | grep -E '^(passwordauthentication|permitrootlogin)'
```

Final result:

- Password authentication: disabled
- Direct root SSH login: disabled
- Public-key authentication: enabled

---

## 4. Security Monitoring

Network and SSH activity were monitored after hardening.

Active network connections were checked using:

```bash
sudo ss -tupn




sudo ss -tulpn

---

## 4. Security Monitoring

Network and SSH activity were monitored after hardening.

Active network connections were checked using:

```bash
sudo ss -tupn
```

Listening ports were reviewed using:

```bash
sudo ss -tulpn
```

SSH service logs and authentication events were reviewed using journalctl.

```bash
sudo journalctl -u ssh --no-pager -n 30
```

Historical authentication failures and invalid-user attempts were identified during laboratory testing. Successful public-key authentication after hardening was also confirmed.

---

## 5. Security Audit Automation

A Bash script was developed to automate network security and SSH hardening checks.

Script:

```text
network_security_audit.sh
```

The script checks listening ports, SSH hardening settings, active network connections, and SSH authentication events.

### Automation Test

The audit script was executed successfully after the hardening changes.

```bash
./network_security_audit.sh
```

The script returned exit status 0 when no SSH authentication failures were detected.

### Detection Test

A controlled invalid-user SSH attempt was performed to verify that the audit script could detect suspicious authentication activity.

The test generated an SSH log entry for an invalid user.

The audit script detected the event, displayed a warning, and returned exit status 1.

---

## 6. Findings and Security Improvements

- SSH was the primary network-facing service identified during reconnaissance.
- SSH password authentication was disabled.
- Direct root SSH login was disabled.
- Public-key authentication was configured and successfully tested.
- SSH logs were monitored for authentication-related events.
- A Bash audit script was created to automate security checks.
- The script successfully detected a controlled invalid-user authentication event.

The WSL2 environment was treated as a laboratory environment. Network exposure was assessed within the WSL2 networking model, and Windows Firewall was considered as an additional network security layer.

---

## 7. Conclusion

Lab 03 demonstrated a practical network security assessment and hardening workflow on Linux.

The system was assessed for network exposure, SSH configuration, firewall availability, running services, active connections, and authentication activity.

SSH security was improved by disabling password authentication and direct root login while enabling and validating public-key authentication.

Security monitoring and automated detection were implemented using Linux networking tools, system logs, and a Bash audit script.

The lab provides a practical foundation for the final Incident Detection and Response project.
