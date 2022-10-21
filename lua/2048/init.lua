local NuiText = require('nui.text')
local board = require('2048.board')
local ui = require('2048.ui')
local state = require('2048.state')
local tile = require('2048.tile')
local utils = require('2048.utils')
local c = require('2048.constant')
local M = {}

--  1  2  3  4
--  5  6  7  8
--  9 10 11 12
-- 13 14 15 16

function M.startGame()
  local active_board = board.setupBoard()
  board.drawEmptyBoard()

  -- tile.insert(5, c.pieces.two)
  -- tile.insert(2, c.pieces.two)
  -- tile.insert(13, c.pieces.two)
  tile.insert(1, c.pieces.two)
  board.renderAllTiles()
  print('============================================================')
end

function _G.foo()
  board.drawEmptyBoard()
end

_G.remove = function(nr)
  tile.remove(nr)
  board.renderAllTiles()
end

_G.move = function(from, to)
  tile.moveFrom(from, to)
  board.renderAllTiles()
end

_G.add = function(nr, p)
  local pi = nil
  if p == 4 then
    pi = c.pieces.four
  elseif p == 2 then
    pi = c.pieces.two
  end

  tile.insert(nr, pi)
  board.renderAllTiles()
end

return M
