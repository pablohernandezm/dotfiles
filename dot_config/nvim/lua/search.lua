vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

require("fzf-lua").setup({
  winopts = {
    width = 0.4,
  },
})

vim.keymap.set("n", "<leader>F", function()
  vim.cmd("FzfLua")
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>f", function()
  require("fzf-lua").files({
    previewer = false,
  })
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>l", function()
  require("fzf-lua").live_grep_native()
end, { desc = "Live grep" })
