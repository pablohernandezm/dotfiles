local M = {}

local mise = require("utils.mise")

---@class mise-format.Config.MiseOptions
---@field provider string
---@field global boolean

---@class mise-format.Config
---@field filetypes string | string[]
---@field write_on_save? boolean Enable write on save. Default is true
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
      callback = function(ev)
        ---@type function | nil
        local formatter = nil

        ---set formatter
        if config.cmd then
          if config.mise then
            config.cmd = mise:get_mise_cmd({
              cmd = config.cmd[1],
              provider = config.mise.provider,
              global = config.mise.global or false
            })
          end

          table.insert(config.cmd, ev.file)

          formatter = function()
            vim.fn.system(config.cmd)
            vim.schedule(function()
              vim.cmd.edit()
            end)
          end
        else
          formatter = function()
            vim.lsp.buf.format({ async = false })
          end
        end

        ---write on save
        if config.write_on_save == nil then config.write_on_save = true end

        if config.write_on_save then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = 0,
            callback = function(_)
              formatter()
            end
          })
        end

        ---user command
        vim.api.nvim_create_user_command("MiseFormat", formatter, {})
      end
    })
  end
end

return M
