#!/bin/bash
# Linux Security Lab 03 - Network Security Audit
audit_status=0
printf '\n=== Listening Ports ===\n'
sudo ss -tulpn

printf '\n=== SSH Hardening Check ===\n'
sudo sshd -T | grep -E '^(passwordauthentication|permitrootlogin)'
password_auth=$(sudo sshd -T | awk '/^passwordauthentication/ {print $2}')
if [ "$password_auth" = "no" ]; then
    echo "[PASS] Password authentication is disabled"
else
    echo "[WARN] Password authentication is enabled"
fi
root_login=$(sudo sshd -T | awk '/^permitrootlogin/ {print $2}')
if [ "$root_login" = "no" ]; then
    echo "[PASS] Direct root login is disabled"
else
    echo "[WARN] Direct root login is allowed"
fi

printf '\n=== Active Network Connections ===\n'
sudo ss -tupn

printf '\n=== SSH Authentication Monitoring ===\n'
auth_failures=$(sudo journalctl -u ssh --since "today" --no-pager | grep -Ei 'failed|invalid|authentication failure|refused')
if [ -z "$auth_failures" ]; then
    echo "[PASS] No SSH authentication failures detected today"
else
    echo "[WARN] SSH authentication failures detected:"
    echo "$auth_failures"
    audit_status=1
fi
exit "$audit_status"
