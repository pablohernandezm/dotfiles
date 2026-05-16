local close_on_leave_group = vim.api.nvim_create_augroup("netrw.toggle", { clear = true })
local win = vim.api.nvim_get_current_win()

vim.api.nvim_create_autocmd('WinLeave', {
  group = close_on_leave_group,
  callback = function()
    vim.schedule(function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
        vim.api.nvim_del_augroup_by_id(close_on_leave_group)
      end
    end)
  end
})
