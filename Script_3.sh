#!/bin/bash
# Script 3: Disk and Permission Auditor

# Array of directories, including Python's core library path
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib/python3")

echo "==========================================="
echo "        Directory Audit Report             "
echo "==========================================="

for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, and group using ls -ld and awk
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')
        # Extract size using du and cut
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        
        echo "Directory: $DIR"
        echo " -> Permissions/Owner: $PERMS"
        echo " -> Disk Size: $SIZE"
        echo "-------------------------------------------"
    else
        echo "Directory: $DIR"
        echo " -> NOTICE: Does not exist on this system."
        echo "-------------------------------------------"
    fi
done
