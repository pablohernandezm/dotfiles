-- Completion settings
vim.o.completeopt = "fuzzy,menuone,noselect"
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/completion') and vim.lsp.completion then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})


-- Load and install lsps
local lsp = require("mise-lsp")

lsp:setup({
  lua = {
    cmd = "lua-language-server",
    filetypes = { "lua" },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
    mise_options = {
      provider = "aqua:LuaLS/lua-language-server",
      global = true,
    },
    format = {
      on_save = true }
  },

  rust = {
    cmd = "rust-analyzer",
    filetypes = { "rust" },
    root_markers = { 'Cargo.toml', '.git' },
    mise_options = {
      provider = "aqua:rust-lang/rust-analyzer",
    },
    format = {
      on_save = true,
      cmd = { "rustfmt" }
    }
  }
})
