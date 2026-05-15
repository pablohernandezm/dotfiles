local mise = require("utils.mise")
local M = {}

---@alias UserCmdTable table<string, string[]>

--- User command builder
---@private
---@param cmd_map UserCmdTable
function M:build_usercmds(cmd_map)
  vim.api.nvim_create_user_command('MiseLspFormat', function(_)
    local ft = vim.bo.filetype
    local cmd = cmd_map[ft] ~= nil and cmd_map[ft] or nil
    if cmd then
      vim.cmd.write()
      vim.fn.system({ unpack(cmd), " ", vim.fn.expand("%") })
    else
      vim.lsp.buf.format()
    end
  end, {})
end

---@class MiseOptions
---@field provider string
---@field global boolean | nil

---@class FormatOptions -- if set, the cmd will run on save
---@field on_save boolean | nil default: true
---@field cmd string[] | nil Overrides vim.lsp.buf.format()

---@class LspCommandOptions
---@field cmd string
---@field filetypes string[]
---@field root_markers string[]
---@field mise_options MiseOptions | nil
---@field settings table | nil
---@field format FormatOptions | nil

---@param commands table<string, LspCommandOptions>
function M:setup(commands)
  ---@type table<string, fun(file: string)>
  local format_on_save_table = {}

  ---@type UserCmdTable
  local format_cmd_table = {}

  for key, command in pairs(commands) do
    -- Command used to call the formatter
    local cmd = command.mise_options and mise:get_mise_cmd({
      command = command.cmd,
      global = command.mise_options.global,
      provider = command.mise_options.provider
    }) or { command.cmd }

    -- User command: set the cmd to each registered filetype
    for _, filetype in pairs(command.filetypes) do
      if not format_cmd_table[filetype] then
        format_cmd_table[filetype] = cmd
      end
    end

    -- Configure lsp
    vim.lsp.config[key] = {
      cmd = cmd,
      filetypes = command.filetypes,
      root_markers = command.root_markers,
      settings = command.settings
    }

    -- Format on save: prepare table
    if command.format and command.format.on_save then
      format_on_save_table[key] = function(file)
        if command.format.cmd ~= nil then
          vim.fn.system({ unpack(command.format.cmd), " ", file })
          vim.cmd.edit()
        else
          vim.lsp.buf.format({ async = false })
        end
      end
    end

    -- Enable lsp entry
    vim.lsp.enable(key)
  end

  --- User command: build
  M:build_usercmds(format_cmd_table)

  --- Format on save: autocmd
  if next(format_on_save_table) then
    local group = vim.api.nvim_create_augroup("mise_lsp_format_on_save_group", { clear = true })

    vim.api.nvim_create_autocmd('BufWritePost', {
      group = group,
      callback = function(ev)
        local clients = vim.lsp.get_clients({ bufnr = ev.buf })

        for _, client in pairs(clients) do
          if client and format_on_save_table[client.name] then
            format_on_save_table[client.name](ev.file)
          end
        end
      end
    })
  end
end

return M
