vim.diagnostic.config({
  virtual_text = true,
})

vim.g.mapleader = " "
vim.g.maplocalleader = ";"
vim.o.wrap = false
vim.o.cindent = true
vim.o.shiftwidth = 2
vim.o.softtabstop = -1
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.confirm = true
vim.o.textwidth = 80
vim.o.colorcolumn = "+0"

--- Plugins
vim.pack.add({
  --- Colorscheme
  "https://github.com/rebelot/kanagawa.nvim",

  --- File explorer
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/barrettruth/canola.nvim",

  --- Search
  "https://github.com/ibhagwan/fzf-lua",

  --- Terminal
  "https://github.com/akinsho/toggleterm.nvim",

  --- Completion
  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/giuxtaposition/blink-cmp-copilot",
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",

  --- Language
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mrcjkb/rustaceanvim",
  "https://github.com/romus204/tree-sitter-manager.nvim",

  --- Writing
  "https://github.com/preservim/vim-pencil",

  --- Filetype
  "https://github.com/kevalin/mermaid.nvim",

  --- Custom
  { src = "https://github.com/pablohernandezm/nvimpack-selector", version = "main" },
})

--- modules
require("colorscheme")
require("language")
require("file-explorer")
require("search")
require("terminal")
require("completion")
require("custom")
