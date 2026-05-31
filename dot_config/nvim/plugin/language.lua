--- Mise
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

--- Plugins
vim.pack.add {
  -- Lsp config
  'https://github.com/neovim/nvim-lspconfig',

  -- Rust
  'https://github.com/mrcjkb/rustaceanvim'
}

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

--- Load lsps (installed via mise, check mise.toml)
vim.lsp.enable('lua_ls')
vim.lsp.enable('vtsls')

--- Format
local format = require("mise-format")

format:config({
  filetypes = { "lua" }
})
