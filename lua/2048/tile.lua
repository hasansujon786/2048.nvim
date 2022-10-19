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

function M.render(start_col, start_row, pi)
  for idx = 0, 4, 1 do
    local linenr_start = idx + start_col
    local text = nil
    if idx == 2 then
      text = NuiText(M.generateTileText(pi.text), pi.hl)
      -- text:render(bufnr, ns_id, linenr_start, start_row)
    else
      text = NuiText(ui.pieceText, pi.hl)
    end
    text:render_char(state.bufnr, state.ns_id, linenr_start, start_row)
  end
end

return M
