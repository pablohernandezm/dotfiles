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

--- autocmds
local completion = vim.api.nvim_create_augroup("completion", { clear = true })

-- disable copilot on startup
vim.api.nvim_create_autocmd("VimEnter", {
  group = completion,
  callback = function()
    vim.cmd("Copilot disable")
  end,
})
