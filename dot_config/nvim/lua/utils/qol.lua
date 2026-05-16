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

function M:reload_nvim_configuration()
  local path = vim.fn.expand("%:p:h")
  local chezmoi_dir = vim.fn.expand("~/.local/share/chezmoi")
  local msg = ""

  if path:match("^(" .. chezmoi_dir .. ").*$") and vim.fn.executable("chezmoi") == 1 then
    msg = msg .. "[chezmoi detected] "
    vim.cmd("silent !chezmoi apply")
  end

  self:unload_modules(vim.fn.stdpath("config") .. "/lua")

  msg = msg .. "reloading..."
  vim.notify(msg)
  vim.cmd("source $MYVIMRC")
end

return M
