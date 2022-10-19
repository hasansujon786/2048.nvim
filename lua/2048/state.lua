local tile_cols, tile_rows = { 1, 7, 13, 19 }, { 0, 13, 26, 39 }
local tiles = {
  {
    col = tile_cols[1],
    row = tile_rows[1],
  },
  {
    col = tile_cols[1],
    row = tile_rows[2],
  },
  {
    col = tile_cols[1],
    row = tile_rows[3],
  },
  {
    col = tile_cols[1],
    row = tile_rows[4],
  },
  {
    col = tile_cols[2],
    row = tile_rows[1],
  },
  {
    col = tile_cols[2],
    row = tile_rows[2],
  },
  {
    col = tile_cols[2],
    row = tile_rows[3],
  },
  {
    col = tile_cols[2],
    row = tile_rows[4],
  },
  {
    col = tile_cols[3],
    row = tile_rows[1],
  },
  {
    col = tile_cols[3],
    row = tile_rows[2],
  },
  {
    col = tile_cols[3],
    row = tile_rows[3],
  },
  {
    col = tile_cols[3],
    row = tile_rows[4],
  },
  {
    col = tile_cols[4],
    row = tile_rows[1],
  },
  {
    col = tile_cols[4],
    row = tile_rows[2],
  },
  {
    col = tile_cols[4],
    row = tile_rows[3],
  },
  {
    col = tile_cols[4],
    row = tile_rows[4],
  },
}

local pieces = {
  two = {
    text = 'two',
    hl = 'String',
  },
}

return {
  tiles = tiles,
  pieces = pieces,
  bufnr = 0,
  ns_id = -1,
}
