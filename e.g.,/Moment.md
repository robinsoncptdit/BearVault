# Bear to Github via Hazel
Below is a comprehensive guide that walks you through the entire process—from setting up your GitHub repository and configuring Bear’s tagging to creating the shell scripts and integrating Hazel for automatic Git commits. At the end, you’ll also find some ideas for further automating the execution of these scripts.

⸻

# 1. Overview of the Workflow
	* 	**Bear.app:**
You use Bear to capture your notes in Markdown. You leverage its tagging system—including nested tags (e.g., (hashtag)ai/prompts/MVP) and multiword tags (e.g., (hashtag)this is many words(#))—to organize content. Best practice: Be consistent with your tagging format and try to use clear tag names.
	* 	**Export & Organize:**
The Bear CLI exports your notes into a temporary folder (temp_export). A shell script then scans each Markdown file, extracts the tags, and moves (or copies) the files into subfolders named after those tags directly in your repository root. This ensures your repo remains clean and well-organized.
	* 	**Git & Hazel:**
Your Git repository tracks the organized files. Hazel is set up to watch for changes in these folders and automatically prompt you for a commit message and commit the changes. This creates a seamless, almost real-time backup of your notes.
	* 	**Automation Possibilities:**
While you run the scripts manually at first, ideas for full automation include scheduling via Cron, using macOS Shortcuts, or tools like Keyboard Maestro.

⸻

# 2. Setting Up Your GitHub Repository
	1.	**Create a Repository Folder:**
Create a folder on your Mac (e.g., BearVault).
	2.	**Initialize the Git Repository:**
Open Terminal, navigate to your new folder, and run:

cd /path/to/BearVault
git init

If you have a remote repository, add it:

git remote add origin <your-repo-url>


	3.	**Folder Structure Overview:**
Your repository should eventually look like this:

BearVault/
├── export.sh           # Exports Bear notes into a temporary folder
├── organize.sh         # Organizes exported files into tag-based subfolders
├── run_all.sh          # Runs export.sh and organize.sh sequentially
├── README.md           # Documentation
├── temp_export/        # Temporary folder (created by export.sh)
├── untagged/           # For notes with no tags (created dynamically)
├── <tag-folder>/       # Dynamically created for each tag
└── ...                 # Other files/folders



⸻

# 3. Bear Tagging Best Practices
	* 	**Consistency is Key:**
Use a consistent format for your tags. For nested tags, use a delimiter (like /) and for multiword tags, wrap them with a closing # (e.g., #this is many words#).
	* 	**Clarity in Tag Names:**
Make sure your tag names clearly represent the content category (e.g., #ai/prompts/MVP for minimal viable product prompts).
	* 	**Bear Export Settings:**
When exporting notes via Bear CLI, confirm that the output format is Markdown so that your shell scripts can process the files.

⸻

# 4. Creating the Shell Scripts

### A. export.sh

This script uses the Bear CLI to export your notes into a temporary folder.

#!/bin/bash
# export.sh

# === CONFIGURATION ===
REPO_PATH="$HOME/Git/BearVault"            # Change to your repository location
TEMP_EXPORT="${REPO_PATH}/temp_export"
BEAR_CLI="/usr/local/bin/bear"              # Adjust if Bear CLI is installed elsewhere

# Create the temporary export folder if it doesn't exist
mkdir -p "$TEMP_EXPORT"

echo "Exporting notes from Bear to $TEMP_EXPORT..."

# Export all notes as Markdown (adjust command as needed)
"$BEAR_CLI" export --output "$TEMP_EXPORT" --format markdown

echo "Export completed."

*Make it executable:*

chmod +x export.sh



⸻

### B. organize.sh

This script scans the exported Markdown files, extracts tags, and moves files into subfolders in the repository root. It supports nested and multiword tags.

#!/bin/bash
# organize.sh

# === CONFIGURATION ===
REPO_PATH="$HOME/Git/BearVault"         # Change this to your repository location
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

*Make it executable:*

chmod +x organize.sh



⸻

### C. run_all.sh

This script runs export.sh first and, upon its successful completion, runs organize.sh. It provides you with one command to execute the entire workflow.

#!/bin/bash
# run_all.sh

echo "Starting Bear export..."
./export.sh

# Check if export.sh executed successfully
if [ $? -eq 0 ]; then
  echo "Export completed successfully. Now organizing files..."
  ./organize.sh
else
  echo "Export failed. Aborting organization step."
  exit 1
fi

echo "All steps completed."

*Make it executable:*

chmod +x run_all.sh



⸻

# 5. Setting Up Hazel for Auto-Commit

Hazel will watch your repository (or specific subfolders) and automatically commit any changes. Here’s how to set it up:
	1.	**Add Your Repository Folder to Hazel:**
Open Hazel and add your repository folder (e.g., /path/to/BearVault).
	2.	**Create a New Rule in Hazel:**
	* 	**Rule Name:** Auto Git Commit
	* 	**Conditions:**
	* 	If “Date Last Modified is after Date Last Matched” (this can be applied recursively so that any change in subfolders triggers the rule).
	* 	**Actions:**
	* 	**Run Shell Script:**
Use the following embedded script:

Bash
cd "$HOME/Git/BearVault"
commit_msg=$(osascript -e 'Tell application "System Events" to display dialog "Commit message for Bear exports:" default answer ""' -e 'text returned of result')
if [ -n "$commit_msg" ]; then
  git add .
  git commit -m "$commit_msg"
fi


	* 	**Notes:**
	* 	Adjust the path ($HOME/Git/BearVault) if your repository is located elsewhere.
	* 	This rule prompts you with a dialog for a commit message whenever a file change is detected.

⸻

# 6. Execution and Automation of the Shell Scripts

### Manual Execution:
	* 	**Run the Workflow Manually:**
Open Terminal, navigate to your repository, and execute:

./run_all.sh

This will export the notes and then organize them based on the tags found.

### Ideas for Further Automation:
	* 	**Automate with Cron:**
Set up a cron job to run run_all.sh at regular intervals (e.g., daily or hourly).
For example, edit your crontab with:

crontab -e

Then add a line like:

0 * * * * /path/to/BearVault/run_all.sh

(This runs the script every hour.)

	* 	**Keyboard Maestro or macOS Shortcuts:**
Use these tools to create an automation workflow that triggers run_all.sh based on certain conditions (such as a file change or on a schedule).
	* 	**Integration with Hazel:**
Although Hazel is already monitoring for changes to auto-commit, you can also set it to trigger the export/organize process if you have another folder where Bear updates its export files.
	* 	**Using Cursor AI:**
Since you already use Cursor AI, you can integrate this workflow within your development environment—using its terminal, scheduling tasks, or even creating a custom command palette entry to run run_all.sh.

⸻

# 7. Final Considerations
	* 	**Tag Consistency:**
Ensure that your Bear notes are tagged consistently. The scripts rely on clear, predictable tag formats to create folders correctly.
	* 	**Review Hazel Logs:**
If the auto-commit isn’t working as expected, check Hazel’s logs (usually found in ~/Library/Logs/Hazel) for debugging.
	* 	**Git Best Practices:**
Regularly review your commits to ensure that only the desired changes are being committed. You might also consider adding a .gitignore file if there are files or folders you do not want to track.
	* 	**Security & Backup:**
Make sure your Git repository is backed up (especially if it’s private or contains sensitive notes) by using a remote repository on GitHub or another Git hosting service.

⸻

By following these steps, you can build a robust automation system that ties together Bear’s note-taking, dynamic file organization based on tags, and automated Git commits via Hazel. This system not only helps maintain a clean repository but also offers multiple avenues for further automation and refinement.

Let me know if you need further tweaks or additional details on any part of the process!