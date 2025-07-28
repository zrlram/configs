#!/bin/bash

# Get today's date in the format used by your daily notes
DATE_FORMAT="%Y-%m-%d" # Adjust if your notes use a different format
TODAY=$(date +"$DATE_FORMAT")

# Construct the full path to today's daily note
DAILY_NOTE_PATH="/Users/ram/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/Daily/Running Log.md"

# Define the email recipient and subject
RECIPIENT="raffy@raffy.ch"
SUBJECT="Daily Note for $TODAY"

send_via_mail_app() {
  BODY="obsidian://open?vault=Obsidian%20Vault&file=Daily%2fRunning%20Log\n\n"
  BODY="${BODY} $(sed 's/"/\\"/g' "$DAILY_NOTE_PATH")"
  /usr/bin/osascript <<EOF
tell application "Mail"
  set newMessage to make new outgoing message with properties {subject:"$SUBJECT", content:"$BODY", visible:false}
  tell newMessage
    make new to recipient at end of to recipients with properties {address:"$RECIPIENT"}
    send
  end tell
end tell
EOF
}

# Send the email using the mail command
# The content of the daily note file will be the email body
# cat "$DAILY_NOTE_PATH"
if [ -e "$DAILY_NOTE_PATH" ]; then
    send_via_mail_app
else
    echo "Daily note for $TODAY not found at $DAILY_NOTE_PATH" | send_via_mail_app
fi

