local curl = require('plenary.curl')
local json = require('bovio-nvim.json')

-- https://developer.shortcut.com/api/rest/v3#Get-Story
--
local handle = io.popen("git branch --show-current")
local branch = handle:read("*a")

local shortcut_api_key = os.getenv("SHORTCUT_SERVICE_API_KEY")

print(shortcut_api_key)

local result = curl.get("https://api.app.shortcut.com/api/v3/stories/131540", {
  headers = {
    ["Content-Type"] = "application/json",
    ["Shortcut-Token"] = shortcut_api_key
  }
})

--- Creates a new buffer with the provided configuration.
--- @param config table: The configuration for the new buffer.
--- @return number (buffer number)
local function create_buffer(config)
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_open_win(buf, true, config)
  vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })

  return buf
end

local function paste_header(header)
  vim.api.nvim_paste("\n\n\n## " .. header .. "\n\n", false, -1)
end

local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

--- Displays a story in a new buffer.
--- @return nil
local function display_story()
  local buffer = create_buffer({
    relative = 'win',
    row = 10,
    col = 50,
    width = 200,
    height = 50,
    title = "[SC-" .. story.id .. "] " .. story.name .. " (" .. story.estimate .. " points)",
    title_pos = 'center',
    border = 'rounded'
  })

  local result_table = json.decode(result.body)

  vim.api.nvim_paste("- [url](" .. result_table.app_url .. ")\n", false, -1)
  vim.api.nvim_paste("- estimate: " .. result_table.estimate .. " points\n", false, -1)
  vim.api.nvim_paste("- started: " .. result_table.started_at .. " UTC\n", false, -1)
  vim.api.nvim_paste("- labels: [" .. table.concat(vim.tbl_map(function(label) return label.name end, result_table.labels), ", ") .. "]\n", false, -1)
  vim.api.nvim_paste("- current branch: " .. branch, false, -1)


  vim.api.nvim_paste("\n\n" .. result_table.description, false, -1)
end


return {
  display_story = display_story
}
