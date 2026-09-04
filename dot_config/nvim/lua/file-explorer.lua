local oil = require("oil")
local group = vim.api.nvim_create_augroup("file-explorer", { clear = true })

--- Setup
oil.setup({
  keymaps = {
    ["-"] = "actions.close",
  },
})

--- Keymaps
vim.keymap.set("n", "<leader>e", "-", { desc = "Open file explorer", remap = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  group = group,
  callback = function(ev)
    vim.keymap.set("n", "<S-l>", "<CR>", { buf = ev.buf, remap = true, desc = "Open entry" })
    vim.keymap.set("n", "<S-h>", ":Oil<CR>", { buf = ev.buf, remap = true, desc = "Parent path" })
  end,
})
