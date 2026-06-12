local bindMngr = require("utils.bindingUtils")

local apps = bindMngr
  .new({
    ["SUPER + F1"] = { "hyprshutdown" },
    ["SUPER + T"] = { "ghostty" },
    ["SUPER + R"] = { "rofi -show drun" },
    ["SUPER + Z"] = { "zen-browser" },
    ["SUPER + V"] = { "cliphist list | rofi -dmenu -dispay-columns 2 | cliphist decode | wl-copy" },
  })
  :bind()

local mouse = bindMngr
  .new({
    ["SUPER + mouse:272"] = { hl.dsp.window.drag() },
    ["SUPER + mouse:273"] = { hl.dsp.window.resize() },
  })
  :bind()

local actions = bindMngr
  .new({
    -- Window actions
    ["SUPER + Q"] = { hl.dsp.window.close() },
    ["SUPER + S"] = { hl.dsp.window.move({ workspace = "special", follow = false }) },
    ["SUPER + SHIFT + S"] = { hl.dsp.workspace.toggle_special("special") },

    -- Focus movement
    ["SUPER + H"] = { hl.dsp.focus({ direction = "left" }) },
    ["SUPER + L"] = { hl.dsp.focus({ direction = "right" }) },
    ["SUPER + J"] = { hl.dsp.focus({ direction = "down" }) },
    ["SUPER + K"] = { hl.dsp.focus({ direction = "up" }) },
  })
  :bind()

local multimedia = bindMngr
  .new({
    ["XF86AudioRaiseVolume"] = { "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" },
    ["XF86AudioLowerVolume"] = { "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-" },
    ["XF86AudioMute"] = { "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" },
    ["XF86AudioMicMute"] = { "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" },
    ["XF86AudioNext"] = { "playerctl next" },
    ["XF86AudioPrev"] = { "playerctl previous" },
    ["XF86AudioPlay"] = { "playerctl play-pause" },
  })
  :bind()

-- Workspace switching
for i = 1, 10 do
  hl.bind("SUPER + " .. i % 10, hl.dsp.focus({ workspace = i }))
  hl.bind("SUPER + SHIFT + " .. i % 10, hl.dsp.window.move({ workspace = i }))
end

-- Window movement
local vim_movement_keys = {
  ["L"] = "right",
  ["H"] = "left",
  ["J"] = "down",
  ["K"] = "up",
}

for k, dir in pairs(vim_movement_keys) do
  hl.bind("SUPER + SHIFT + " .. k, hl.dsp.window.move({ direction = dir }))
end

-- Resize window
hl.bind("ALT + R", hl.dsp.submap("resize_window"))
hl.define_submap("resize_window", function()
  local function resize(map, x, y)
    hl.bind(map, hl.dsp.window.resize({ x = x, y = y, relative = true }), { repeating = true })
  end

  resize("L", 10, 0)
  resize("H", -10, 0)
  resize("K", 0, 10)
  resize("K", 0, -10)

  hl.bind("escape", hl.dsp.submap("reset"))
end)
