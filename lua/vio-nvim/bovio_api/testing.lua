M = {}

-- Global variable to store the test output buffer ID
local test_output_buf = nil

-- Helper function to determine the test type based on file path
local function get_test_type(file_path)
  if file_path:match("integration") and file_path:match("e2e") then
    return "e2e"
  elseif file_path:match("integration") then
    return "integration"
  elseif file_path:match("test") then
    return "unit"
  end
  return nil
end

-- Helper function to adjust path to start from "integration" if necessary
local function adjust_path_for_integration(file_path)
  local start_index = file_path:find("integration")
  if start_index then
    return file_path:sub(start_index)
  end
  return file_path
end

-- Function to get the closest test line (specifically on "test" keyword)
local function get_closest_test_line()
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for i = cursor_line, 1, -1 do
    if lines[i]:match("^%s*test") then
      return i
    end
  end
  return nil
end

-- Function to display or create the test output buffer
local function create_or_show_test_buffer()
  if test_output_buf and vim.api.nvim_buf_is_valid(test_output_buf) then
    -- Show existing buffer in a new split window
    vim.cmd("botright split | buffer " .. test_output_buf)
  else
    -- Create a new buffer and window for test output
    vim.cmd("botright vnew")
    test_output_buf = vim.api.nvim_get_current_buf()

    -- Set buffer options for test output
    vim.api.nvim_buf_set_option(test_output_buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(test_output_buf, "bufhidden", "hide")
    vim.api.nvim_buf_set_option(test_output_buf, "swapfile", false)
  end

  -- Clear any previous content from buffer
  vim.api.nvim_buf_set_lines(test_output_buf, 0, -1, false, { "Running tests, please wait..." })
end

-- Function to run tests in the test output buffer
local function run_test_command(command)
  -- Display or create the test output buffer
  create_or_show_test_buffer()

  -- Run the test command and write output to buffer
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        -- Replace placeholder with actual output
        vim.api.nvim_buf_set_lines(test_output_buf, 0, -1, false, data)
      end
    end,
    on_exit = function()
      vim.api.nvim_buf_set_lines(test_output_buf, -1, -1, false, { "", "Press <CR> to hide..." })

      -- Set up a keymap to hide the buffer on Enter
      vim.api.nvim_buf_set_keymap(test_output_buf, 'n', '<CR>', ':hide<CR>', { noremap = true, silent = true })
    end,
  })
end

-- Command to run the entire file based on test type
function M.run_file_test()
  local file_path = vim.fn.expand("%:p")
  local test_type = get_test_type(file_path)
  local command

  if test_type == "e2e" then
    command = "make e2e args=" .. adjust_path_for_integration(file_path)
  elseif test_type == "integration" then
    command = "make integration args=" .. adjust_path_for_integration(file_path)
  else
    command = "mix test " .. file_path
  end

  run_test_command(command)
end

-- Command to run the closest test based on test type
function M.run_closest_test()
  local file_path = vim.fn.expand("%:p")
  local test_type = get_test_type(file_path)
  local closest_test_line = get_closest_test_line()
  local command

  if test_type == "e2e" then
    command = "make e2e args=" .. adjust_path_for_integration(file_path) .. ":" .. closest_test_line
  elseif test_type == "integration" then
    command = "make integration args=" .. adjust_path_for_integration(file_path) .. ":" .. closest_test_line
  else
    command = "mix test " .. file_path .. ":" .. closest_test_line
  end

  run_test_command(command)
end

return M
