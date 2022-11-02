local Popup = require('nui.popup')
local Alert = Popup:extend('Alert')
local event = require('nui.utils.autocmd').event

local M = {}
local alert = nil

local function draw_content(bufnr, updatedScoret)
  local text = tostring(updatedScoret)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { ' ' .. text })
end

function Alert:init(popup_options)
  local options = vim.tbl_deep_extend('force', popup_options or {}, {
    border = 'double',
    relative = 'editor',
    focusable = false,
    position = { row = 5, col = '98%' },
    size = { width = 30, height = 1 },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:SpecialChar',
    },
  })

  Alert.super.init(self, options)
end

function Alert:render()
  self:mount()
  self:update_content('Game started')
end

function Alert:update_content(msg)
  draw_content(self.bufnr, msg)

  vim.defer_fn(function()
    self:clear()
  end, 1500)
end

function Alert:clear()
  draw_content(self.bufnr, '')
end

function M.setup()
  alert = Alert()
  alert:render()

  return alert
end

function M.hide()
  alert:hide()
end

function M.notify(msg)
  alert:update_content(msg)
end

return M
