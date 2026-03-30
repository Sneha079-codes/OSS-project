LOGFILE=$1
KEYWORD=${2:-"error"}   # Default keyword if none is provided

# --- Validate that a log file argument was actually provided ---
if [ -z "$LOGFILE" ]; then
    echo ""
    echo "  [USAGE ERROR] No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo ""
    exit 1   # Exit with a non-zero code to signal failure
fi

echo "================================================================="
echo "          LOG FILE ANALYZER"
echo "================================================================="
echo ""
echo "  Log file : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo ""

# --- Check if the file exists at all ---
if [ ! -f "$LOGFILE" ]; then
    echo "  [ERROR] File '$LOGFILE' does not exist on this system."
    echo ""
    echo "  Common log files to try on Ubuntu:"
    echo "    /var/log/syslog"
    echo "    /var/log/auth.log"
    echo "    /var/log/kern.log"
    echo "    /var/log/dpkg.log"
    echo ""
    exit 1
fi

# --- Do-while style retry: if file is empty, prompt user to try another ---
# Bash doesn't have a native do-while, so we use a while loop with a break
MAX_RETRIES=3    # Maximum number of times to ask for a different file
RETRY=0

while true; do
    # Check if the file is empty using -s (true if file has size > 0)
    if [ ! -s "$LOGFILE" ]; then
        RETRY=$((RETRY + 1))

        echo "  [WARNING] The file '$LOGFILE' is empty."

        # If we've retried too many times, give up gracefully
        if [ $RETRY -ge $MAX_RETRIES ]; then
            echo "  [ABORT] Maximum retries reached. Please check your log files."
            echo ""
            exit 1
        fi

        # Ask the user to provide a different file path
        echo "  Please enter a different log file path (attempt $RETRY of $MAX_RETRIES):"
        read -r LOGFILE   # read replaces the variable with new input

        # Check if the newly entered file exists before continuing
        if [ ! -f "$LOGFILE" ]; then
            echo "  [ERROR] '$LOGFILE' does not exist either. Trying again..."
            continue   # Go back to the top of the while loop
        fi
    else
        # File is non-empty, exit the retry loop
        break
    fi
done

# --- Main analysis: read the log file line by line ---
COUNT=0           # Counter for keyword matches
MATCH_LINES=()    # Array to store matching lines (for printing last 5 later)

# IFS= prevents leading/trailing whitespace from being stripped
# -r prevents backslash interpretation in lines
while IFS= read -r LINE; do

    # grep -iq: case-insensitive (-i), quiet mode (-q, no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))         # Increment match counter
        MATCH_LINES+=("$LINE")       # Append matching line to array
    fi

done < "$LOGFILE"   # Redirect file content into the while loop

echo "-----------------------------------------------------------------"
echo "  ANALYSIS RESULTS"
echo "-----------------------------------------------------------------"
echo ""

# --- Print summary ---
TOTAL_LINES=$(wc -l < "$LOGFILE")   # Count total lines in the file
echo "  Total lines in file    : $TOTAL_LINES"
echo "  Keyword matches found  : $COUNT"

# --- Handle case where no matches were found ---
if [ $COUNT -eq 0 ]; then
    echo ""
    echo "  No lines containing '$KEYWORD' were found in $LOGFILE."
    echo "  Try a different keyword or check the correct log file."
    echo ""
    exit 0
fi

echo ""
echo "-----------------------------------------------------------------"
echo "  LAST 5 MATCHING LINES"
echo "-----------------------------------------------------------------"
echo ""

# --- Print the last 5 matching lines from the array ---
# ${#MATCH_LINES[@]} = length of array
TOTAL_MATCHES=${#MATCH_LINES[@]}

# Calculate starting index: if fewer than 5 matches, start from 0
if [ $TOTAL_MATCHES -le 5 ]; then
    START=0
else
    START=$((TOTAL_MATCHES - 5))
fi

# Slice and print the last 5 (or fewer) matching lines
for ((i=START; i<TOTAL_MATCHES; i++)); do
    echo "  >> ${MATCH_LINES[$i]}"
done

echo ""
echo "================================================================="
echo "  Done. Found $COUNT occurrence(s) of '$KEYWORD' in $LOGFILE."
echo "================================================================="
echo ""
