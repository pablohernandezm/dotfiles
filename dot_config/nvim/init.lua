vim.diagnostic.config({
  virtual_text = true
})

vim.o.cindent = true
vim.o.shiftwidth = 2
vim.o.softtabstop = -1
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.autocomplete = true
vim.o.complete = "."
vim.o.confirm = true
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>f', function()
  require("search"):search_file({
    mise = {
      global = false
    }
  })
end)

vim.keymap.set('n', '<leader>s', function()
  require("search"):rg({
    mise = {
      global = false
    }
  })
end)

vim.keymap.set('n', '<leader>r', function()
  require("utils.qol"):reload_nvim_configuration()
end)
