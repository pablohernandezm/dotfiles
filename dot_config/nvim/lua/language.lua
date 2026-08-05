--- Nix neovim-tools profile
local neovim_bin = vim.env.HOME .. "/.config/nix/neovim-tools/bin"
if vim.fn.isdirectory(neovim_bin) == 1 then
  vim.env.PATH = neovim_bin .. ":" .. vim.env.PATH
end

--- spellcheck
vim.o.spell = false
vim.o.spelllang = "en,es"
vim.o.spelloptions = "camel"

vim.keymap.set({ "n", "t" }, "<A-s>", function()
  vim.o.spell = not vim.o.spell
end, { desc = "Toggle spellcheck" })

--- Load LSPs (installed via mise, check mise.toml)
vim.lsp.enable("lua_ls")
vim.lsp.enable("vtsls")
vim.lsp.enable("svelte")
vim.lsp.enable("html")
vim.lsp.enable("jsonls")
vim.lsp.enable("emmet_language_server")
vim.lsp.enable("cssls")
vim.lsp.enable("eslint")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("tinymist")
vim.lsp.enable("nixd")

---> lsp settings
--- css
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = "*.css",
  callback = function(args)
    local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1] or ""

    -- disable diagnostics for files that start with gtk-css comment
    if first_line:match("gtk%-css") then
      vim.diagnostic.enable(false, { bufnr = args.buf })
    end
  end,
})
--- Format settings
--- @type conform.setupOpts
local formatters_by_ft = {
  lua = { "stylua" },
  rust = { "rustfmt" },
  typst = { "typstyle" },
}

-- oxfmt: supported file types
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
  formatters_by_ft[ft] = { "oxfmt" }
end

require("conform").setup({
  formatters_by_ft = formatters_by_ft,
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },
  formatters = {
    stylua = {
      append_args = {
        "--indent-width",
        "2",
        "--indent-type",
        "Spaces",
        "--syntax",
        "LuaJIT",
      },
    },
  },
})

--- Tree-sitter
require("tree-sitter-manager").setup()
