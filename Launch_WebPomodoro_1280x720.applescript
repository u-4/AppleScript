tell application "WebPomodoro"
    activate
    tell application "System Events"
        tell process "WebPomodoro"
            set topWindow to item 1 of (every window whose subrole is "AXStandardWindow")
            set size of topWindow to {1280, 720}
        end tell
    end tell
end tell