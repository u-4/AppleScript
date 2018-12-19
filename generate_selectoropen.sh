#!/bin/bash
set -eu
URL=URL_LIST
cat <<EOURLL | grep -v '^#' | while IFS=, read TITLE KEYWORD TARGET_URL
Paperpile,paperpile,https://paperpile.com/app
Gmail,gmail,https://mail.google.com/mail/u/0/
Google Drive,gdrive,https://drive.google.com/drive/
Google Photo,photo,https://photos.google.com/
Google Calendar,calendar,https://calendar.google.com/calendar/r
Google Document,gdocs,https://docs.google.com/document/u/0/
Google Spreadsheet,gsheet,https://docs.google.com/spreadsheets/u/0/
Google Slide,gslide,https://docs.google.com/presentation/u/0/
Google Keep,keep,https://keep.google.com/u/0/
Play Music,music,https://play.google.com/music/
Youtube,youtube,https://www.youtube.com/
# Youtube Music,---,https://music.youtube.com/
Coursera,coursera,https://www.coursera.org/
DataCamp,datacamp,https://www.datacamp.com/
GitHub,github,https://github.com/u-4
EOURLL
do
    cat <<EOT | sed -e "s|TARGET_TITLE|${TITLE}|g" | sed -e "s|TARGET_URL|${TARGET_URL}|g" > SelectOrOpen_${KEYWORD}.applescript
-- Select Tab or Open New Tab for TARGET_TITLE in Google Chrome
set addr to "TARGET_URL"
tell application "Google Chrome"
    activate
    set n to 1
    set found to 0
    repeat with w in windows
        set i to 1
        repeat with t in (tabs of w)
            if (URL of t as string) contains addr then
                set (active tab index of window n) to i
                set (index of window n) to 1
                set found to 1
                exit repeat
            end if
            set i to i + 1
        end repeat
        set n to n + 1
    end repeat
    if found = 0 then
        open location addr
    end if
end tell
EOT
done