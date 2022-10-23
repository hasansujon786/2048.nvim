local M = {}

--  1  2  3  4
--  5  6  7  8
--  9 10 11 12
-- 13 14 15 16

M.tileDirectionalPath = {
  right = {
    { 4, 3, 2, 1 },
    { 8, 7, 6, 5 },
    { 12, 11, 10, 9 },
    { 16, 15, 14, 13 },
  },
  left = {
    { 1, 2, 3, 4 },
    { 5, 6, 7, 8 },
    { 9, 10, 11, 12 },
    { 13, 14, 15, 16 },
  },
  down = {
    { 13, 9, 5, 1 },
    { 14, 10, 6, 2 },
    { 15, 11, 7, 3 },
    { 16, 12, 8, 4 },
  },
  up = {
    { 1, 5, 9, 13 },
    { 2, 6, 10, 14 },
    { 3, 7, 11, 15 },
    { 4, 8, 12, 16 },
  },
}

M.direction = {
  right = 'right',
  left = 'left',
  up = 'up',
  down = 'down',
}

M.pieces = {
  [2] = {
    nr = 2,
    hl = 'String',
  },
  [4] = {
    nr = 4,
    hl = '@constant',
  },
  [8] = {
    nr = 8,
    hl = '@define',
  },
  [16] = {
    nr = 16,
    hl = 'DiffRemoved',
  },
  [32] = {
    nr = 32,
    hl = '@symbol',
  },
  [64] = {
    nr = 64,
    hl = '@constant',
  },
  [128] = {
    nr = 128,
    hl = '@constant',
  },
  [256] = {
    nr = 256,
    hl = '@constant',
  },
  [512] = {
    nr = 512,
    hl = '@constant',
  },
  [1024] = {
    nr = 1024,
    hl = '@constant',
  },
  [2048] = {
    nr = 1024,
    hl = '@constant',
  },
}

return M
