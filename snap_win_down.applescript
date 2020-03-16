set {width, height, scale} to words of (do shell script "system_profiler SPDisplaysDataType | awk '/Built-In: Yes/{found=1} /Resolution/{width=$2; height=$4} /Retina/{scale=($2 == \"Yes\" ? 2 : 1)} /^ {8}[^ ]+/{if(found) {exit}; scale=1} END{printf \"%d %d %d\\n\", width, height, scale}'")

local x0
local y0
local x1
local y1

set x0 to width / 4 as number
set y0 to height / 4 as number
set x1 to x0 + width / 2 as number
set y1 to y0 + height / 2 as number

local new_window_rect
set new_window_rect to {x0, y0, x1, y1}

local activeApp
tell application "System Events"
	set activeApp to name of first application process whose frontmost is true
end tell

tell application activeApp
	set bounds of front window to new_window_rect
end tell
