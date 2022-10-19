local NuiText = require('nui.text')
local board = require('2048.board')
local ui = require('2048.ui')
local state = require('2048.state')
local tile = require('2048.tile')

local lines = {}

_G.render = function()
  -- R('2048')
  local active_board = board.setupBoard()
  board.drawEmptyBoard()

  foo()
  -- P(pi.col, pi.row)
  -- local pi = state.tiles[1]
  -- renderTile(pi.col, pi.row, state.pieces.two)
end

_G.foo = function()
  for i = 1, 16, 1 do
    local pi = state.tiles[i]
    -- P(pi.col, pi.row)
    tile.render(pi.col, pi.row, state.pieces.two)
  end
end
