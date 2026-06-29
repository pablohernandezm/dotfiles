--- Copilot
vim.pack.add({
  "https://github.com/github/copilot.vim",
  "https://github.com/fang2hou/blink-copilot",
})

vim.g.copilot_no_maps = true

-- Block the normal Copilot suggestions
vim.api.nvim_create_augroup("github_copilot", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
  group = "github_copilot",
  callback = function(args)
    vim.fn["copilot#On" .. args.event]()
  end,
})
vim.fn["copilot#OnFileType"]()

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
