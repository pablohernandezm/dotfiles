vim.pack.add({ { src = "https://github.com/pablohernandezm/nvimpack-selector", version = "main" } })

vim.keymap.set("n", "<leader>p", function()
  vim.cmd("NvimPackSelector open")
end, { desc = "Pack menu" })
