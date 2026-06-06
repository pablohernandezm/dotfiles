vim.pack.add({ "https://github.com/preservim/vim-pencil" })

local pencil_g = vim.api.nvim_create_augroup("pencil", { clear = true })

local pencil_buffers = {}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typst" },
  group = pencil_g,
  callback = function(args)
    if not vim.list_contains(pencil_buffers, args.buf) then
      vim.cmd("Pencil")
      table.insert(pencil_buffers, args.buf)
    end
  end
})
