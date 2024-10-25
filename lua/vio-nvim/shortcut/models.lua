M = {}

Member = {}
Member.__index = Member
local function build_member(attrs)
  local self = setmetatable({}, Member)

  self.created_at = attrs.created_at
  self.disabled = attrs.disabled
  self.email_address = attrs.profile.email_address
  self.id = attrs.id
  self.mention_name = attrs.profile.mention_name
  self.name = attrs.profile.name
  self.role = attrs.role
  self.state = attrs.state
  self.updated_at = attrs.updated_at

  return self
end

local function build_labels(attrs)
  local labels = {}
  for _, label in ipairs(attrs) do
    table.insert(labels, label.name)
  end
  return labels
end

Story = {}
Story.__index = Story
local function build_story(attrs)
  local self = setmetatable({}, Story)

  self.app_url = attrs.app_url
  self.archived = attrs.archived
  self.blocked = attrs.blocked
  self.blocker = attrs.blocker
  self.comments = attrs.comments
  self.completed = attrs.completed
  self.completed_at = attrs.completed_at
  self.created_at = attrs.created_at
  self.cycle_time = attrs.cycle_time
  self.deadline = attrs.deadline
  self.description = attrs.description
  self.epic_id = attrs.epic_id
  self.estimate = attrs.estimate
  self.external_id = attrs.external_id
  self.id = attrs.id
  self.labels = build_labels(attrs.labels)
  self.name = attrs.name
  self.owner_ids = attrs.owner_ids
  self.started = attrs.started
  self.started_at = attrs.started_at
  self.story_type = attrs.story_type
  self.updated_at = attrs.updated_at

  return self
end


return {
  build_member = build_member,
  build_story = build_story,
}
