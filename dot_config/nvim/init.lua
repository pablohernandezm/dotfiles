vim.diagnostic.config({
  virtual_text = true,
})

vim.g.mapleader = " "
vim.o.wrap = false
vim.o.cindent = true
vim.o.shiftwidth = 2
vim.o.softtabstop = -1
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.confirm = true
vim.o.colorcolumn = "100"

--- modules
require("colorscheme")
require("custom")
require("file-explorer")
require("language")
require("search")
require("terminal")
require("writing")
