vim.api.nvim_buf_create_user_command(0, "TypstOpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  local pdf_path = filepath:gsub("%.typ$", ".pdf")

  vim.system({ "xdg-open", pdf_path })
end, {})

vim.lsp.config["tinymist"].on_attach = function(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, "TinymistPin", function()
    client:exec_cmd({
      title = "pin",
      command = "tinymist.pinMain",
      arguments = { vim.api.nvim_buf_get_name(bufnr) },
    }, { bufnr = bufnr })
  end, {})

  vim.api.nvim_buf_create_user_command(bufnr, "TinymistUnpin", function()
    client:exec_cmd({
      title = "unpin",
      command = "tinymist.pinMain",
      arguments = { vim.v.null },
    }, { bufnr = bufnr })
  end, {})
end
