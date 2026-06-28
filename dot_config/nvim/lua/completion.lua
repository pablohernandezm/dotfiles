--- Copilot
vim.pack.add({
  "https://github.com/github/copilot.vim",
  "https://github.com/fang2hou/blink-copilot",
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
        module = "blink-copilot",
        score_offset = 100,
        async = true,
      },
    },
  },
})
