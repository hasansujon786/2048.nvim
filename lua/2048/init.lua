local NuiText = require('nui.text')
local board = require('2048.board')
local ui = require('2048.ui')
local state = require('2048.state')
local tile = require('2048.tile')
local M = {}

--  1  2  3  4
--  5  6  7  8
--  9 10 11 12
-- 13 14 15 16

local function startGame()
  -- R('2048')
  local active_board = board.setupBoard()
  board.drawEmptyBoard()

  tile.insert(1, state.pieces.two)
  board.updateTiles()
end

_G.remove = function(nr)
  tile.remove(nr)
  board.updateTiles()
end

_G.move = function(from, to)
  tile.moveFrom(from, to)
  board.updateTiles()
end

_G.add = function(nr, p)
  local pi = nil
  if p == 4 then
    pi = state.pieces.four
  elseif p == 2 then
    pi = state.pieces.two
  end

  tile.insert(nr, pi)
  board.updateTiles()
end

keymap('n', '<leader>e', function()
  startGame()
end)

return M
