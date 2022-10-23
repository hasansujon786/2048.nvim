local NuiLine = require('nui.line')
local state = require('2048.state')
local Popup = require('nui.popup')
local event = require('nui.utils.autocmd').event
local ui = require('2048.ui')
local tile = require('2048.tile')
local NuiText = require('nui.text')
local utils = require('2048.utils')
local c = require('2048.constant')

local filter = vim.tbl_filter
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

  popup:on(event.BufLeave, function()
    popup:unmount()
  end)
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

local function nextAllPaths(paths, curTileNr)
  for index, p_nr in ipairs(paths) do
    if curTileNr == p_nr then
      return utils.reverseTable(utils.slice(paths, 1, index - 1))
    end
  end
end

local function getCurPath(paths, curTileNr, usedPath)
  local nextPaths = nextAllPaths(paths, curTileNr)

  return filter(function(item)
    return not vim.tbl_contains(usedPath, item)
  end, nextPaths)
end

function M.slideTiles(direction)
  local tiles = state.tiles
  local paths2d = c.tileDirectionalPath[direction]

  for i = 1, #paths2d do
    local usedPaths1d = {}
    local paths1d = paths2d[i]

    for j = 1, #paths1d do
      local curTileIdx = paths1d[j]
      local curTile = tiles[curTileIdx]

      if curTile.hasPiece then
        local availablePaths = getCurPath(paths1d, curTileIdx, usedPaths1d)
        local nextTileIdx, usedTileIdx = tile.getNextAvailableTile(availablePaths, curTileIdx, paths1d[j - 1])

        if nextTileIdx > 0 then
          if usedTileIdx then
            table.insert(usedPaths1d, nextTileIdx)
          end
          tile.moveFrom(curTileIdx, nextTileIdx)
        end
      end
    end
  end

  -- Update tiles
  M.renderAllTiles()
end

return M
