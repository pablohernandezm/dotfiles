local M = {}

local mise = require("utils.mise")

---@class mise-format.Config.MiseOptions
---@field provider string
---@field global boolean

---@class mise-format.Config
---@field filetypes string | string[]
---@field cmd? string[] Formatter command
---@field mise? mise-format.Config.MiseOptions

---Format the buffer on-save using the command or vim.lsp.buf.format.
---If the command is not provided, vim.lsp.buf.format will be used.
---If the command is provided and is already available in $PATH, the command itself will be used, not mise-en-place.
---If the command is provided and is not available in $PATH, then it will be installed using the provider.
---@vararg mise-format.Config
function M:config(...)
  local configs = { ... }

  for _, config in ipairs(configs) do
    vim.api.nvim_create_autocmd('FileType', {
      pattern = config.filetypes,
      callback = function(_)
        vim.api.nvim_create_autocmd("BufWritePost", {
          callback = function(ev)
            if config.cmd then
              if config.mise then
                config.cmd = mise:get_mise_cmd({
                  cmd = config.cmd[1],
                  provider = config.mise.provider,
                  global = config.mise.global or false
                })
              end

              table.insert(config.cmd, ev.file)

              vim.fn.system(config.cmd)
              vim.schedule(function()
                vim.cmd.edit()
              end)
            else
              vim.lsp.buf.format({ async = false })
            end
          end
        })
      end
    })
  end
end

return M
