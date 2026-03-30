#!/bin/bash
# Script 2: FOSS Package Inspector
# Usage: ./2_package_inspector.sh <package_name> (e.g., python3)

PACKAGE=${1:-"python3"} # Defaults to python3 if no argument provided

# Check if package is installed (works on Debian/Ubuntu systems using dpkg)
if dpkg -l "$PACKAGE" &> /dev/null; then
    echo "SUCCESS: $PACKAGE is installed on this system."
    echo "--- Package Details ---"
    # Extract version and summary details
    apt-cache show "$PACKAGE" | grep -E 'Version|Description-en' | head -n 2
else
    echo "NOTICE: $PACKAGE is NOT installed."
fi

echo "--- FOSS Philosophy Note ---"
# Case statement for philosophy notes
case $PACKAGE in
    apache2|httpd) 
        echo "Apache: The web server that built the open internet." ;;
    mysql-server|mysql) 
        echo "MySQL: Open source at the heart of millions of apps." ;;
    python3|python) 
        echo "Python: A language shaped entirely by community, fueling the modern AI revolution." ;;
    vlc) 
        echo "VLC: Plays anything - built by students in Paris, a true community triumph." ;;
    *) 
        echo "$PACKAGE: Another piece of the vast open-source puzzle." ;;
esac
