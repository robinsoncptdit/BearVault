#!/bin/bash
# process_and_commit.sh
# This script processes Bear note exports:
# 1. Reads the last line for Bear tag formatting.
# 2. Creates a nested folder structure in the repo root based on the tags.
# 3. Copies the file into the appropriate folder(s).
# 4. Deletes the file from the temporary folder.
# 5. Commits all changes as one commit and optionally pushes to remote.

# === CONFIGURATION ===
REPO_PATH="$HOME/BearVault"            # Change to your repository root path.
TEMP_EXPORT="${REPO_PATH}/temp_export"     # Folder where Bear exports are placed.

# Ensure TEMP_EXPORT exists.
mkdir -p "$TEMP_EXPORT"

echo "Processing files from $TEMP_EXPORT ..."

# Get list of all .md files in TEMP_EXPORT
files=("$TEMP_EXPORT"/*.md)

# Check if there are any .md files
if [ ${#files[@]} -eq 0 ]; then
    echo "No .md files found in $TEMP_EXPORT"
    exit 1
fi

# Process each Markdown file in TEMP_EXPORT
for file in "${files[@]}"; do
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
cd "$REPO_PATH" || exit 1
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