local ui = require('2048.ui')
local state = require('2048.state')
local dashboard = require('2048.ui.dashboard')
local c = require('2048.constant')
local M = {}

function M.insert(to_nr, piece)
  local tiles = state.tiles
  tiles[to_nr].hasPiece = true
  tiles[to_nr].piece = piece
end

function M.remove(from_nr)
  local tiles = state.tiles
  tiles[from_nr].hasPiece = false
  tiles[from_nr].piece = nil
end

function M.moveFrom(from_nr, to_nr)
  local tiles = state.tiles
  local fromTile, toTile = tiles[from_nr], tiles[to_nr]
  if not fromTile.hasPiece then
    P('no tile from_nr', from_nr)
    return
  end
  -- If both the tiles are same then marge the pieces & increase the number
  if fromTile.hasPiece and toTile.hasPiece and fromTile.piece.nr == toTile.piece.nr then
    local tileValue = fromTile.piece.nr * 2
    tiles[to_nr].hasPiece = true
    tiles[to_nr].piece = c.pieces[tileValue]
    dashboard.increaseScore(tileValue)
  else
    tiles[to_nr].hasPiece = true
    tiles[to_nr].piece = tiles[from_nr].piece
  end

  tiles[from_nr].hasPiece = false
  tiles[from_nr].piece = nil
end

function M.getNextAvailableTile(availablePaths, curIndex)
  local tiles = state.tiles
  local finalNextIndex = 0

  for _, nextIndex in ipairs(availablePaths) do
    local nextTile = tiles[nextIndex]
    local curTile = tiles[curIndex]

    -- If the next tile is empty then save the position & check for it's nextTile
    if not nextTile.hasPiece then
      finalNextIndex = nextIndex
    elseif nextTile.hasPiece then
      -- If nextTile has a piece & it is different than curTile
      -- then return with the prev pos index.
      if nextTile.piece.nr ~= curTile.piece.nr then
        return finalNextIndex
      elseif nextTile.piece.nr == curTile.piece.nr then
        -- If nextTile & curTile's piece is same
        -- then return with nextIndex & mark the tile as used.
        return nextIndex, nextIndex
      end
    end
  end

  return finalNextIndex
end

function M.getEmptyTiles()
  local tiles = state.tiles
  return vim.tbl_filter(function(tile)
    if tile.piece and tile.piece.nr > 0 then
      return false
    end
    return true
  end, tiles)
end

function M.insertRandomTile(emptyTiles)
  local nr = math.random(1, #emptyTiles)
  M.insert(emptyTiles[nr].pos, c.pieces[nr % 2 > 0 and 2 or 4])
end

function M.generateTileText(text)
  local pad_char = ui.chars.pieceChar
  local formatter = '%s%s%s'
  local cel_len = 12
  local len = string.len(text)
  local total_pad = cel_len - len
  local balancer = math.fmod(total_pad, 2)
  local pad = (total_pad - balancer) / 2

  return formatter:format(pad_char:rep(pad), text, pad_char:rep(pad + balancer))
end

return M
