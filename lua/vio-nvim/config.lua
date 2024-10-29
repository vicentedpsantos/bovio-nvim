M = {}

function M.setup(opts)
  assert(type(opts) == "table", "opts must be a table")
  assert(type(opts.shortcut_api_key) == "string", "shortcut_api_key must be a string")

  vim.g.vio_nvim_shortcut_api_key = opts.shortcut_api_key
end

return M
