get_today() {
    date '+%d %B %Y'   # Returns formatted date like: 15 June 2025
}

get_timestamp() {
    date '+%Y%m%d_%H%M%S'   # Returns timestamp for unique filenames
}

# --- Display intro banner ---
clear   # Clear the terminal for a clean presentation
echo "================================================================="
echo "       THE OPEN SOURCE MANIFESTO GENERATOR"
echo "================================================================="
echo ""
echo "  This tool will generate a personalised open-source philosophy"
echo "  statement based on your answers to three questions."
echo ""
echo "  Your manifesto will be saved as a .txt file when complete."
echo ""
echo "================================================================="
echo ""

# --- Question 1: An open-source tool the user uses daily ---
# 'read -p' prints the prompt and waits for input on the same line
echo "  Please answer the following questions thoughtfully."
echo "  Your answers will be woven into your personal manifesto."
echo ""

read -p "  1. Name one open-source tool you use every day: " TOOL

# --- Validate input: don't allow an empty answer ---
while [ -z "$TOOL" ]; do
    echo "  [!] You must enter a tool name. Please try again."
    read -p "  1. Name one open-source tool you use every day: " TOOL
done

echo ""

# --- Question 2: What freedom means to the user ---
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM

# Validate non-empty
while [ -z "$FREEDOM" ]; do
    echo "  [!] Please enter at least one word."
    read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
done

echo ""

# --- Question 3: What they would build and share freely ---
read -p "  3. Name one thing you would build and share freely: " BUILD

# Validate non-empty
while [ -z "$BUILD" ]; do
    echo "  [!] Please enter something you would build."
    read -p "  3. Name one thing you would build and share freely: " BUILD
done

echo ""
echo "  Generating your manifesto..."
echo ""

# --- Prepare output variables ---
DATE=$(get_today)                              # Get today's date using our function
USERNAME=$(whoami)                             # Get current Linux username
TIMESTAMP=$(get_timestamp)                     # Unique timestamp for filename
OUTPUT="manifesto_${USERNAME}_${TIMESTAMP}.txt" # Unique output filename

# --- String concatenation to build the manifesto ---
# We build the manifesto paragraph by paragraph using echo and >>
# > creates/overwrites the file; >> appends to it

# Write the header to the file (> creates fresh file)
echo "=================================================================" > "$OUTPUT"
echo "            MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "=================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Author    : $USERNAME" >> "$OUTPUT"
echo "  Generated : $DATE" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "-----------------------------------------------------------------" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Compose the body paragraph using the user's answers ---
# String concatenation happens naturally in bash when variables are placed
# inside double-quoted strings
PARA1="Every day, I reach for $TOOL — not because I have to, but because"
PARA1="$PARA1 someone chose to build it in the open and give it away freely."
PARA1="$PARA1 That choice changed what was possible for me, and for everyone"
PARA1="$PARA1 who came after."

PARA2="To me, freedom is $FREEDOM. In the world of software, that word has"
PARA2="$PARA2 a precise meaning: the freedom to use, to study, to modify, and"
PARA2="$PARA2 to share. These are not abstract ideals — they are the conditions"
PARA2="$PARA2 that made $TOOL possible in the first place."

PARA3="I believe that knowledge grows when it is shared, not when it is locked."
PARA3="$PARA3 That is why, if I build $BUILD, I will release it under an open"
PARA3="$PARA3 license — not because I have to, but because I understand what it"
PARA3="$PARA3 means to benefit from the work of people who did the same before me."

PARA4="Open source is not charity. It is how the best software in the world"
PARA4="$PARA4 gets built — by communities of people who trust each other enough"
PARA4="$PARA4 to share their work. I intend to be part of that."

# --- Write the composed paragraphs to the file ---
echo "  $PARA1" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  $PARA2" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  $PARA3" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  $PARA4" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "-----------------------------------------------------------------" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Signed: $USERNAME | $DATE" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "=================================================================" >> "$OUTPUT"

# --- Confirm the file was saved ---
echo "================================================================="
echo "  Manifesto saved to: $OUTPUT"
echo "================================================================="
echo ""

# --- Display the manifesto on screen ---
cat "$OUTPUT"

echo ""
echo "  Your manifesto has been saved. Share it, print it, or commit"
echo "  it to your GitHub repository as part of this audit."
echo ""
