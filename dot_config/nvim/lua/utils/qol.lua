local M = {}

---@param dir string
---@param prefix string | nil
function M:unload_modules(dir, prefix)
  for name in vim.fs.dir(dir) do
    local full_path = dir .. "/" .. name
    local stat = vim.uv.fs_stat(full_path)

    if stat and stat.type == "file" and name:match("%.lua$") then
      local mod_name = (prefix and prefix .. "." or "") .. name:gsub("%.lua$", "")
      package.loaded[mod_name] = nil
    elseif stat and stat.type == "directory" then
      local sub_prefix = (prefix and prefix .. "." or "") .. name
      M:unload_modules(full_path, sub_prefix)
    end
  end
end

---Reload lua configuration
---@param restart boolean | nil
function M:source_nvim_configuration(restart)
  local path = vim.fn.expand("%:p:h")
  local chezmoi_dir = vim.fn.expand("~/.local/share/chezmoi")

  if path:match("^(" .. chezmoi_dir .. ").*$") and vim.fn.executable("chezmoi") == 1 then
    vim.cmd("silent !chezmoi apply")
  end

  if restart then
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd("restart edit +call\\ cursor(" .. table.concat(cursor, ",") .. ") " .. vim.fn.expand("%") .. " | normal! zz")
  else
    self:unload_modules(vim.fn.stdpath("config") .. "/lua")
    vim.cmd("source $MYVIMRC")
  end
end

return M
