local curl = require('plenary.curl')
local json = require('vio-nvim.json')

local M = {}

local shortcut_base_url = "https://api.app.shortcut.com/api/v3/"
local shortcut_api_key = os.getenv("SHORTCUT_SERVICE_API_KEY")

--- Build headers for Shortcut API.
--- @return table: The headers.
local function build_headers()
  return {
    ["Content-Type"] = "application/json",
    ["Shortcut-Token"] = shortcut_api_key
  }
end

--- Get Shortcut story by id. Returns a table if successful or nil if not.
--- @param story_id string: The story id.
--- @return table|nil: The story table or nil.
function M.get_story(story_id)
  local path = "stories/".. story_id
  local result = curl.get(shortcut_base_url .. path, { headers = build_headers() })

  if result.status ~= 200 then
    return nil
  end

  local result_table = json.decode(result.body)

  local comments = {}

  for _, comment in ipairs(result_table.comments) do
    local author = M.get_member(comment.author_id)

    if author == nil then
      author = { name = "Unknown" }
    end

    table.insert(comments, {
      author_id = comment.author_id,
      author_name = author.profile.name,
      created_at = comment.created_at,
      text = comment.text
    })
  end

  result_table["comments"] = comments

  return result_table
end

--- Get Shortcut member by id. Returns a table if successful or nil if not.
--- @param member_id string: The member id.
--- @return table|nil: The member table or nil.
function M.get_member(member_id)
  local path = "members/".. member_id
  local result = curl.get(shortcut_base_url .. path, { headers = build_headers() })

  if result.status ~= 200 then
    return nil
  end

  local result_table = json.decode(result.body)

  return result_table
end

return M
