-- https://developer.shortcut.com/api/rest/v3#Get-Story

local story = {
  app_url = "https://app.shortcut.com/findhotel/story/131540",
  description = "# What?\nIn order to easily identify if any analytics events correspond to a WL,\nwe need to add this data point to the event payload. \n\n\n### Critical MVP events\n- `RoomBooked`",
  archived = false,
  started = true,
  story_links = { {
    entity_type = "story-link",
    object_id = 131540,
    verb = "blocks",
    type = "object",
    updated_at = "2024-10-16T17:24:52Z",
    id = 500128539,
    subject_id = 131521,
    subject_workflow_state_id = 500120689,
    created_at = "2024-10-16T17:24:52Z"
  } },
  entity_type = "story",
  labels = { {
    app_url = "https://app.shortcut.com/findhotel/label/36147",
    description = "",
    archived = false,
    entity_type = "label",
    color = "#6db5ec",
    name = "backend",
    global_id = "v2:l:5c23cf99-8c00-4ead-bb4b-66ec6103de7f:36147",
    updated_at = "2023-04-25T03:59:26Z",
    external_id = nil,
    id = 36147,
    created_at = "2021-07-21T06:41:05Z"
  }, {
    app_url = "https://app.shortcut.com/findhotel/label/126747",
    description = "",
    archived = false,
    entity_type = "label",
    color = "#fdeba5",
    name = "whitelabel",
    global_id = "v2:l:5c23cf99-8c00-4ead-bb4b-66ec6103de7f:126747",
    updated_at = "2024-08-07T15:31:59Z",
    external_id = nil,
    id = 126747,
    created_at = "2024-08-07T15:31:59Z"
  } },
  mention_ids = { },
  member_mention_ids = { },
  story_type = "feature",
  custom_fields = { {
    field_id = "6260424f-259e-4763-8758-0eb28020aecd",
    value_id = "6260424f-24c5-4da6-97fb-232d09fa7cc1",
    value = "Medium"
  } },
  linked_files = { },
  workflow_id = 500120684,
  completed_at_override = nil,
  started_at = "2024-10-22T09:43:56Z",
  completed_at = nil,
  name = "Add WL brand code to RoomBooked tracking event",
  global_id = "v2:s:5c23cf99-8c00-4ead-bb4b-66ec6103de7f:131540",
  completed = false,
  comments = { },
  blocker = false,
  branches = { },
  epic_id = 130815,
  story_template_id = nil,
  external_links = { },
  previous_iteration_ids = { 131220 },
  requested_by_id = "5fb24f52-7255-4138-96f9-e44793aad445",
  iteration_id = 131543,
  tasks = { },
  label_ids = { 126747, 36147 },
  started_at_override = nil,
  group_id = "64760fcd-dbb5-4744-aacf-f7e83f2404b5",
  workflow_state_id = 500120687,
  updated_at = "2024-10-22T10:18:17Z",
  pull_requests = { },
  group_mention_ids = { },
  follower_ids = { "5fb24f52-7255-4138-96f9-e44793aad445", "633adf21-ef01-4b75-945a-80f282293a4c", "619e1d27-edae-49b8-aeff-07fb9582ddb8" },
  owner_ids = { "633adf21-ef01-4b75-945a-80f282293a4c" },
  external_id = nil,
  id = 131540,
  estimate = 3,
  commits = { },
  files = { },
  position = 62636816384,
  blocked = false,
  project_id = nil,
  deadline = nil,
  stats = {
    num_related_documents = 0
  },
  created_at = "2024-10-02T22:27:42Z",
  moved_at = "2024-10-22T09:43:56Z"
}

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

--- Displays a story in a new buffer.
--- @return nil
local function display_story()
  local buffer = create_buffer({
    relative = 'win',
    row = 10,
    col = 50,
    width = 200,
    height = 50,
    title = 'SC Story',
    title_pos = 'center',
    border = 'rounded'
  })

  paste_header("Description")
  vim.api.nvim_paste(story.description, true, -1)
  paste_header("URL")
  vim.api.nvim_paste(story.app_url, false, -1)
end


return {
  display_story = display_story
}
