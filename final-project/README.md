# Linux Incident Detection & Response

## Overview

This project demonstrates a controlled Linux security incident from detection through investigation, containment, recovery, and post-recovery verification.

The scenario focuses on an unexpected local account creation and follows a practical Incident Response workflow.

## Environment

- OS: Ubuntu 26.04 LTS
- Platform: WSL2
- Host: DESKTOP-40SIH9C
- Shell: Bash

## Incident Scenario

A previously unknown local account named `incident_user` was created on the system.

The account was assigned:

- UID: 1002
- GID: 1002
- Home directory: `/home/incident_user`
- Shell: `/bin/bash`

The Linux journal recorded the account creation event.

This was a controlled security simulation performed for incident response training.

## Incident Response Workflow

The project follows:

```text
Detect
  ↓
Investigate
  ↓
Collect Evidence
  ↓
Contain
  ↓
Recover
  ↓
Verify
  ↓
Document
