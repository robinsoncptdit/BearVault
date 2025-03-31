# Moment
#stuff

Yes, exactly—in our current setup, the automation chain is triggered when a file appears or is updated in the designated export folder (in this case, temp_export). Here’s a quick breakdown:
	* 	**Export from Bear:**
Your note in Bear must be exported (either manually or via an automated AppleScript/CLI command) to the temp_export folder. This export creates a Markdown file that the rest of your scripts work with.
	* 	**Triggering the Workflow:**
Once the exported file is in temp_export, Hazel (or your combined script) picks it up. Hazel monitors that folder and, when it detects a new or updated file, it triggers the subsequent process (like organizing the file into the correct tag-based subfolder and then committing the changes to Git).
	* 	**Overall Flow:**
	1.	**Export:** The note   gets exported from Bear into temp_export.
	2.	**Organize:** The organization script processes the file from temp_export, moves it into the appropriate subfolder in your repo root based on its tags, and removes it from temp_export.
	3.	**Auto-Commit (via Hazel):** Hazel then detects changes in the repository (or specific folders) and runs the auto-commit script.

So, yes—if you want the automation to kick in,  your note needs to be exported into the temp_export folder. This export is the trigger for the rest of the process.

If you’re looking for a fully automated workflow, you can set up your Bear export (using AppleScript, the Bear CLI, or a macOS Shortcut) to export to that folder automatically whenever you finish a note. Then Hazel and your scripts take over to process and commit the changes without further manual intervention.