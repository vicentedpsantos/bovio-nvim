local M = {}

--- Creates a new buffer with the provided configuration.
--- @param config table: The configuration for the new buffer.
--- @return number (buffer number)
local function create_buffer(config)
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_open_win(buf, true, config)
  vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })

  return buf
end

function M.draw_story_info(story_table, branch)
  create_buffer({
    relative = 'win',
    row = 10,
    col = 50,
    width = 200,
    height = 50,
    title = "[SC-" .. story_table.id .. "] " .. story_table.name .. " (" .. story_table.estimate .. " points)",
    title_pos = 'center',
    border = 'rounded'
  })

  vim.api.nvim_paste("- [url](" .. story_table.app_url .. ")\n", false, -1)
  vim.api.nvim_paste("- estimate: " .. "3" .. " points\n", false, -1)
  vim.api.nvim_paste("- started: " .. story_table.started_at .. " UTC\n", false, -1)
  vim.api.nvim_paste("- labels: [" .. table.concat(vim.tbl_map(function(label) return label.name end, story_table.labels), ", ") .. "]\n", false, -1)
  vim.api.nvim_paste("- current branch: " .. branch, false, -1)
  vim.api.nvim_paste("\n\n" .. story_table.description, false, -1)
end

return M
