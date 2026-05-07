---@class KeyAction
---@field [1] function | HL.Dispatcher | string
---@field [2]? HL.BindOptions

---@alias GroupActions table<string, KeyAction>

---@class BindingGroup
---@field bindings GroupActions
---@field bind fun()
local M = {
  ---@param bindings? GroupActions
  ---@return BindingGroup
  new = function(bindings)
    local keybinds = bindings or {}

    return {
      bindings = keybinds,

      ---@param self BindingGroup
      bind = function(self)
        for key, cmd in pairs(self.bindings or {}) do
          local action = cmd[1]
          local options = cmd[2]

          if type(action) == "string" then
            hl.bind(key, hl.dsp.exec_cmd(action), options)
          else
            hl.bind(key, action, options)
          end
        end
      end
    }
  end,
}

return M
