#!/bin/bash
# Script 5: Open Source Manifesto Generator

echo "Answer three questions to generate your manifesto."
echo "--------------------------------------------------"

read -p "1. Name one open-source tool you use every day: " TOOL
read -p "2. In one word, what does 'freedom' mean to you? " FREEDOM
read -p "3. Name one AIML or software project you would build and share freely: " BUILD

DATE=$(date +'%d %B %Y')
OUTPUT="manifesto_$(whoami).txt"

# Clear the file if it exists, or create it
> "$OUTPUT"

# Compose the paragraph and append it to the file using >>
echo "=========================================" >> "$OUTPUT"
echo "      MY OPEN SOURCE MANIFESTO           " >> "$OUTPUT"
echo "      Date: $DATE                        " >> "$OUTPUT"
echo "=========================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "I believe that software should empower, not restrict. Every day, I rely on tools like $TOOL to learn, build, and grow." >> "$OUTPUT"
echo "To me, the core of the open-source philosophy boils down to one word: $FREEDOM." >> "$OUTPUT"
echo "Because of the open-source giants whose shoulders I stand on, I pledge to one day build and freely share $BUILD with the global community." >> "$OUTPUT"
echo "Knowledge belongs to everyone." >> "$OUTPUT"

echo ""
echo "Manifesto successfully saved to $OUTPUT"
echo "--- Preview ---"
cat "$OUTPUT"
