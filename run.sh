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
for file in "${files[@]}"; do
    # Skip if file doesn't exist (handles case where no files match the pattern)
    [ -e "$file" ] || continue

    echo "Processing file: $file"

    # ----- Step 1: Rename file based on the first header (title) -----
    # We assume the first header line is the title and starts with "# " (hash followed by a space).
    title=$(grep -m 1 "^# " "$file" | sed 's/^# *//')
    if [ -n "$title" ]; then
        # Replace spaces with hyphens, convert to lowercase, and remove unwanted characters.
        newname=$(echo "$title" | tr ' ' '-' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]//g')
        newpath="${TEMP_EXPORT}/${newname}.md"
        # Avoid overwriting an existing file; append a timestamp if necessary.
        if [ -e "$newpath" ]; then
            newpath="${TEMP_EXPORT}/${newname}-$(date +%s).md"
        fi
        mv "$file" "$newpath"
        echo "Renamed file to: $newpath"
        file="$newpath"
    else
        echo "No title header found in $file. Skipping renaming."
    fi

    # ----- Step 2: Process tag information from the last line -----
    # Extract the last line from the file
    last_line=$(tail -n 1 "$file")
    
    # Check that the last line contains at least one valid tag (starts with # not followed by a space)
    if [[ "$last_line" =~ ^[[:space:]]*#[^[:space:]] ]]; then
        # Remove leading/trailing whitespace
        last_line=$(echo "$last_line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        echo "Found tag line: $last_line"
        
        # Process each tag (split by whitespace)
        # This will handle multiple tags separated by spaces
        for tag in $last_line; do
            # Skip if this isn't a valid tag
            [[ "$tag" =~ ^#[^[:space:]] ]] || continue
            
            # Remove the leading '#' character
            tag_content="${tag#\#}"
            
            # Create folder structure from the tag
            # Split the tag by '/' to support nested tags
            IFS='/' read -ra parts <<< "$tag_content"
            folder_path="$REPO_PATH"
            for part in "${parts[@]}"; do
                folder_path="$folder_path/$part"
            done
            
            # Create the target folder if it doesn't exist
            mkdir -p "$folder_path"
            
            # Check for duplicates only within the same directory
            if ! is_duplicate_in_dir "$file" "$folder_path"; then
                # Copy the file into the target folder
                cp "$file" "$folder_path/"
                echo "Copied $file to $folder_path"
            else
                echo "Skipping duplicate file in $folder_path"
            fi
        done
    else
        echo "No valid tag line found in $file, skipping file."
        continue
    fi
    
    # Remove the processed file from TEMP_EXPORT
    rm "$file"
    echo "Deleted $file from temp folder."
done

echo "File processing complete."

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