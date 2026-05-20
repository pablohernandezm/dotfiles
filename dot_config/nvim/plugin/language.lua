--- Completion settings
vim.o.completeopt = "fuzzy,menuone,noinsert"
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/completion') and vim.lsp.completion then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

--- Load and install lsps
local lsp = require("mise-lsp")
local format = require("mise-format")


-- Lua
lsp:config({
  name = "lua",
  enable = true,
  filetypes = { "lua" },
  cmd = { "lua-language-server" },
  mise = {
    provider = "aqua:LuaLS/lua-language-server",
    global = true,
  },
  root_markers = { ".luarc.json", ".luarc.jsonc" }
})

format:config({
  filetypes = { "lua" },
})

-- Rust
lsp:config({
  name = "rust-analyzer",
  enable = true,
  filetypes = { "rust" },
  cmd = { "rust-analyzer" },
  mise = {
    provider = "aqua:rust-lang/rust-analyzer",
    global = false
  },
  root_markers = { "Cargo.toml", "Cargo.lock" }
})

format:config({
  filetypes = { "rust" },
  cmd = { "rustfmt" }
})

-- Typescript
lsp:config({
  name = "TypeScript",
  enable = true,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  cmd = { "vtsls", "--stdio" },
  mise = {
    provider = "npm:@vtsls/language-server",
    global = false,
  },
  root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' },
})
