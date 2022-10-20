local tile_cols, tile_rows = { 1, 7, 13, 19 }, { 0, 13, 26, 39 }
local tiles = {
  {
    hasPiece = false,
    col = tile_cols[1],
    row = tile_rows[1],
  },
  {
    hasPiece = false,
    col = tile_cols[1],
    row = tile_rows[2],
  },
  {
    hasPiece = false,
    col = tile_cols[1],
    row = tile_rows[3],
  },
  {
    hasPiece = false,
    col = tile_cols[1],
    row = tile_rows[4],
  },
  {
    hasPiece = false,
    col = tile_cols[2],
    row = tile_rows[1],
  },
  {
    hasPiece = false,
    col = tile_cols[2],
    row = tile_rows[2],
  },
  {
    hasPiece = false,
    col = tile_cols[2],
    row = tile_rows[3],
  },
  {
    hasPiece = false,
    col = tile_cols[2],
    row = tile_rows[4],
  },
  {
    hasPiece = false,
    col = tile_cols[3],
    row = tile_rows[1],
  },
  {
    hasPiece = false,
    col = tile_cols[3],
    row = tile_rows[2],
  },
  {
    hasPiece = false,
    col = tile_cols[3],
    row = tile_rows[3],
  },
  {
    hasPiece = false,
    col = tile_cols[3],
    row = tile_rows[4],
  },
  {
    hasPiece = false,
    col = tile_cols[4],
    row = tile_rows[1],
  },
  {
    hasPiece = false,
    col = tile_cols[4],
    row = tile_rows[2],
  },
  {
    hasPiece = false,
    col = tile_cols[4],
    row = tile_rows[3],
  },
  {
    hasPiece = false,
    col = tile_cols[4],
    row = tile_rows[4],
  },
}

local pieces = {
  two = {
    nr = 2,
    hl = 'String',
  },
  four = {
    nr = 4,
    hl = '@constant',
  },
}

return {
  tiles = tiles,
  pieces = pieces,
  bufnr = 0,
  ns_id = -1,
}
