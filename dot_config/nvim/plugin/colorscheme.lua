vim.pack.add({
  "https://github.com/rebelot/kanagawa.nvim"
})

require("kanagawa").setup({ theme = "wave" })
vim.cmd("colorscheme kanagawa")
