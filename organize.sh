#!/bin/bash
# organize.sh

# === CONFIGURATION ===
REPO_PATH="$HOME/BearVault"         # Change this to your repository location
TEMP_EXPORT="${REPO_PATH}/temp_export"

echo "Organizing exported files by tag..."

# Process all Markdown files in the temporary export folder
for file in "$TEMP_EXPORT"/*.md; do
  [ -e "$file" ] || continue

  # Extract hashtags from the file content.
  # This regex matches either:
  #  1. A tag starting with '#' composed of alphanumerics, slashes, underscores, or hyphens.
  #  2. A multiword tag wrapped with '#' on both ends.
  tags=$(grep -oE '(#[[:alnum:]/_-]+)|(#([^#]+)#)' "$file" | sort | uniq)
  
  if [ -z "$tags" ]; then
    # If no tags are found, move the file to an "untagged" folder in the repo root.
    mkdir -p "${REPO_PATH}/untagged"
    mv "$file" "${REPO_PATH}/untagged/"
    echo "Moved $file to untagged folder."
  else
    # Process each detected tag.
    for tag in $tags; do
      # For multiword tags wrapped in '#' (e.g., "#this is many words#"), remove both the leading and trailing '#'.
      if [[ $tag =~ ^#.*#$ && ${#tag} -gt 2 ]]; then
        tagname="${tag:1:-1}"
      else
        # For other tags, remove the leading '#'
        tagname="${tag:1}"
      fi

      # Flatten nested tags by replacing "/" with "_" (e.g., "ai/prompts/MVP" becomes "ai_prompts_MVP")
      tagname="${tagname//\//_}"
      
      # Create the target folder in the repository root.
      target_folder="${REPO_PATH}/${tagname}"
      mkdir -p "$target_folder"
      
      # Copy the file into the folder.
      cp "$file" "$target_folder/"
      echo "Copied $file to $target_folder."
    done
    # Remove the original file from the temporary folder.
    rm "$file"
  fi
done

echo "Organization complete."