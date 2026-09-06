#!/bin/bash

# Lab 02 - SSH Security Test
# Checks SSH service, listening port, and important SSH settings

echo "=========================================="
echo " Lab 02 SSH Security Test"
echo "=========================================="

echo
echo "[1] Checking SSH service status..."

if systemctl is-active --quiet ssh; then
    echo "PASS: SSH service is active."
else
    echo "FAIL: SSH service is not active."
    exit 1
fi

echo
echo "[2] Checking SSH listening port..."

SSH_PORTS=$(sudo ss -tlnp 2>/dev/null | grep -E 'sshd|:22' || true)

if [ -n "$SSH_PORTS" ]; then
    echo "PASS: SSH listening socket detected."
    echo "$SSH_PORTS"
else
    echo "FAIL: SSH listening socket not detected."
    exit 1
fi

echo
echo "[3] Checking PermitRootLogin..."

ROOT_LOGIN=$(sudo sshd -T 2>/dev/null | grep '^permitrootlogin ')

echo "$ROOT_LOGIN"

if echo "$ROOT_LOGIN" | grep -qE 'no|prohibit-password|without-password'; then
    echo "PASS: Direct root password login is restricted."
else
    echo "WARNING: Review PermitRootLogin configuration."
fi

echo
echo "[4] Checking PasswordAuthentication..."

PASSWORD_AUTH=$(sudo sshd -T 2>/dev/null | grep '^passwordauthentication ')

echo "$PASSWORD_AUTH"

if echo "$PASSWORD_AUTH" | grep -q 'yes'; then
    echo "INFO: Password authentication is enabled."
else
    echo "INFO: Password authentication is disabled."
fi

echo
echo "[5] Checking SSH configuration..."

if sudo sshd -t 2>/dev/null; then
    echo "PASS: SSH configuration syntax is valid."
else
    echo "FAIL: SSH configuration contains errors."
    exit 1
fi

echo
echo "=========================================="
echo " SSH security test completed."
echo "=========================================="
