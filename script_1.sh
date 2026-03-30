#!/bin/bash
# Script 1: System Identity Report
# Course: Open Source Software
# --- Variables ---
STUDENT_NAME="Ananya Sharma"
SOFTWARE_CHOICE="Python"

# --- System info ---
KERNEL=$(uname -r)
USER_NAME=$(whoami)
UPTIME=$(uptime -p)
DISTRO=$(cat /etc/os-release | grep "^PRETTY_NAME" | cut -d'"' -f2)
CURRENT_DATE=$(date +"%A, %B %d, %Y %T")

# --- Display ---
echo "==========================================="
echo "        The Open Source Audit              "
echo "==========================================="
echo "Auditor : $STUDENT_NAME"
echo "Software: $SOFTWARE_CHOICE"
echo "-------------------------------------------"
echo "OS/Distro: $DISTRO"
echo "Kernel   : $KERNEL"
echo "User     : $USER_NAME"
echo "Home Dir : $HOME"
echo "Uptime   : $UPTIME"
echo "Date/Time: $CURRENT_DATE"
echo "-------------------------------------------"
echo "License Note: The core Linux kernel powering this OS is covered by the GPL v2 license."
echo "==========================================="  
