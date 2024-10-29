local bovio_api_testing = require('vio-nvim.bovio_api.testing')
local shortcut = require('vio-nvim.shortcut')
local ui = require('vio-nvim.ui')


--- Displays a story in a new buffer.
--- @return nil
local function display_story()
  local handle = io.popen("git branch --show-current")

  if handle == nil then
    print("[Vio-Nvim] Error: Could not get the current branch.")
    return
  end

  local current_branch = handle:read("*a")
  local story_id = string.sub(current_branch, 4, 9)

  if current_branch == nil then
    print("[Vio-Nvim] Error: Could not get the current branch.")
    return
  end

  if not string.match(current_branch, "^sc") then
    print("[Vio-Nvim] Error: Not a Shortcut story branch.")
    return
  end

  local story_table = shortcut.get_story(story_id)

  if story_table == nil then
    print("[Vio-Nvim] Error: Could not get the story.")
    return
  end

  ui.draw_story_info(story_table, current_branch)
end

--- COMMANDS ---
Commands = {
  {"VioDisplayStory", display_story, { desc = "Display the Shortcut story in a new buffer." }},
  {"RunFileTest", bovio_api_testing.run_file_test, { desc = "Run BoVio API tests on whole file." }},
  {"RunClosestTest", bovio_api_testing.run_closest_test, { desc = "Run BoVio API closest test." }}
}

for _, command in ipairs(Commands) do
  vim.api.nvim_create_user_command(
    command[1],
    command[2],
    command[3]
  )
end

return {
  display_story = display_story
}
