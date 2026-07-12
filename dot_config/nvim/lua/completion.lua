--- Copilot
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

--- Completion settings
local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "copilot" },

    providers = {
      copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = 100,
        async = true,
      },
    },
  },
})
