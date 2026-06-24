vim.pack.add({ "https://github.com/kevalin/mermaid.nvim" })

vim.api.nvim_create_autocmd("BufWritePost", {
  buffer = 0,
  command = "silent! MermaidFormat",
})
