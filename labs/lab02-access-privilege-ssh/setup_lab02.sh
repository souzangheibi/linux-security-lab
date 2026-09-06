#!/bin/bash

# Lab 02 - Access, Privilege & SSH
# Setup and verification script

set -e

LAB_USER="labuser"
LAB_DIR="$HOME/linux-security-lab/labs/lab02-access-privilege-ssh"
SECRET_FILE="$LAB_DIR/secret.txt"

echo "=========================================="
echo " Lab 02 Setup"
echo "=========================================="

echo "[1] Checking lab user..."

if id "$LAB_USER" >/dev/null 2>&1; then
    echo "PASS: User '$LAB_USER' already exists."
else
    sudo useradd -m -s /bin/bash "$LAB_USER"
    echo "PASS: User '$LAB_USER' created."
fi

echo
echo "[2] Checking home directory..."

if [ -d "/home/$LAB_USER" ]; then
    echo "PASS: /home/$LAB_USER exists."
else
    sudo mkdir -p "/home/$LAB_USER"
    sudo chown "$LAB_USER:$LAB_USER" "/home/$LAB_USER"
    echo "PASS: /home/$LAB_USER created."
fi

echo
echo "[3] Checking secret file..."

if [ -f "$SECRET_FILE" ]; then
    echo "PASS: secret.txt exists."
else
    echo "CONFIDENTIAL LAB DATA" > "$SECRET_FILE"
    echo "PASS: secret.txt created."
fi

echo
echo "[4] Setting secure file permissions..."

chmod 600 "$SECRET_FILE"

echo "PASS: secret.txt permissions set to 600."

echo
echo "[5] Verifying configuration..."

ls -l "$SECRET_FILE"
ls -ld "/home/$LAB_USER"

echo
echo "=========================================="
echo " Lab 02 setup completed successfully."
echo "=========================================="
