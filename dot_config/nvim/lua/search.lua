local M = {}
local mise = require("utils.mise")
local win = require("utils.win")

---@private
---@param cmd string[]
---@param callback fun(lines:string[])
function M:__exec_cmd__(cmd, callback)
  local temp = vim.fn.tempname()

  vim.fn.jobstart(table.concat(cmd, " ") .. " > " .. temp, {
    term = true,
    on_exit = function()
      vim.cmd(":bd!")
      local res = vim.fn.readfile(temp)

      if res then
        callback(res)
      end

      os.remove(temp)
    end,
  })

  vim.cmd("startinsert")
end

---@class search.settings.mise_options
---@field global boolean

---@class search.settings
---@field win_opts vim.api.keyset.win_config | nil
---@field mise search.settings.mise_options | nil
---
---@param settings search.settings | nil
function M:search_file(settings)
  local cmd = { "fzf" }
  if settings and settings.mise then
    cmd = mise:get_mise_cmd({
      global = settings.mise.global,
      provider = "junegunn/fzf",
      cmd = "fzf"
    })
  end

  win:float_win(settings and settings.win_opts or nil)
  M:__exec_cmd__(cmd, function(lines)
    if lines[1] then
      vim.schedule(function()
        vim.cmd("edit! " .. vim.fn.fnameescape(lines[1]))
      end)
    end
  end)
end

---@param settings search.settings | nil
function M:rg(settings)
  ---@type string[]
  local fzf_cmd = { "fzf" }

  ---@type string[]
  local rg_cmd = { "rg" }

  if settings and settings.mise then
    fzf_cmd = mise:get_mise_cmd({
      global = settings.mise.global,
      provider = "junegunn/fzf",
      cmd = "fzf"
    })

    rg_cmd = mise:get_mise_cmd({
      global = settings.mise.global,
      provider = "aqua:BurntSushi/ripgrep",
      cmd = "rg"
    })
  end

  ---@param t string[]
  ---@vararg string
  ---return string[]
  local function add(t, ...)
    local new = { unpack(t) }
    local args = { ... }

    for i = 1, #args do
      table.insert(new, args[i])
    end

    return new
  end

  rg_cmd = add(rg_cmd, "--column", "--color=always", "--smart-case", "{q}", "||", ":")
  fzf_cmd = add(fzf_cmd, "--disabled", "--ansi")

  local cmd = {
    table.concat(fzf_cmd, " "),
    "--bind", "\"start:reload:" .. table.concat(rg_cmd, " ") .. "\"",
    "--bind", "\"change:reload:" .. table.concat(rg_cmd, " ") .. "\"",
  }

  vim.fn.setreg('+', table.concat(cmd, " "))

  win:float_win(settings and settings.win_opts or nil)

  M:__exec_cmd__(cmd, function(lines)
    if lines[1] then
      vim.schedule(function()
        local result = lines[1]

        ---@type string[]
        local parts = {}

        for str in string.gmatch(result, "([^:]+)") do table.insert(parts, str) end

        local file = vim.fn.fnameescape(parts[1])
        local row = parts[2]
        local col = parts[3]


        vim.cmd("edit! " .. file)
        vim.api.nvim_win_set_cursor(0, { tonumber(row), tonumber(col) })
        vim.cmd("normal! zz")
      end)
    end
  end)
end

return M;
