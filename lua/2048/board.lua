local NuiLine = require('nui.line')
local state = require('2048.state')
local Popup = require('nui.popup')
local event = require('nui.utils.autocmd').event
local ui = require('2048.ui')
local tile = require('2048.tile')
local NuiText = require('nui.text')
local utils = require('2048.utils')
local c = require('2048.constant')

local boardWidth, boardHeight = 51, 23

M = {}

function M.setupBoard()
  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = 'double',
    },
    position = { row = '30%', col = '50%' },
    size = { width = boardWidth, height = boardHeight },
    win_options = {
      winblend = 10,
      winhighlight = 'Normal:Normal,FloatBorder:NonText',
      sidescrolloff = 0,
    },
    buf_options = {
      -- modifiable = false,
      -- readonly = true,
      filetype = '2048',
    },
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

  local controller = require('2048.controller')
  popup:map('n', 'h', controller.onLeft)
  popup:map('n', 'j', controller.onDown)
  popup:map('n', 'k', controller.onUp)
  popup:map('n', 'l', controller.onRight)
  return popup
end

local function renderEmptyLines(line)
  line:append(ui.chars.pieceEmpty, ui.hl.border)
  line:append(ui.chars.vert, ui.hl.border)
  line:append(ui.chars.pieceEmpty, ui.hl.border)
  line:append(ui.chars.vert, ui.hl.border)
  line:append(ui.chars.pieceEmpty, ui.hl.border)
  line:append(ui.chars.vert, ui.hl.border)
  line:append(ui.chars.pieceEmpty, ui.hl.border)
  return line
end

function M.drawEmptyBoard()
  for i = 1, boardHeight, 1 do
    local line = NuiLine()
    if i == 6 or i == 12 or i == 18 then
      line:append(ui.chars.borderRow, ui.hl.border)
    else
      line = renderEmptyLines(line)
    end
    line:render(state.bufnr, state.ns_id, i)
  end
end

function M.renderSingleTile(start_col, start_row, pi)
  for idx = 0, 4, 1 do
    local linenr_start = idx + start_col
    local text = nil
    if idx == 2 then
      text = NuiText(tile.generateTileText(pi.nr), pi.hl)
      -- text:render(bufnr, ns_id, linenr_start, start_row)
    else
      text = NuiText(ui.chars.pieceText, pi.hl)
    end
    text:render_char(state.bufnr, state.ns_id, linenr_start, start_row)
  end
end

function M.renderEmptyTile(start_col, start_row)
  for idx = 0, 4, 1 do
    local linenr_start = idx + start_col
    local text = NuiText(ui.chars.pieceEmpty, ui.hl.border)
    text:render_char(state.bufnr, state.ns_id, linenr_start, start_row)
  end
end

function M.renderAllTiles()
  for _, tileVal in ipairs(state.tiles) do
    if tileVal.hasPiece then
      M.renderSingleTile(tileVal.col, tileVal.row, tileVal.piece)
    else
      M.renderEmptyTile(tileVal.col, tileVal.row)
    end
  end
end

local function getCurPath(paths, nr, direction)
  for _, curPath in ipairs(paths) do
    if vim.tbl_contains(curPath, nr) then
      -- set path as direction
      local foundPath = curPath
      if direction == c.direction.up or direction == c.direction.left then
        foundPath = utils.reverseTable(curPath)
      end
      -- get valid tile paths
      for index, p_nr in ipairs(foundPath) do
        if nr == p_nr then
          return utils.slice(foundPath, index + 1, 4)
        end
      end
    end
  end
end

-- local curPath = getCurPath(c.tileDirectionalPath.horizontal, 1, c.direction.left)
-- local curPath = getCurPath(c.tileDirectionalPath.horizontal, 8, c.direction.right)
-- P(curPath)

function M.slideTiles(direction, paths)
  local moves = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
  for curIndex, curTile in ipairs(state.tiles) do
    if curTile.hasPiece then
      local curPath = getCurPath(paths, curIndex, direction)
      local nextIndex = tile.getNextAvailableTile(curPath, curIndex)
      moves[curIndex] = nextIndex
    end
  end

  -- Update tile according to available moves
  for from, to in ipairs(moves) do
    if to > 0 then
      tile.moveFrom(from, to)
    end
  end
  M.renderAllTiles()
end

return M
