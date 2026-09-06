# Linux Security Lab

A hands-on Linux security project focused on system reconnaissance, access control, SSH hardening, network security, monitoring, and incident detection & response.

This repository documents practical security labs and a controlled incident response project built in an Ubuntu Linux environment running on WSL2.

## 🎯 Project Overview

The goal of this project is to develop practical Linux security and Blue Team capabilities through hands-on labs rather than purely theoretical exercises.

The project covers the security workflow from:

**Reconnaissance → Hardening → Monitoring → Detection → Investigation → Containment → Recovery → Verification**

## 🧪 Labs

### Lab 01 — Linux System Reconnaissance

Focuses on understanding and auditing the Linux system environment.

Key areas:

* System information gathering
* User and group enumeration
* Process inspection
* Disk and filesystem analysis
* Network configuration
* Listening services
* Basic security auditing

📁 `labs/lab01-system-recon/`

---

### Lab 02 — Access Control & SSH Security

Focuses on Linux permissions, user access, and SSH security.

Key areas:

* Linux users and groups
* File ownership and permissions
* Permission testing
* SSH configuration
* SSH key-based authentication
* Password authentication hardening
* Root login restrictions
* Access verification

📁 `labs/lab02-access-privilege-ssh/`

---

### Lab 03 — Network Security, Hardening & Monitoring

Focuses on network exposure, SSH hardening, active connections, and security monitoring.

Key areas:

* Listening port enumeration
* Network connection analysis
* SSH security configuration
* Authentication failure monitoring
* `ss` network analysis
* `journalctl` security monitoring
* Windows Firewall awareness in WSL2

📁 `labs/lab03-network-security/`

---

## 🚨 Final Project — Incident Detection & Response

A controlled Linux security incident simulation designed around a practical Blue Team / SOC workflow.

### Scenario

A previously unknown Linux account was introduced into the system during a controlled security simulation.

The investigation focused on determining:

* When the account was created
* How the account was configured
* Whether it had logged into the system
* Whether privilege escalation occurred
* Whether suspicious persistence mechanisms existed
* Whether malicious execution was observed
* How the account could be contained and removed

### Response Workflow

**Detect → Investigate → Collect Evidence → Contain → Recover → Verify → Document**

The project includes:

* Security baseline
* Automated account detection
* Investigation evidence
* Evidence hashing
* Containment procedure
* Recovery procedure
* Post-recovery verification
* Incident report

📁 `final-project/`

## 🛠️ Technologies & Tools

* Linux / Ubuntu
* WSL2
* Bash
* SSH
* systemd
* `ss`
* `journalctl`
* `ps`
* `ip`
* `df`
* `stat`
* `find`
* `getent`
* `passwd`
* `useradd`
* `userdel`
* Git
* GitHub

## 📂 Project Structure

```text
linux-security-lab/
│
├── labs/
│   ├── lab01-system-recon/
│   ├── lab02-access-privilege-ssh/
│   └── lab03-network-security/
│
├── final-project/
│   ├── evidence/
│   ├── scripts/
│   ├── README.md
│   └── incident_report.md
│
├── reports/
├── scripts/
├── src/
├── tests/
├── .gitignore
└── README.md
```

## 🔐 Security Approach

This repository follows a practical security mindset:

* Establish a known-good baseline
* Identify deviations
* Investigate suspicious changes
* Collect and preserve evidence
* Apply containment
* Recover the system
* Verify the security state
* Document the incident

All security incidents documented in this repository are controlled laboratory simulations performed in a local test environment.

## 📈 Skills Demonstrated

### Linux Security

* Linux administration
* User and group management
* File permissions
* SSH security
* Process analysis
* Service inspection
* Network analysis
* System monitoring

### Blue Team / SOC

* Security baseline creation
* Account anomaly detection
* Log analysis
* Evidence collection
* Incident investigation
* Containment
* Recovery
* Post-incident verification
* Incident documentation

### Automation

* Bash scripting
* Security audit scripting
* Automated detection logic
* Command-line security tooling

## 🎓 Project Outcome

This project demonstrates practical experience in securing and monitoring a Linux environment and responding to a controlled security incident from initial detection through recovery and documentation.

It is part of a broader cybersecurity learning path focused on:

**Linux → Networking → Security → Detection → Incident Response → Cyber Resilience**

---

**Status:** Completed

**Environment:** Ubuntu 26.04 LTS on WSL2

