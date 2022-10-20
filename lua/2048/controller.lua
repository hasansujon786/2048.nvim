local board = require('2048.board')
local c = require('2048.constant')
local M = {}

function M.onUp()
  board.slideTiles(c.direction.up, c.tileDirectionalPath.verticle)
end

function M.onDown()
  board.slideTiles(c.direction.down, c.tileDirectionalPath.verticle)
end

function M.onLeft()
  board.slideTiles(c.direction.left, c.tileDirectionalPath.horizontal)
end

function M.onRight()
  board.slideTiles(c.direction.right, c.tileDirectionalPath.horizontal)
end

return M
