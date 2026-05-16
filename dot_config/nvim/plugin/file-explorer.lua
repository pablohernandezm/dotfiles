vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/barrettruth/canola.nvim"
})

local oil = require("oil")
oil.setup({})

vim.keymap.set("n", "<leader>e", function()
  oil.toggle_split(
    nil,
    {
      vertical = true,
    },
    function()
      vim.api.nvim_win_set_width(0, 20)
      vim.wo.number = false
      vim.wo.relativenumber = false
    end)
end)
