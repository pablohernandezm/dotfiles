vim.diagnostic.config({
  virtual_text = true
})

vim.o.cindent = true
vim.o.shiftwidth = 2
vim.o.softtabstop = -1
vim.o.expandtab = true
vim.o.relativenumber = true
vim.o.autocomplete = true
vim.o.complete = "."
vim.o.confirm = true
vim.g.mapleader = " "


vim.keymap.set("n", "<leader>e", function()
  vim.cmd("20Lex")
end)

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
  local path = vim.fn.expand("%:p:h")
  local chezmoi_dir = vim.fn.expand("~/.local/share/chezmoi")
  local msg = ""

  if path:match("^(" .. chezmoi_dir .. ").*$") and vim.fn.executable("chezmoi") == 1 then
    msg = msg .. "[chezmoi detected] "
                                                vim.cmd("silent !chezmoi apply")
  end

  require("utils.qol"):unload_modules(vim.fn.stdpath("config") .. "/lua")

  msg = msg .. "reloading..."
                                                                 vim.notify(msg)
  vim.cmd("source $MYVIMRC")
                                                                            end)
