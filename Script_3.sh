DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib" "/opt")

echo "================================================================="
echo "          DISK AND PERMISSION AUDITOR"
echo "================================================================="
echo ""
echo "  Auditing standard system directories..."
echo ""
printf "  %-20s %-25s %-10s\n" "DIRECTORY" "PERMISSIONS (perm owner grp)" "SIZE"
echo "  ---------------------------------------------------------------"

# --- For loop: iterate over each directory in the DIRS array ---
# The "${DIRS[@]}" syntax expands the array safely, even with spaces in names
for DIR in "${DIRS[@]}"; do

    # Check if the directory actually exists before trying to read it
    if [ -d "$DIR" ]; then
        # ls -ld lists the directory itself (not its contents)
        # awk extracts fields: $1=permissions, $3=owner, $4=group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # du -sh gives human-readable size; 2>/dev/null suppresses permission errors
        # cut -f1 extracts only the size column (tab-separated)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # printf for aligned, readable output
        printf "  %-20s %-25s %-10s\n" "$DIR" "$PERMS" "${SIZE:-N/A}"
    else
        printf "  %-20s %s\n" "$DIR" "[Does not exist on this system]"
    fi
done

echo ""
echo "================================================================="
echo "  PYTHON-SPECIFIC DIRECTORY AUDIT"
echo "================================================================="
echo ""
echo "  Checking directories where Python lives on this system..."
echo ""

# --- Python-specific directories to check ---
# These are the locations Python typically installs to on Ubuntu/Debian
PYTHON_DIRS=(
    "/usr/bin/python3"           # The main Python 3 executable
    "/usr/lib/python3"           # Standard library location
    "/usr/lib/python3/dist-packages"  # System-installed third-party packages
    "/usr/local/lib"             # User-installed libraries (pip install)
    "/etc/python3"               # Python system config (if any)
)

for PYDIR in "${PYTHON_DIRS[@]}"; do

    # Check for both files and directories since /usr/bin/python3 is a file
    if [ -e "$PYDIR" ]; then
        # ls -ld works on both files and directories
        PERMS=$(ls -ld "$PYDIR" | awk '{print $1, $3, $4}')
        SIZE=$(du -sh "$PYDIR" 2>/dev/null | cut -f1)
        printf "  %-42s %-25s %-10s\n" "$PYDIR" "$PERMS" "${SIZE:-N/A}"
    else
        printf "  %-42s %s\n" "$PYDIR" "[Not found]"
    fi
done

echo ""
echo "-----------------------------------------------------------------"
echo "  WHY PERMISSIONS MATTER FOR SECURITY"
echo "-----------------------------------------------------------------"
echo ""
echo "  In Linux, file permissions control who can read, write, or"
echo "  execute a file. For open-source software like Python:"
echo ""
echo "  - Binaries in /usr/bin are owned by root and executable by all."
echo "    This means any user can run Python, but only root can replace it."
echo ""
echo "  - System libraries in /usr/lib are also root-owned, preventing"
echo "    unprivileged users from injecting malicious code into shared libs."
echo ""
echo "  - /tmp is world-writable (sticky bit set), so any user can write"
echo "    temporary files but cannot delete files owned by others."
echo ""

# --- Bonus: check the Python version currently active ---
echo "-----------------------------------------------------------------"
echo "  PYTHON VERSION DETECTION"
echo "-----------------------------------------------------------------"
echo ""

# 'command -v' is more portable than 'which' for checking if a command exists
if command -v python3 &>/dev/null; then
    PY_VERSION=$(python3 --version 2>&1)
    PY_PATH=$(command -v python3)
    echo "  Active Python : $PY_VERSION"
    echo "  Binary at     : $PY_PATH"
else
    echo "  python3 is not available in PATH on this system."
fi

echo ""
echo "================================================================="
