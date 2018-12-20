set defaultSize to {1024, 680}

tell application "Finder"
    activate
    if (count windows) is 0 then
        open home
        tell application "System Events"
            tell process "Finder"
                set size of every window whose subrole is "AXStandardWindow" to {1240, 680}
            end tell
        end tell
    else if (count windows) is 1 then
        set the current view of the front Finder window to column view
        tell application "System Events"
            tell process "Finder"
                set size of every window whose subrole is "AXStandardWindow" to {1240, 680}
            end tell
        end tell
    else
        set the current view of every Finder window to column view
        tell application "System Events"
            tell process "Finder"
                set size of every window whose subrole is "AXStandardWindow" to {1240, 680}
            end tell
        end tell
        tell application "System Events" to key code 125 using {control down}
    end if
end tell