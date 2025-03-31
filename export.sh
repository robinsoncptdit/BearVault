#!/bin/bash
# export.sh

# === CONFIGURATION ===
REPO_PATH="$HOME/BearVault"            # Change to your repository location
TEMP_EXPORT="${REPO_PATH}/temp_export"
BEAR_CLI="/usr/local/bin/bear"              # Adjust if Bear CLI is installed elsewhere

# Create the temporary export folder if it doesn't exist
mkdir -p "$TEMP_EXPORT"

echo "Exporting notes from Bear to $TEMP_EXPORT..."

# Export all notes as Markdown (adjust command as needed)
"$BEAR_CLI" export --output "$TEMP_EXPORT" --format markdown

echo "Export completed."