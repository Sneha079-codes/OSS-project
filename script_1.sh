STUDENT_NAME="[STUDENT_NAME]"        # Replace with your name
REG_NUMBER="[REG_NUMBER]"            # Replace with your registration number
SOFTWARE_CHOICE="Python"             # The open-source software being audited

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                   # Get the running kernel version
USER_NAME=$(whoami)                  # Get the currently logged-in username
HOME_DIR=$HOME                       # Get the home directory of current user
UPTIME=$(uptime -p)                  # Get human-readable system uptime
CURRENT_DATE=$(date '+%A, %d %B %Y') # Format: Day, DD Month YYYY
CURRENT_TIME=$(date '+%H:%M:%S')     # Format: HH:MM:SS (24-hour)

# --- Detect Linux distribution name from /etc/os-release ---
# /etc/os-release is the standard file for distro identification on modern Linux
if [ -f /etc/os-release ]; then
    # Source the file to load its variables, then read PRETTY_NAME
    DISTRO=$(grep '^PRETTY_NAME' /etc/os-release | cut -d'"' -f2)
else
    # Fallback if the file doesn't exist (very old systems)
    DISTRO="Unknown Linux Distribution"
fi

# --- Identify the OS license ---
# Most Linux distributions run on the Linux kernel which is GPL v2 licensed.
# Ubuntu specifically uses many GPL v2 components plus its own open packaging.
OS_LICENSE="GNU General Public License v2 (GPL v2) — Linux Kernel"

# --- Display the formatted system identity report ---
echo "================================================================="
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT"
echo "================================================================="
echo ""
echo "  Student  : $STUDENT_NAME"
echo "  Reg No   : $REG_NUMBER"
echo "  Project  : Auditing '$SOFTWARE_CHOICE'"
echo ""
echo "-----------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "-----------------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged in as : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  System Uptime: $UPTIME"
echo ""
echo "-----------------------------------------------------------------"
echo "  DATE & TIME"
echo "-----------------------------------------------------------------"
echo "  Date : $CURRENT_DATE"
echo "  Time : $CURRENT_TIME"
echo ""
echo "-----------------------------------------------------------------"
echo "  LICENSE INFORMATION"
echo "-----------------------------------------------------------------"
echo "  OS License   : $OS_LICENSE"
echo ""
echo "  The Linux kernel is free software: you can redistribute it"
echo "  and/or modify it under the terms of the GNU General Public"
echo "  License version 2 as published by the Free Software Foundation."
echo ""
echo "================================================================="
echo "  'The power to control your software, and to share that"
echo "   control with your neighbor.' — Richard Stallman"
echo "================================================================="
