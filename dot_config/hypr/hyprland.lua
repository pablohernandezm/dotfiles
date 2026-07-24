--- Look and feel
-- General
hl.config({
  general = {
    border_size = 0,
    gaps_out = { bottom = 15, top = 5, left = 5, right = 5 },
    gaps_in = 5,
    layout = "scrolling",
  },
  decoration = {
    rounding = 16,
    dim_inactive = true,
    dim_strength = 0.2,
  },
  input = {
    kb_layout = "us",
    kb_variant = "altgr-intl",
  },

  scrolling = {
    column_width = 1.0,
  },
})

-- Smart gaps
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })

-- animations
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "default", style = "slidevert" })

--- Modules
-- Executes applications
require("autoloading")

-- Bindings
require("keybinds")
