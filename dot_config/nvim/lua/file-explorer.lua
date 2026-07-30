local oil = require("oil")
local group = vim.api.nvim_create_augroup("file-explorer", { clear = true })

local state = {
  ---@type number | nil
  buffer = nil,
}

---Register an explorer buffer
---@param buf number
function state:new_buffer(buf)
  assert(type(buf) == "number", "Buffer must be a number")
  assert(vim.api.nvim_buf_is_valid(buf), "Buffer is not valid")

  self:del_buffer()

  self.buffer = buf
end

--- Delete explorer buffer from the state
function state:del_buffer()
  self.buffer = nil
end

---Calculate split width based on textwidth and window width.
---A minimum width of 25 is enforced. If textwidth is not set, returns nil.
---@return integer|nil
local split_width = function()
  local min = 25

  local w = nil

  if vim.g.text_width then
    w = vim.g.text_width
  elseif vim.o.textwidth then
    w = vim.o.textwidth
  end

  if w and w < min then
    w = min
  end

  return w and math.abs(math.floor((vim.o.columns - w) / 2)) or nil
end

--- Close oil split
local oil_split_close = function()
  if state.buffer then
    state:del_buffer()
    vim.cmd("q")
  end
end

--- Open oil split
local oil_split_open = function()
  vim.cmd("vsplit")

  local sw = split_width()
  if sw then
    vim.cmd("vertical resize " .. sw)
  end
  oil.open()
  state:new_buffer(vim.api.nvim_win_get_buf(0))

  --- Close when not focused
  -- vim.api.nvim_create_autocmd("WinLeave", {
  --   group = group,
  --   buffer = state.buffer,
  --   once = true,
  --   callback = function()
  --     local win = vim.api.nvim_get_current_win()
  --     vim.api.nvim_win_close(win, true)
  --     state:del_buffer()
  --   end,
  -- })
end

--- Toggle oil split
local oil_split_toggle = function()
  if state.buffer then
    oil_split_close()
  else
    oil_split_open()
  end
end

--- Setup
oil.setup({
  keymaps = {
    ["<CR>"] = function()
      oil.select({
        close = true,
        handle_buffer_callback = function(buf)
          local entry = oil.get_cursor_entry()

          if entry and entry.type == "directory" then
            oil.select()
            return
          end

          oil_split_toggle()
          vim.api.nvim_set_current_buf(buf)
        end,
      })
    end,
  },
})

--- Keymaps
vim.keymap.set("n", "<leader>e", oil_split_toggle, { desc = "Open file explorer" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  group = group,
  callback = function(ev)
    vim.keymap.set("n", "<S-l>", "<CR>", { buf = ev.buf, remap = true, desc = "Open entry" })
    vim.keymap.set("n", "<S-h>", "-", { buf = ev.buf, remap = true, desc = "Parent path" })
  end,
})
