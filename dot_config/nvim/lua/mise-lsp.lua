local mise = require("utils.mise")

local M = {}

vim.lsp.config('*', { root_markers = { ".git" } })

---@class mise-lsp.Config.mise_options
---@field provider string
---@field global? boolean

---@class mise-lsp.Config: vim.lsp.Config
---@field name string LSP name
---@field cmd string[] LSP command
---@field enable? boolean Automatically enable the lsp client. Default: false
---@field mise? mise-lsp.Config.mise_options If set, try to get a command from mise-en-place if available.

---Configure the given LSPs.
---@vararg mise-lsp.Config
function M:config(...)
  local configs = { ... }

  for _, config in ipairs(configs) do
    if config.mise and type(config.cmd) ~= "function" then
      local cmd = mise:get_mise_cmd({
        cmd = table.concat(config.cmd, " "),
        provider = config.mise.provider,
        global = config.mise.global
      })

      config.cmd = cmd

    end

    local enable = config.enable

    config.mise = nil
    config.enable = nil

    vim.lsp.config(config.name, config)

    if enable then
      vim.lsp.enable(config.name)
    end
  end
end

return M;
