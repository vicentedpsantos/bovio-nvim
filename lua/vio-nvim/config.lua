M = {}


function M.setup(opts)
  assert(type(opts) == "table", "opts must be a table")
  assert(type(opts.shortcut_api_key) == "string", "shortcut_api_key must be a string")
  assert(type(opts.output) == "string", "output must be a string")
  assert(opts.output == "floaterm" or opts.output == "buffer", "output must be 'floaterm' or 'buffer'")

  if opts.output == nil then
    vim.g.bovio_output = "buffer"
  else
    vim.g.bovio_output = "floaterm"
  end

  vim.g.vio_nvim_shortcut_api_key = opts.shortcut_api_key
end

return M
