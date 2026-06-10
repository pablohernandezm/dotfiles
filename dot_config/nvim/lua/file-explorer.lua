vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/barrettruth/canola.nvim",
})

local oil = require("oil")
oil.setup({})

vim.keymap.set("n", "<leader>e", function()
  oil.toggle_split(nil, {
    vertical = true,
  }, function()
    vim.api.nvim_win_set_width(0, 20)
    vim.wo.number = false
    vim.wo.relativenumber = false
  end)
end, { desc = "Open file explorer" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function(ev)
    vim.keymap.set("n", "<S-l>", "<CR>", { buf = ev.buf, remap = true, desc = "Open entry" })
    vim.keymap.set("n", "<S-h>", "-", { buf = ev.buf, remap = true, desc = "Parent path" })
  end,
})
