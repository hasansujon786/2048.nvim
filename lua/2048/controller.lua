local board = require('2048.board')
local c = require('2048.constant')
local M = {}

function M.onUp()
  board.slideTiles(c.direction.up)
end

function M.onDown()
  board.slideTiles(c.direction.down)
end

function M.onLeft()
  board.slideTiles(c.direction.left)
end

function M.onRight()
  board.slideTiles(c.direction.right)
end

return M
