#!/bin/bash

echo "=== Account Detection ==="

current_users=$(cut -d: -f1 /etc/passwd)

baseline_users=$(sed -n '/=== ACCOUNT BASELINE ===/,/Baseline captured at:/p' baseline.txt | grep -v '=== ACCOUNT BASELINE ===' | grep -v 'Baseline captured at:')

new_users=$(comm -13 <(printf '%s\n' "$baseline_users" | sort) <(printf '%s\n' "$current_users" | sort))

if [ -z "$new_users" ]; then
    echo "[PASS] No new accounts detected."
else
    echo "[ALERT] New account(s) detected:"
    echo "$new_users"
fi
