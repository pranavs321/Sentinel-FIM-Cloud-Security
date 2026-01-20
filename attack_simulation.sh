#!/bin/bash
# Sentinel-FIM Attack Simulation Script
# Purpose: Generates file integrity events to trigger Wazuh alerts.

TARGET_DIR="/home/azureuser/secret_project"
FILE_NAME="sensitive_data.txt"

echo "[*] Starting Attack Simulation..."

# Step 1: Create the directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo "Creating target directory..."
    mkdir -p $TARGET_DIR
fi

# Step 2: Create a file (Triggers 'File Added')
echo "[+] Creating sensitive file..."
echo "CONFIDENTIAL PROJECT DATA - DO NOT SHARE" > $TARGET_DIR/$FILE_NAME
sleep 2

# Step 3: Modify the file (Triggers 'File Modified')
echo "[!] Simulating unauthorized modification..."
echo "MALWARE INJECTION: SUCCESS" >> $TARGET_DIR/$FILE_NAME
sleep 2

# Step 4: Delete the file (Triggers 'File Deleted')
echo "[-] Deleting evidence..."
rm $TARGET_DIR/$FILE_NAME

echo "[*] Attack Simulation Complete. Check Dashboard for alerts."
