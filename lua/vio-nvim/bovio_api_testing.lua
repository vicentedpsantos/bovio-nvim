
M = {}

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

local function run_test_command(command)
  -- Create a new buffer and window for test output
  vim.cmd("botright vnew")
  local buf = vim.api.nvim_get_current_buf()
  
  -- Set buffer options for test output
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  
  -- Set a placeholder message while the tests are running
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Running tests, please wait..." })

  -- Run the test command and write output to buffer
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        -- Clear placeholder and display actual output
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
      end
    end,
    on_exit = function()
      vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "", "Press any key to close..." })
      
      -- Set up autocmd to close buffer on any key press
      vim.api.nvim_buf_set_keymap(buf, 'n', '<any>', ':bwipeout!<CR>', { noremap = true, silent = true })
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
