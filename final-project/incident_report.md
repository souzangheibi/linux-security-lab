# Linux Security Lab — Incident Response Report

## 1. Incident Overview

**Incident Type:** Unexpected Local Account Creation
**Environment:** Ubuntu 26.04 LTS on WSL2
**Affected Host:** DESKTOP-40SIH9C
**Affected Account:** incident_user
**UID:** 1002
**Incident Status:** Contained and Recovered
**Simulation Type:** Controlled Security Incident

This project simulated and investigated an unexpected local account creation event on a Linux system. The incident was analyzed from detection through investigation, evidence collection, containment, recovery, and post-recovery verification.

The objective was to demonstrate a practical Linux Incident Detection and Response workflow.

---

## 2. Incident Timeline

### 09:41:45 — Account Creation

The account `incident_user` was created with:

* UID: 1002
* GID: 1002
* Home directory: `/home/incident_user`
* Shell: `/bin/bash`

The Linux journal recorded the account creation event.

### 09:41:46 — Home Directory Created

The home directory `/home/incident_user` was created and owned by the new account.

### 09:42:06 — Duplicate Creation Attempt

A second attempt to create `incident_user` failed because the account already existed.

### Investigation Phase

The account was examined for:

* Password status
* Group membership
* Login history
* Running processes
* Home directory contents
* SSH persistence
* User cron jobs
* System-wide cron entries
* Systemd timers
* Running systemd services
* Relevant journal events

### Containment

The account was locked using:

`passwd -l incident_user`

The account was already locked before the containment action and remained locked after verification.

### Recovery

The simulated incident account was removed using:

`userdel -r incident_user`

The account and its home directory were successfully removed.

### Post-Recovery Verification

The following checks confirmed that the account no longer existed:

* `id incident_user` returned no such user.
* `getent passwd incident_user` returned no output.
* `/home/incident_user` no longer existed.
* The automated account detection script returned:

`[PASS] No new accounts detected.`

---

## 3. Detection

The initial detection was based on comparison between the current system account list and the previously captured security baseline.

The baseline was stored in:

`baseline.txt`

A custom detection script was developed:

`scripts/account_detection.sh`

The script compares current accounts from `/etc/passwd` against the baseline and generates an alert when a new account is identified.

During the controlled detection test, the script successfully detected:

`incident_user`

Detection result:

`[ALERT] New account(s) detected: incident_user`

The detection test was recorded in:

`evidence/detection_test.log`

---

## 4. Investigation Findings

The investigation confirmed that `incident_user` existed and was associated with the simulated account creation event.

### Account Status

* UID: 1002
* GID: 1002
* Shell: `/bin/bash`
* Password: Locked
* Additional privileged groups: None

### Login Investigation

No login record for `incident_user` was found in the available login history.

No SSH login or SSH session associated with `incident_user` was identified during the investigated time window.

### Process Investigation

No active process belonging to `incident_user` was identified.

### File Investigation

The account home directory contained only standard Bash initialization files.

No suspicious files were identified.

### SSH Persistence

No `.ssh` directory existed for `incident_user`.

No SSH key persistence was identified.

### Scheduled Task Investigation

No user-level cron job existed for `incident_user`.

System-wide cron entries were reviewed and no suspicious entry associated with the simulated account was identified.

Systemd timers were reviewed and no suspicious timer associated with the account was identified.

### Service Investigation

Running systemd services were reviewed.

No suspicious service associated with `incident_user` was identified.

---

## 5. Evidence Collected

The following evidence was collected during the investigation:

* `evidence/account_creation.log`
* `evidence/account_creation_events.log`
* `evidence/evidence_hashes.txt`
* `evidence/investigation_summary.txt`
* `evidence/detection_test.log`

SHA-256 hashes were generated for the account creation evidence files to support evidence integrity verification.

---

## 6. Containment

The simulated account was locked using:

`sudo passwd -l incident_user`

The account remained in a locked state after verification.

Because no evidence of active login, privilege escalation, execution, or persistence was identified, no additional containment actions were required during the simulation.

---

## 7. Recovery

After evidence collection and investigation were completed, the simulated account was removed:

`sudo userdel -r incident_user`

The removal successfully deleted:

* The local account
* The account's home directory

The absence of the account was subsequently confirmed through multiple independent checks.

---

## 8. Post-Recovery Verification

Post-recovery checks confirmed:

* Account no longer exists.
* Account is absent from the passwd database.
* Home directory no longer exists.
* No active process remains for the account.
* Automated account detection returns a clean baseline state.

Final automated detection result:

`[PASS] No new accounts detected.`

---

## 9. Assessment

The controlled simulation successfully demonstrated detection and investigation of an unexpected local account creation event.

The evidence confirms that the account was created during the controlled lab scenario. The available evidence did not identify successful login, privilege escalation, malicious process execution, or persistence mechanisms associated with the account.

The incident was successfully contained, the simulated account was removed, and post-recovery verification confirmed that the system returned to the expected account baseline.

---

## 10. Lessons Learned

This exercise demonstrated the importance of:

* Maintaining a known-good security baseline.
* Monitoring local account creation.
* Investigating account attributes and privileges.
* Reviewing authentication and system logs.
* Checking common persistence mechanisms.
* Preserving and hashing investigation evidence.
* Applying containment before recovery.
* Verifying system state after recovery.
* Automating repetitive detection tasks.

The exercise also demonstrated that an isolated security event should not automatically be classified as a confirmed system compromise without supporting evidence.

---

## 11. Project Outcome

A complete controlled Linux security incident was created, detected, investigated, contained, recovered, and documented.

The project includes:

* Security baseline
* Incident simulation
* Detection logic
* Investigation evidence
* Evidence hashing
* Containment procedure
* Recovery procedure
* Post-recovery verification
* Automated account detection

This project demonstrates practical Incident Detection and Response skills in a Linux environment.

