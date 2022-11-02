local tile_cols, tile_rows = { 1, 7, 13, 19 }, { 0, 13, 26, 39 }
local tiles = {
  {
    pos = 1,
    hasPiece = false,
    col = tile_cols[1],
    row = tile_rows[1],
  },
  {
    pos = 2,
    hasPiece = false,
    col = tile_cols[1],
    row = tile_rows[2],
  },
  {
    pos = 3,
    hasPiece = false,
    col = tile_cols[1],
    row = tile_rows[3],
  },
  {
    pos = 4,
    hasPiece = false,
    col = tile_cols[1],
    row = tile_rows[4],
  },
  {
    pos = 5,
    hasPiece = false,
    col = tile_cols[2],
    row = tile_rows[1],
  },
  {
    pos = 6,
    hasPiece = false,
    col = tile_cols[2],
    row = tile_rows[2],
  },
  {
    pos = 7,
    hasPiece = false,
    col = tile_cols[2],
    row = tile_rows[3],
  },
  {
    pos = 8,
    hasPiece = false,
    col = tile_cols[2],
    row = tile_rows[4],
  },
  {
    pos = 9,
    hasPiece = false,
    col = tile_cols[3],
    row = tile_rows[1],
  },
  {
    pos = 10,
    hasPiece = false,
    col = tile_cols[3],
    row = tile_rows[2],
  },
  {
    pos = 11,
    hasPiece = false,
    col = tile_cols[3],
    row = tile_rows[3],
  },
  {
    pos = 12,
    hasPiece = false,
    col = tile_cols[3],
    row = tile_rows[4],
  },
  {
    pos = 13,
    hasPiece = false,
    col = tile_cols[4],
    row = tile_rows[1],
  },
  {
    pos = 14,
    hasPiece = false,
    col = tile_cols[4],
    row = tile_rows[2],
  },
  {
    pos = 15,
    hasPiece = false,
    col = tile_cols[4],
    row = tile_rows[3],
  },
  {
    pos = 16,
    hasPiece = false,
    col = tile_cols[4],
    row = tile_rows[4],
  },
}
local score = 0

local M = {
  useScore = function()
    return function()
      return score
    end, function(fn)
      score = fn(score)
    end
  end,
  tiles = tiles,
  bufnr = 0,
  ns_id = -1,
}

return M
