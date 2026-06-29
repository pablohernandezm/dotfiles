--- Copilot
vim.pack.add({
  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/giuxtaposition/blink-cmp-copilot",
})

require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

--- Completion settings
vim.pack.add({
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
})

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
