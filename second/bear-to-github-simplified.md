# Bear to Github Simplified
```
Below is an example of a comprehensive shell script (let’s call it process_and_commit.sh) that implements your workflow. This script assumes that you (or Hazel) have already exported your Bear notes as Markdown files into a temporary folder. The script then does the following:
	1.	Loops through all Markdown files in the temporary folder.
	2.	Reads the last line of each file (which you’re using for tags) and ignores any headers (since headers would have a space after the “#”).
	3.	For each tag on the last line:
	•	Strips off the leading “#”.
	•	Splits the tag by “/” and creates a nested folder structure (starting from the repository root).
	•	Copies the Markdown file into the resulting folder.
	4.	Deletes the processed file from the temporary folder (so that next time the folder is empty).
	5.	After processing all files, it prompts you for a single commit message, commits all changes, and finally asks if you want to push.

You can use Hazel to trigger this script when new files appear in your temporary folder.

⸻



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
REPO_PATH="$HOME/Git/BearVault"            # Change to your repository root path.
TEMP_EXPORT="${REPO_PATH}/temp_export"     # Folder where Bear exports are placed.

# Ensure TEMP_EXPORT exists.
mkdir -p "$TEMP_EXPORT"

echo "Processing files from $TEMP_EXPORT ..."

# Process each Markdown file in TEMP_EXPORT.
for file in "$TEMP_EXPORT"/*.md; do
  # If there are no .md files, skip.
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
  # Extract the last line from the file.
  last_line=$(tail -n 1 "$file")
  
  # Check that the last line is a valid tag line.
  # We assume a valid tag line starts with '#' (with no space after the #, which would indicate a header).
  if [[ "$last_line" =~ ^\#[^[:space:]] ]]; then
    tags_line="$last_line"
  else
    echo "No valid tag line found in $file, skipping file."
    continue
  fi
  
  # Trim whitespace from the tag line.
  tags_line=$(echo "$tags_line" | sed 's/^[ \t]*//;s/[ \t]*$//')
  
  echo "Found tag line: $tags_line"
  
  # Assume tags are separated by whitespace if multiple tags exist.
  for tag in $tags_line; do
    # Remove the leading '#' character.
    tag_content="${tag#\#}"
    
    # Create folder structure from the tag.
    # Split the tag by '/' to support nested tags.
    IFS='/' read -ra parts <<< "$tag_content"
    folder_path="$REPO_PATH"
    for part in "${parts[@]}"; do
      folder_path="$folder_path/$part"
    done
    
    # Create the target folder if it doesn't exist.
    mkdir -p "$folder_path"
    
    # Copy the file into the target folder.
    cp "$file" "$folder_path/"
    echo "Copied $file to $folder_path"
  done
  
  # Remove the processed file from TEMP_EXPORT.
  rm "$file"
  echo "Deleted $file from temp folder."
done

echo "File processing complete."

# === COMMIT CHANGES ===
cd "$REPO_PATH" || exit 1
echo "Preparing to commit changes in repository: $REPO_PATH"

# Prompt the user for a commit message using osascript.
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

⸻

How to Use This Script
	1.	Place Your Exported Files:
Export your Bear note(s) manually to the temp_export folder (e.g., /Users/yourusername/Git/BearVault/temp_export).
	2.	Trigger the Script:
	•	You can run this script manually by executing:

./process_and_commit.sh


	•	Alternatively, set up a Hazel rule that watches temp_export and runs this script automatically when a file is added or modified.

	3.	Review Folder Structure:
The script will read the tag line (assumed to be the last line of each Markdown file) and create a nested folder structure in the repository root accordingly. For example, if the tag is #ai/prompt/MVP, it will create folders /Git/BearVault/ai/prompt/MVP (or, if you prefer a flattened structure, you can modify the script to replace / with another character).
	4.	Commit and Push:
After processing, the script prompts you for a single commit message for all the changes and then asks whether you want to push to the remote repository.

⸻

Additional Suggestions
	•	Tag Line Positioning:
Make sure that when you export from Bear, you manually add (or ensure that the note ends with) the tag line. This minimizes interference from Markdown headers.
	•	Automation Enhancements:
Once you’re comfortable with the manual process, you can use Keyboard Maestro or macOS Shortcuts to automate the export step from Bear. Hazel can be set to trigger this script as soon as new files appear in temp_export.
	•	Error Handling & Logging:
You might want to add additional logging or error checks (e.g., verifying that folders are created successfully) as your workflow matures.

This script should meet your requirements for organizing exported Bear notes by their hashtags (ignoring markdown headers by focusing on the last line), cleaning up the temp directory, and committing/pushing the changes as a single commit. Let me know if you need any further modifications or clarifications!
```
#second
