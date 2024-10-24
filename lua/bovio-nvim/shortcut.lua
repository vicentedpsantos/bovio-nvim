local curl = require('plenary.curl')
local json = require('bovio-nvim.json')

local M = {}

local shortcut_base_url = "https://api.app.shortcut.com/api/v3/"
local shortcut_api_key = os.getenv("SHORTCUT_SERVICE_API_KEY")

local function build_headers()
  return {
    ["Content-Type"] = "application/json",
    ["Shortcut-Token"] = shortcut_api_key
  }
end

--- Get Shortcut story by id.
--- @param story_id string: The story id.
--- @return table: The story object.
function M.get_story(story_id)
  local path = "stories/".. story_id
  local result = curl.get(shortcut_base_url .. path, { headers = build_headers() })
  local result_table = json.decode(result.body)

  return result_table
end

return M
