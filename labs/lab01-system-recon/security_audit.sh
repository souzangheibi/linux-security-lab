#!/bin/bash

echo "========================================"
echo "       Linux Security Audit"
echo "========================================"

echo ""
echo "[+] System Information"
echo "----------------------------------------"
uname -a

echo ""
echo "[+] Operating System"
echo "----------------------------------------"
cat /etc/os-release

echo ""
echo "[+] Current User and Groups"
echo "----------------------------------------"
id

echo ""
echo "[+] Local User Accounts"
echo "----------------------------------------"
cut -d: -f1 /etc/passwd

echo ""
echo "[+] Local Groups"
echo "----------------------------------------"
cut -d: -f1 /etc/group

echo ""
echo "[+] Process Analysis"
echo "----------------------------------------"
ps -eo user,pid,ppid,stat,cmd

echo ""
echo "[+] Privileged Process Review"
echo "----------------------------------------"
ROOT_PROCESS_COUNT=$(ps -eo user= | awk '$1=="root" {count++} END {print count}')
echo "Root-owned processes: $ROOT_PROCESS_COUNT"

echo ""
echo "[+] Network Interfaces"
echo "----------------------------------------"
ip -br addr

echo ""
echo "[+] Routing Table"
echo "----------------------------------------"
ip route

echo ""
echo "[+] Listening Network Services"
echo "----------------------------------------"
ss -tuln

echo ""
echo "[+] Authentication Log Review"
echo "----------------------------------------"

if [ -r /var/log/auth.log ]; then
    FAILED_AUTH_COUNT=$(grep -ic "failed" /var/log/auth.log)
    echo "Failed authentication-related events: $FAILED_AUTH_COUNT"

    if [ "$FAILED_AUTH_COUNT" -gt 0 ]; then
        echo "[!] Review required: failed authentication events detected."
    else
        echo "[+] No failed authentication events detected."
    fi
else
    echo "[!] /var/log/auth.log is not readable."
    echo "[!] Run the audit with appropriate privileges if required."
fi

echo ""
echo "[+] Sensitive File Permission Audit"
echo "----------------------------------------"

for FILE in /etc/passwd /etc/shadow /etc/group /etc/sudoers; do
    if [ -e "$FILE" ]; then
        PERMISSIONS=$(stat -c "%A %U:%G" "$FILE")
        echo "$FILE -> $PERMISSIONS"
    else
        echo "[!] File not found: $FILE"
    fi
done

echo ""
echo "[+] SUID Binary Audit"
echo "----------------------------------------"

SUID_COUNT=$(find /usr/bin /usr/sbin -type f -perm /4000 2>/dev/null | wc -l)
echo "SUID binaries found: $SUID_COUNT"

if [ "$SUID_COUNT" -gt 0 ]; then
    echo "[!] Review required: SUID binaries detected."
else
    echo "[+] No SUID binaries detected."
fi

echo ""
echo "[+] SGID Binary Audit"
echo "----------------------------------------"

SGID_COUNT=$(find /usr/bin /usr/sbin -type f -perm /2000 2>/dev/null | wc -l)
echo "SGID binaries found: $SGID_COUNT"

if [ "$SGID_COUNT" -gt 0 ]; then
    echo "[!] Review required: SGID binaries detected."
else
    echo "[+] No SGID binaries detected."
fi

echo ""
echo "========================================"
echo "        SECURITY FINDINGS"
echo "========================================"

if [ "$FAILED_AUTH_COUNT" -gt 0 ]; then
    echo "[MEDIUM] Failed authentication-related events detected."
else
    echo "[INFO] No failed authentication-related events detected."
fi

if [ "$ROOT_PROCESS_COUNT" -gt 0 ]; then
    echo "[INFO] Root-owned processes detected. Review if unexpected."
fi

if [ "$SUID_COUNT" -gt 0 ]; then
    echo "[INFO] SUID binaries detected. Review for necessity and risk."
fi

if [ "$SGID_COUNT" -gt 0 ]; then
    echo "[INFO] SGID binaries detected. Review for necessity and risk."
fi

echo ""
echo "[+] Audit completed."
