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
  local group = vim.api.nvim_create_augroup("netrw_toggle", {})
  if vim.b.netrw_open ~= nil then
    vim.cmd.bdelete()
    vim.api.nvim_del_augroup_by_id(group)
  else
    local f = vim.fn.expand("%:t")
    vim.cmd.Ex()
    vim.fn.search("^" .. f .. '$')
    vim.b.netrw_open = true

    vim.api.nvim_create_autocmd('FileType', {
      pattern = "netrw",
      group = group,
      callback = function()
        vim.b.netrw_open = true
      end
    })
  end
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
