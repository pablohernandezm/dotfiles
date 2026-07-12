vim.keymap.set("n", "<leader>p", function()
  vim.cmd("NvimPackSelector open")
end, { desc = "Pack menu" })
