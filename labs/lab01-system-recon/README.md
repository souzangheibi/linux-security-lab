# Linux Security Reconnaissance Lab

A practical Linux security assessment project focused on system reconnaissance,
user and group auditing, process analysis, network exposure assessment,
authentication log review, file permission auditing, and privilege-related
security checks.

## Project Overview

This project implements a Bash-based Linux security auditing tool designed
to collect system information and identify security-relevant conditions.

The tool performs multiple reconnaissance and audit checks and presents
the results as structured security findings.

The project was developed and tested in an Ubuntu Linux environment running
under WSL2.

## Objectives

- Identify the Linux operating system and system environment.
- Audit local users and groups.
- Analyze running processes and privileged processes.
- Inspect network interfaces and routing configuration.
- Identify listening network services.
- Review authentication-related log events.
- Audit permissions of sensitive system files.
- Identify SUID and SGID binaries.
- Generate basic security findings from collected data.
- Practice Linux security assessment and Bash scripting.

## Environment

- Operating System: Ubuntu 26.04 LTS
- Environment: WSL2
- Architecture: x86_64
- Shell: Bash

## Project Structure

```text
linux-security-lab/
└── labs/
    └── lab01-system-recon/
        ├── README.md
        └── security_audit.sh
