--- Completion settings
vim.o.completeopt = "fuzzy,menuone,noinsert"
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/completion') and vim.lsp.completion then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end
})

--- Load and install lsps
local format = require("mise-format")

-- Lua
format:config({
  filetypes = { "lua" }
})

-- Rust
format:config({
  filetypes = { "rust" },
  cmd = { "rustfmt" }
})
