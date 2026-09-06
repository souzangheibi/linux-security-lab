#!/bin/bash

# Lab 02 - Permission Test
# Tests access to the protected secret file

LAB_USER="labuser"
SECRET_FILE="$HOME/linux-security-lab/labs/lab02-access-privilege-ssh/secret.txt"

echo "=========================================="
echo " Lab 02 Permission Test"
echo "=========================================="

echo
echo "[1] Checking secret file permissions..."

ls -l "$SECRET_FILE"

PERMS=$(stat -c "%a" "$SECRET_FILE")

if [ "$PERMS" = "600" ]; then
    echo "PASS: secret.txt has permissions 600."
else
    echo "FAIL: secret.txt permissions are $PERMS."
    exit 1
fi

echo
echo "[2] Testing owner access..."

if cat "$SECRET_FILE" >/dev/null 2>&1; then
    echo "PASS: Owner can read secret.txt."
else
    echo "FAIL: Owner cannot read secret.txt."
    exit 1
fi

echo
echo "[3] Testing labuser access..."

if sudo -u "$LAB_USER" cat "$SECRET_FILE" >/dev/null 2>&1; then
    echo "FAIL: labuser can read secret.txt."
    exit 1
else
    echo "PASS: labuser cannot read secret.txt."
fi

echo
echo "=========================================="
echo " Permission test completed."
echo "=========================================="
