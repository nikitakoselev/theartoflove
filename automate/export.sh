#!/bin/bash

# 1. Create the 'dump' folder in the project root if it doesn't exist
mkdir -p ../dump

# 2. Generate a smart filename with YearMonthDay-HourMinuteSecond
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
OUTPUT_FILE="../dump/project-summary-${TIMESTAMP}.md"

echo "=== Export Started ==="
echo "Creating file: ${OUTPUT_FILE}"

# 3. Write a clean header into the summary file
echo "# Project Export Log - ${TIMESTAMP}" > "$OUTPUT_FILE"
echo "Generated automatically on $(date)" >> "$OUTPUT_FILE"
echo -e "\n---\n" >> "$OUTPUT_FILE"

# 4. Find all .md files from the project root (excluding .git, dump, and automate folders)
# and append their content with clear boundaries
find .. -type f -name "*.md" -not -path '*/.*' -not -path '../dump/*' -not -path '../automate/*' | while read -r file; do
    # Clean up the relative path visualization for readability
    CLEAN_PATH=$(echo "$file" | sed 's|^\.\./||')
    echo "Adding: $CLEAN_PATH"
    
    echo -e "\n\n=========================================" >> "$OUTPUT_FILE"
    echo "=== FILE: $CLEAN_PATH ===" >> "$OUTPUT_FILE"
    echo -e "=========================================\n" >> "$OUTPUT_FILE"
    cat "$file" >> "$OUTPUT_FILE"
done

echo -e "\n=== Export Finished! Check the 'dump' folder in the root ==="