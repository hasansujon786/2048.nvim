local M = {}

M.tileDirectionalPath = {
  horizontal = {
    { 1, 2, 3, 4 },
    { 5, 6, 7, 8 },
    { 9, 10, 11, 12 },
    { 13, 14, 15, 16 },
  },
  verticle = {
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
  two = {
    nr = 2,
    hl = 'String',
  },
  four = {
    nr = 4,
    hl = '@constant',
  },
}

return M
