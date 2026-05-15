local M = {}
---@class mise.mise_options
---@field provider string
---@field command string
---@field global boolean

---@param opts mise.mise_options
---@return string[]
---@private
function M:get_mise_cmd(opts)
  local already_available = vim.fn.executable(opts.command) == 1
  if already_available then return { opts.command } end

  local mise_exist = vim.fn.executable("mise") == 1

  if not mise_exist then error("Mise not found") end


  if opts.global then
    vim.fn.system({ "mise", "use", "--global", opts.provider })
    return { "mise", "exec", "--", opts.command }
  else
    return { "mise", "exec", opts.provider, "--", opts.command }
  end
end

return M
