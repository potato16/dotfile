
local api = vim.api
local jsonPath = require('jsonpath')
-- local bnr = vim.fn.bufnr('%')
-- local ns_id = api.nvim_create_namespace('json_path')

local function visualizeJSONPath()
  -- local line_num = api.nvim_win_get_cursor(0)[1]
  local result = jsonPath.get()
  print(result)

  -- local opts = {
  --   hl_group = "Comment",
  --   hl_mode = "replace",
  --   virt_text = {{result, "random"}},
  --   virt_text_pos = 'right_align'
  -- }
  -- api.nvim_buf_clear_namespace(bnr,ns_id,0,-1)
  -- api.nvim_buf_set_extmark(bnr,ns_id,line_num-1,0,opts)
end
api.nvim_create_autocmd({"BufEnter", "BufWritePost", "CursorMoved"},{
  pattern = {"*.json"},
  callback=visualizeJSONPath
})

