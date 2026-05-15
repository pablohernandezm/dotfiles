local M = {
  ---@type vim.api.keyset.win_config
  defaults = {
    width = 70,
    height = 10,
    relative = "editor",
    style = "minimal",
    border = "rounded",
  }

}

---@param options vim.api.keyset.win_config | nil
---@private
function M:float_win(options)
  local opts = M.defaults

  if options then
    for k, v in pairs(options) do
      opts[k] = v
    end
  end

  opts.col = math.floor((vim.o.columns - opts.width) / 2)
  opts.row = math.floor((vim.o.lines - opts.height) / 2)

  local buf = vim.api.nvim_create_buf(false, false)
  local win = vim.api.nvim_open_win(buf, true, opts)

  return { buf = buf, win = win }
end

return M
