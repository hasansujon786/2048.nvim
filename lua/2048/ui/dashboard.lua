local state = require('2048.state')
local Popup = require('nui.popup')
local Dashboard = Popup:extend('Dashboard')
local event = require('nui.utils.autocmd').event
local score, setScore = state.useScore()

local dashboard = nil
local M = { bufnr = 0 }

local function draw_content(bufnr, updatedScoret)
  local text = tostring(updatedScoret)
  local gap_width = 10 - vim.api.nvim_strwidth(text)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
    string.format(
      '%s%s%s',
      string.rep(' ', math.floor(gap_width / 2)),
      text,
      string.rep(' ', math.ceil(gap_width / 2))
    ),
  })
end

function Dashboard:init(popup_options)
  local options = vim.tbl_deep_extend('force', popup_options or {}, {
    border = 'double',
    relative = 'editor',
    focusable = false,
    position = { row = 2, col = '98%' },
    size = { width = 10, height = 1 },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:SpecialChar',
    },
  })

  Dashboard.super.init(self, options)
end

function Dashboard:view()
  self:mount()
  M.bufnr = self.bufnr
  draw_content(self.bufnr, score())
end

function M.increaseScore(tileValue)
  setScore(function(oldValue)
    return oldValue + tileValue
  end)
  if M.bufnr > 0 then
    draw_content(M.bufnr, score())
  end
end

function M.setup()
  dashboard = Dashboard()
  dashboard:view()

  -- timer:on(event.WinClosed, function()
  --   running_instances = running_instances - 1
  --   if running_instances < 1 then
  --     top_ofset = 1
  --   end
  -- end, { once = true })

  return dashboard
end

function M.hide()
  dashboard:hide()
end

return M
