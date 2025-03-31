tell application "Bear"
    -- Specify the folder where you want to export your notes
    set exportFolder to POSIX file "/Users/chuck/BearVault/temp_export" as alias
    
    -- Export all notes as Markdown
    -- Using Bear's native export functionality
    export (every note) to exportFolder as "markdown" with properties {include tags:true, include attachments:true}
end tell 