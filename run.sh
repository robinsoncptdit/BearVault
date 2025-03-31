#!/bin/bash
# process_and_commit.sh
# This script processes Bear note exports:
# 1. Renames each markdown file in the temporary export folder using the first header (as title) with hyphens.
# 2. Reads the last line for Bear tag formatting.
# 3. Creates a nested folder structure in the repo root based on the tags.
# 4. Copies the file into the appropriate folder(s).
# 5. Deletes the file from the temporary folder.
# 6. Commits all changes as one commit and optionally pushes to remote.

# === CONFIGURATION ===
REPO_PATH="$HOME/BearVault"            # Change to your repository root path.
TEMP_EXPORT="${REPO_PATH}/temp_export"     # Folder where Bear exports are placed.

# Ensure TEMP_EXPORT exists.
mkdir -p "$TEMP_EXPORT"

# Function to clean up Bear's Markdown formatting
cleanup_markdown() {
    local file="$1"
    local temp_file="${file}.tmp"
    
    # Use perl for more reliable text processing
    perl -pe '
        # Fix headers by removing extra # marks
        s/^(#)\s*#+\s*/\1 /g;
        # Ensure exactly one space after remaining #
        s/^#([^\s])/# \1/g;
        # Fix Bear ++text++ to **text**
        s/\+\+([^\+]+)\+\+/*\1*/g;
        # Fix underscores
        s/__([^_]+)__/**\1**/g;
        s/_([^_]+)_/*\1*/g;
        # Fix bullets
        s/^[\s]*[•○●][\s]*/-/g;
        # Fix checkboxes
        s/^[\s]*☐/- [ ]/g;
        s/^[\s]*☒/- [x]/g;
        # Fix Bear inline code
        s/::([^:]+)::/`\1`/g;
        # Fix Bear highlighting
        s/==[\s]*([^=]+)[\s]*==/**\1**/g;
        # Remove trailing whitespace
        s/[\s]+$//g;
    ' "$file" > "$temp_file"
    
    if [ -f "$temp_file" ]; then
        mv "$temp_file" "$file"
        return 0
    else
        echo "Error: Failed to clean up markdown in $file"
        return 1
    fi
}

echo "Processing files from $TEMP_EXPORT ..."

# Get list of all .md files in TEMP_EXPORT
files=("$TEMP_EXPORT"/*.md)

# Check if there are any .md files
if [ ${#files[@]} -eq 0 ]; then
    echo "No .md files found in $TEMP_EXPORT"
    exit 1
fi

# Function to get content hash of a file (excluding the last line with tags)
get_content_hash() {
    local file="$1"
    # Get all lines except the last one and compute hash
    head -n -1 "$file" | md5
}

# Function to check if a file is a duplicate within the same directory
is_duplicate_in_dir() {
    local source_file="$1"
    local target_dir="$2"
    local source_hash=$(get_content_hash "$source_file")
    
    # Check all .md files in target directory
    for existing_file in "$target_dir"/*.md; do
        [ -e "$existing_file" ] || continue
        if [ "$(get_content_hash "$existing_file")" = "$source_hash" ]; then
            return 0  # Found a duplicate
        fi
    done
    return 1  # No duplicate found
}

# Process each Markdown file in TEMP_EXPORT
for file in "$TEMP_EXPORT"/*.md; do
    [ -e "$file" ] || continue
    echo "Processing $file"
    
    # Get the last line for tags
    last_line=$(tail -n 1 "$file")
    
    # Process each tag in the last line
    if [[ "$last_line" =~ ^.*#[^[:space:]] ]]; then
        echo "Found tags: $last_line"
        # Split on spaces and process each tag
        for tag in $last_line; do
            if [[ "$tag" =~ ^# ]]; then
                # Remove the # and create directory
                tag_dir="${tag#\#}"
                mkdir -p "$REPO_PATH/$tag_dir"
                cp "$file" "$REPO_PATH/$tag_dir/"
            fi
        done
        # Remove the processed file
        rm "$file"
    else
        echo "No tags found in $file"
    fi
done

# Clean up any empty directories
find "$REPO_PATH" -type d -empty -delete

echo "Processing complete."

# === COMMIT CHANGES ===
echo "Preparing to commit changes in repository: $REPO_PATH"

# Prompt the user for a commit message using osascript
commit_msg=$(osascript -e 'Tell application "System Events" to display dialog "Enter commit message for Bear exports:" default answer ""' -e 'text returned of result')

if [ -n "$commit_msg" ]; then
    git add .
    git commit -m "$commit_msg"
    echo "Committed changes with message: $commit_msg"
else
    echo "No commit message provided. Aborting commit."
    exit 1
fi

# === PUSH CHOICE ===
push_choice=$(osascript -e 'Tell application "System Events" to display dialog "Push commit to remote?" buttons {"Wait", "Push"} default button "Push"' -e 'button returned of result')

if [ "$push_choice" == "Push" ]; then
    git push
    echo "Pushed commit to remote."
else
    echo "Push canceled. Commit remains local."
fi

echo "Process complete."