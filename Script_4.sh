#!/bin/bash
# Script 4: Log File Analyzer
# Usage: ./4_log_analyzer.sh /var/log/syslog error

LOGFILE=${1:-"/var/log/syslog"} # Adjust to /var/log/messages for RHEL/CentOS
KEYWORD=${2:-"error"}
COUNT=0

if [ ! -f "$LOGFILE" ]; then
    echo "Error: File $LOGFILE not found or inaccessible."
    exit 1
fi

echo "Scanning $LOGFILE for keyword: '$KEYWORD'..."

# while-read loop to scan line by line
while IFS= read -r LINE; do
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
    fi
done < "$LOGFILE"

echo "==========================================="
echo "Summary: Keyword '$KEYWORD' was found $COUNT times."
echo "==========================================="

# Retry logic: If no matches, print the last 5 lines anyway to show file activity
if [ "$COUNT" -eq 0 ]; then
    echo "No matches found. Here are the last 5 lines of the log for context:"
    tail -n 5 "$LOGFILE"
else
    echo "Recent matches:"
    grep -i "$KEYWORD" "$LOGFILE" | tail -n 5
fi
