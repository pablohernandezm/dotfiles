local M = {}

function M:check_mise()
  local mise_exists = vim.fn.executable("mise") == 1
  return mise_exists
end

local function check_mise_with_error()
  if not M:check_mise() then
    error("Mise not found")
  end
end

---@class mise.mise_schema
---@field provider string


---@alias mise.mise_install_options mise.mise_schema | string
---@vararg mise.mise_install_options
function M:install_mise(...)
  check_mise_with_error()

  local mises = { ... }
  ---@type string[]
  local provider_list = {}

  for _, mise in ipairs(mises) do
    local provider = type(mise) == "string" and mise or mise.provider
    table.insert(provider_list, provider)
  end

  vim.fn.system({ "mise", "use", "--global", unpack(provider_list) })
end

---@class mise.callable_schema : mise.mise_schema
---@field cmd string[]
---@field global boolean default is false
---@field dependencies? mise.mise_install_options[]

---@param opts mise.callable_schema
---@return string[]
---@private
function M:get_callable_mise_cmd(opts)
  if #opts.cmd < 1 then error("A command is required") end

  local already_available = vim.fn.executable(opts.cmd[1]) == 1
  if already_available then return opts.cmd end

  check_mise_with_error()

  ---@type mise.mise_install_options[]
  local providers = { opts.provider }

  if opts.dependencies then
    for _, dep in ipairs(opts.dependencies) do
      table.insert(providers, dep)
    end
  end

  if opts.global then
    self:install_mise(unpack(providers))

    return { "mise", "exec", "--", unpack(opts.cmd) }
  else
    local exec_command = { "mise", "exec", unpack(providers) }
    table.insert(exec_command, "--")

    for i, cmd_part in ipairs(opts.cmd) do
      table.insert(exec_command, cmd_part)

      if i > 2 then
        error(vim.inspect(cmd_part))
      end
    end


    return exec_command
  end
end

return M
