-- http://battleformac.blog.jp/archives/52367319.html
tell application "System Events"
    set topProcess to item 1 of (every process whose frontmost is true)
    tell topProcess
        set topDocWindow to item 1 of (every window whose subrole is "AXStandardWindow")
        set bestSize to size of topDocWindow
    end tell
end tell
display dialog (" Window Size is " & (item 1 of bestSize) as text) & " x " & (item 2 of bestSize) as text