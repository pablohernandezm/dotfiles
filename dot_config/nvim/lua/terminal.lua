vim.pack.add({ "https://github.com/akinsho/toggleterm.nvim" })

require("toggleterm").setup()

vim.keymap.set({ "n", "t" }, "<C-/>", function()
  vim.cmd("ToggleTerm direction=horizontal")
end, { desc = "Toggle terminal" })
