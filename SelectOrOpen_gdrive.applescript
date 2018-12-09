-- Select Tab or Open New Tab for Google Drive in Google Chrome
set addr to "https://drive.google.com/drive/"
tell application Google Chrome
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
