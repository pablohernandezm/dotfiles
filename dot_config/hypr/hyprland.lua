-- Look and feel
-- - General
hl.config({
  general = {
    border_size = 0,
    gaps_out = { bottom = 15, top = 5, left = 5, right = 5 },
    gaps_in = 5
  },
  decoration = {
    rounding = 10
  },
  input = {
    kb_layout = "us",
    kb_variant = "altgr-intl"
  }
})

-- - Smart gaps
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })


-- Modules
-- - Executes applications
require("autoloading")

-- - Bindings
require("keybinds")
