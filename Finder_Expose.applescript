tell application "Finder"
    activate
    if (count windows) is 0 then
        open home
    else if (count windows) is 1 then
        set the current view of the front Finder window to column view
    else
        --delay 0.01
        tell application "System Events" to key code 125 using {control down}
    end if
end tell