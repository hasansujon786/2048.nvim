local ui = require('2048.ui')
local state = require('2048.state')
local NuiText = require('nui.text')
local M = {}

function M.generateTileText(text)
  local pad_char = ui.pieceChar
  local formatter = '%s%s%s'
  local cel_len = 12
  local len = string.len(text)
  local total_pad = cel_len - len
  local balancer = math.fmod(total_pad, 2)
  local pad = (total_pad - balancer) / 2

  return formatter:format(pad_char:rep(pad), text, pad_char:rep(pad + balancer))
end

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
  if not tiles[from_nr].hasPiece then
    P('no tile')
    return
  end

  tiles[to_nr].hasPiece = true
  tiles[to_nr].piece = tiles[from_nr].piece

  tiles[from_nr].hasPiece = false
  tiles[from_nr].piece = nil
end

return M
