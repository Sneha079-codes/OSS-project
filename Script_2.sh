PACKAGE=${1:-python3}

echo "================================================================="
echo "         FOSS PACKAGE INSPECTOR"
echo "================================================================="
echo ""
echo "  Inspecting package: $PACKAGE"
echo ""

# --- Check if the package is installed using dpkg (Debian/Ubuntu) ---
# dpkg -s returns exit code 0 if installed, non-zero otherwise
# We redirect all output to /dev/null so it doesn't clutter the screen
if dpkg -s "$PACKAGE" &>/dev/null; then
    echo "  [STATUS] $PACKAGE is INSTALLED on this system."
    echo ""

    # --- Extract specific fields from dpkg info using grep and awk ---
    echo "-----------------------------------------------------------------"
    echo "  PACKAGE DETAILS"
    echo "-----------------------------------------------------------------"

    # dpkg -s prints many fields; we filter for the ones we care about
    VERSION=$(dpkg -s "$PACKAGE" 2>/dev/null | grep '^Version' | awk '{print $2}')
    LICENSE_INFO=$(dpkg -s "$PACKAGE" 2>/dev/null | grep '^License' | awk '{print $2}')
    DESCRIPTION=$(dpkg -s "$PACKAGE" 2>/dev/null | grep '^Description' | cut -d: -f2- | xargs)

    echo "  Version     : ${VERSION:-Not available}"
    echo "  License     : ${LICENSE_INFO:-See /usr/share/doc/$PACKAGE/copyright}"
    echo "  Description : ${DESCRIPTION:-Not available}"

    # --- Also show the binary location if it exists ---
    # 'which' finds the executable path in the user's PATH
    BINARY=$(which "$PACKAGE" 2>/dev/null)
    if [ -n "$BINARY" ]; then
        echo "  Binary Path : $BINARY"
    fi

else
    # --- Package is not installed ---
    echo "  [STATUS] $PACKAGE is NOT installed on this system."
    echo ""
    echo "  To install it on Ubuntu/Debian, run:"
    echo "    sudo apt update && sudo apt install $PACKAGE"
fi

echo ""
echo "-----------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "-----------------------------------------------------------------"
echo ""

# --- Case statement: print a philosophy note based on the package name ---
# Case is ideal here because we're matching a variable against fixed patterns
case "$PACKAGE" in
    python3 | python)
        echo "  Python: Born from Guido van Rossum's desire to create a language"
        echo "  that was readable and accessible to everyone. The PSF license"
        echo "  ensures Python remains free for all — students, researchers,"
        echo "  and companies alike. Its community-driven model (PEPs) means"
        echo "  the language evolves through public consensus, not boardroom decisions."
        ;;
    apache2 | httpd)
        echo "  Apache HTTP Server: The web server that helped the early internet"
        echo "  grow freely. Its permissive Apache 2.0 license allows businesses"
        echo "  to build commercial products on top of it without giving back —"
        echo "  a deliberate choice to maximise adoption over copyleft purity."
        ;;
    git)
        echo "  Git: Linus Torvalds built this in two weeks after BitKeeper revoked"
        echo "  free access to the Linux kernel team. GPL v2 licensed — it embodies"
        echo "  the idea that version control, like the kernel itself, should be"
        echo "  a shared public resource no company can hold hostage."
        ;;
    firefox | firefox-esr)
        echo "  Firefox: Mozilla's answer to browser monopoly. MPL 2.0 licensed,"
        echo "  governed by a nonprofit — Firefox exists to prove that an open,"
        echo "  privacy-respecting browser can compete with trillion-dollar companies."
        ;;
    vlc)
        echo "  VLC: Written by students at a French engineering school who just"
        echo "  wanted to stream video on their campus network. LGPL/GPL licensed,"
        echo "  it plays virtually every format ever created — because no codec"
        echo "  restriction could survive an open-source workaround."
        ;;
    mysql | mysql-server)
        echo "  MySQL: A dual-license story — GPL for open-source projects, commercial"
        echo "  for proprietary ones. When Oracle acquired it, the community forked"
        echo "  it into MariaDB — proof that copyleft alone cannot fully protect"
        echo "  a project if a corporation controls the trademark."
        ;;
    *)
        # Default case for any package not explicitly listed
        echo "  $PACKAGE is part of the broader FOSS ecosystem. Open-source"
        echo "  software gives users the freedom to use, study, modify, and"
        echo "  distribute — freedoms that proprietary software deliberately removes."
        ;;
esac

echo ""
echo "================================================================="
