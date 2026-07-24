-- Applications
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("hyprshutdown"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("ghostty"))
hl.bind("SUPER + Z", hl.dsp.exec_cmd("zen-browser"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -dispay-columns 2 | cliphist decode | wl-copy"))
hl.bind(
  "Print",
  hl.dsp.exec_cmd('grim - | satty -f - --copy-command wl-copy -o "~/Pictures/Screenshots/%Y%m%d_%H%M%S.png"')
)

-- Mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

-- Window actions
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + S", hl.dsp.window.move({ workspace = "special", follow = false }))
hl.bind("SUPER + SHIFT + S", hl.dsp.workspace.toggle_special("special"))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Focus movement
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + TAB", hl.dsp.window.cycle_next())

-- Multimedia
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("SUPER+M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

-- Workspace switching
for i = 1, 10 do
  hl.bind("SUPER + " .. i % 10, hl.dsp.focus({ workspace = i }))
  hl.bind("SUPER + SHIFT + " .. i % 10, hl.dsp.window.move({ workspace = i }))
end

-- Window movement
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))

-- Resize submap
hl.bind("ALT + R", hl.dsp.submap("resize_window"))
hl.define_submap("resize_window", function()
  local function resize(map, x, y)
    hl.bind(map, hl.dsp.window.resize({ x = x, y = y, relative = true }), { repeating = true })
  end

  resize("L", 10, 0)
  resize("H", -10, 0)
  resize("K", 0, 10)
  resize("J", 0, -10)

  hl.bind("escape", hl.dsp.submap("reset"))
end)
