local NuiLine = require('nui.line')
local state = require('2048.state')
local Popup = require('nui.popup')
local event = require('nui.utils.autocmd').event
local ui = require('2048.ui')
local controller = require('2048.controller')

local boardWidth, boardHeight = 51, 23

M = {}

function M.setupBoard()
  local popup = Popup({
    enter = false,
    focusable = true,
    border = {
      style = 'double',
    },
    position = { row = '30%', col = '50%' },
    size = { width = boardWidth, height = boardHeight },
    win_options = {
      winblend = 10,
      winhighlight = 'Normal:Normal,FloatBorder:NonText',
    },
    -- buf_options = {
    --   modifiable = false,
    --   readonly = true,
    -- },
  })

  -- mount/open the component
  popup:mount()
  state.bufnr = popup.bufnr

  -- unmount component when cursor leaves buffer
  -- popup:on(event.BufLeave, function()
  --   popup:unmount()
  -- end)

  -- set content
  -- vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { "Hello World" })

  popup:map('n', 'h', controller.left)
  popup:map('n', 'j', controller.down)
  popup:map('n', 'k', controller.up)
  popup:map('n', 'l', controller.right)
  return popup
end

local function renderEmptyPiece(line)
  line:append(ui.pieceEmpty, 'Error')
  line:append(ui.chars.vert, 'NonText')
  line:append(ui.pieceEmpty, 'Text')
  line:append(ui.chars.vert, 'NonText')
  line:append(ui.pieceEmpty, 'String')
  line:append(ui.chars.vert, 'NonText')
  line:append(ui.pieceEmpty, 'Number')
  return line
end

function M.drawEmptyBoard()
  for i = 1, boardHeight, 1 do
    local line = NuiLine()
    if i == 6 or i == 12 or i == 18 then
      line:append(ui.rowGap, ui.hl.border)
    else
      line = renderEmptyPiece(line)
    end
    line:render(state.bufnr, state.ns_id, i)
  end
end

return M
