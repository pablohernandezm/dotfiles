--- Mise
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

--- Plugins
vim.pack.add {
  -- Lsp config
  'https://github.com/neovim/nvim-lspconfig',

  -- Formatter
  'https://github.com/stevearc/conform.nvim',

  -- Rust
  'https://github.com/mrcjkb/rustaceanvim',

  -- Tree-sitter
  'https://github.com/nvim-treesitter/nvim-treesitter'
}

--- Completion settings
vim.o.completeopt = "menuone,noselect,fuzzy,nosort"
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
vim.lsp.enable('svelte')
vim.lsp.enable('html')
vim.lsp.enable('jsonls')
vim.lsp.enable('cssls')
vim.lsp.enable('eslint')

--- Format settings
--- @type conform.setupOpts
local conform_options = {
  lua = { "stylua" },
  rust = { "rustfmt" },

  format_on_save = {
    lsp_format = "fallback"
  }
}

-- oxfmt: supported filetypes
local oxfmt_supported = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescript_react",
  "css",
  "html",
  "json",
  "yml",
  "markdown",
  "graphql",
  "toml",
  "svelte",
}

for _, ft in ipairs(oxfmt_supported) do
  conform_options[ft] = { "oxfmt" }
end

require('conform').setup(conform_options)


--- Tree-sitter
local ts_list = {
  "css",
  "scss",
  "javascript",
  "typescript",
  "tsx",
  "jsx",
  "svelte",
  "json",
  "html"
}
require('nvim-treesitter').install(ts_list)

vim.api.nvim_create_autocmd("FileType", {
  pattern = ts_list,
  callback = function()
    vim.treesitter.start()
  end
})
