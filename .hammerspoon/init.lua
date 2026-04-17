PaperWM = hs.loadSpoon("PaperWM")
PaperWM.infinite_loop_window = true

-- Enable matching based on Spotlight title
hs.application.enableSpotlightForNameSearches(true)

-- Ignore some apps
PaperWM.window_filter:rejectApp("8x8 Work")
PaperWM.window_filter:rejectApp("Activity Monitor")
PaperWM.window_filter:rejectApp("Bitwarden")
PaperWM.window_filter:rejectApp("Calendar")
PaperWM.window_filter:rejectApp("ChatGPT")
PaperWM.window_filter:rejectApp("FaceTime")
PaperWM.window_filter:rejectApp("Finder")
PaperWM.window_filter:rejectApp("Messages")
PaperWM.window_filter:rejectApp("Spotify")
PaperWM.window_filter:rejectApp("System Settings")
PaperWM.window_filter:rejectApp("TextEdit")
PaperWM.window_filter:rejectApp("WhatsApp")
PaperWM.window_filter:rejectApp("\u{200E}WhatsApp") -- WhatsApp reports its name with a leading LTR mark
PaperWM.window_filter:rejectApp("Element")
PaperWM.window_filter:rejectApp("Claude")
PaperWM.window_filter:setAppFilter("Firefox", { rejectTitles = "Picture%-in%-Picture" })
PaperWM.window_filter:setAppFilter("Ghostty", { rejectTitles = "^$" })
PaperWM.window_filter:rejectApp("GlobalProtect")
PaperWM.window_filter:setAppFilter("Thunderbird", { rejectTitles = { "^Select Calendar", "^Sending", "^Write:" } })

-- Key bindings
PaperWM:bindHotkeys({
    -- switch to a new focused window in tiled grid
    focus_left  = {{"alt", "cmd"}, "left"},
    focus_right = {{"alt", "cmd"}, "right"},
    --focus_up    = {{"alt", "cmd"}, "up"},
    --focus_down  = {{"alt", "cmd"}, "down"},

    -- switch windows by cycling forward/backward
    -- (forward = down or right, backward = up or left)
    focus_prev = {{"alt", "cmd"}, "k"},
    focus_next = {{"alt", "cmd"}, "j"},

    -- move windows around in tiled grid
    swap_left  = {{"alt", "cmd", "shift"}, "left"},
    swap_right = {{"alt", "cmd", "shift"}, "right"},
    swap_up    = {{"alt", "cmd", "shift"}, "up"},
    swap_down  = {{"alt", "cmd", "shift"}, "down"},

    -- position and resize focused window
    center_window        = {{"alt", "cmd"}, "c"},
    full_width           = {{"alt", "cmd"}, "f"},
    cycle_width          = {{"alt", "cmd"}, "r"},
    reverse_cycle_width  = {{"ctrl", "alt", "cmd"}, "r"},
    cycle_height         = {{"alt", "cmd", "shift"}, "r"},
    reverse_cycle_height = {{"ctrl", "alt", "cmd", "shift"}, "r"},

    -- increase/decrease width
    increase_width = {{"alt", "cmd"}, "l"},
    decrease_width = {{"alt", "cmd"}, "h"},

    -- move focused window into / out of a column
    --slurp_in = {{"alt", "cmd", "shift"}, "i"},
    --barf_out = {{"alt", "cmd", "shift"}, "o"},

    -- move the focused window into / out of the tiling layer
    toggle_floating = {{"alt", "cmd", "shift"}, "escape"},

    -- focus the first / second / etc window in the current space
    --focus_window_1 = {{"cmd", "shift"}, "1"},
    --focus_window_2 = {{"cmd", "shift"}, "2"},
    --focus_window_3 = {{"cmd", "shift"}, "3"},
    --focus_window_4 = {{"cmd", "shift"}, "4"},
    --focus_window_5 = {{"cmd", "shift"}, "5"},
    --focus_window_6 = {{"cmd", "shift"}, "6"},
    --focus_window_7 = {{"cmd", "shift"}, "7"},
    --focus_window_8 = {{"cmd", "shift"}, "8"},
    --focus_window_9 = {{"cmd", "shift"}, "9"},

    -- switch to a new Mission Control space
    switch_space_l = {{"alt", "cmd"}, ","},
    switch_space_r = {{"alt", "cmd"}, "."},
    --switch_space_1 = {{"alt", "cmd"}, "1"},
    --switch_space_2 = {{"alt", "cmd"}, "2"},
    --switch_space_3 = {{"alt", "cmd"}, "3"},
    --switch_space_4 = {{"alt", "cmd"}, "4"},
    --switch_space_5 = {{"alt", "cmd"}, "5"},
    --switch_space_6 = {{"alt", "cmd"}, "6"},
    --switch_space_7 = {{"alt", "cmd"}, "7"},
    --switch_space_8 = {{"alt", "cmd"}, "8"},
    --switch_space_9 = {{"alt", "cmd"}, "9"},

    -- move focused window to a new space and tile
    --move_window_1 = {{"alt", "cmd", "shift"}, "1"},
    --move_window_2 = {{"alt", "cmd", "shift"}, "2"},
    --move_window_3 = {{"alt", "cmd", "shift"}, "3"},
    --move_window_4 = {{"alt", "cmd", "shift"}, "4"},
    --move_window_5 = {{"alt", "cmd", "shift"}, "5"},
    --move_window_6 = {{"alt", "cmd", "shift"}, "6"},
    --move_window_7 = {{"alt", "cmd", "shift"}, "7"},
    --move_window_8 = {{"alt", "cmd", "shift"}, "8"},
    --move_window_9 = {{"alt", "cmd", "shift"}, "9"}
})

PaperWM:start()
