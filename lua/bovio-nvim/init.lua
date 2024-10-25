local shortcut = require('bovio-nvim.shortcut')
local ui = require('bovio-nvim.ui')

--- Displays a story in a new buffer.
--- @return nil
local function display_story()
  local handle = io.popen("git branch --show-current")
  local current_branch = handle:read("*a")
  local story_id = string.sub(current_branch, 4, 9)

  if current_branch == nil then
    print("[BoVio-Nvim] Error: Could not get the current branch.")
    return
  end

  if not string.match(current_branch, "^sc") then
    print("[BoVio-Nvim] Error: Not a Shortcut story branch.")
    return
  end

  local story_table = shortcut.get_story(story_id)

  if story_table == nil then
    print("[BoVio-Nvim] Error: Could not get the story.")
    return
  end

  ui.draw_story_info(story_table, current_branch)
end


return {
  display_story = display_story
}
