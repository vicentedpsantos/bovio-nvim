M = {}

local test_output_buf = nil 

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

local function adjust_path_for_integration(file_path)
  local start_index = file_path:find("integration")
  if start_index then
    return file_path:sub(start_index)
  end
  return file_path
end

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

local function get_window_dimensions()
  local lines = vim.o.lines
  local columns = vim.o.columns

  -- TODO: pass this as an option during setup.
  local height = math.floor(lines * 0.5)
  local width = math.floor(columns * 0.8)

  return height, width
end

local function run_test_in_floaterm(command)
  local height, width = get_window_dimensions()

  local floaterm_cmd = string.format(":FloatermNew --autoclose=0 --title=vio.nvim.tests --height=%d --width=%d %s", height, width, command)

  vim.cmd(floaterm_cmd)
end

local function create_or_show_test_buffer()
  if test_output_buf and vim.api.nvim_buf_is_valid(test_output_buf) then
    vim.cmd("botright split | buffer " .. test_output_buf)
  else
    vim.cmd("botright vnew")
    test_output_buf = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_set_option(test_output_buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(test_output_buf, "bufhidden", "hide")
    vim.api.nvim_buf_set_option(test_output_buf, "swapfile", false)
  end

  vim.api.nvim_buf_set_lines(test_output_buf, 0, -1, false, { "Running tests, please wait..." })
end

local function run_test_command(command)
  if vim.g.bovio_output == "floaterm" then
    run_test_in_floaterm(command)
  else
    create_or_show_test_buffer()

    vim.fn.jobstart(command, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(test_output_buf, 0, -1, false, data)
        end
      end,
      on_exit = function()
        vim.api.nvim_buf_set_lines(test_output_buf, -1, -1, false, { "", "Press <CR> to hide..." })

        vim.api.nvim_buf_set_keymap(test_output_buf, 'n', '<CR>', ':hide<CR>', { noremap = true, silent = true })
      end,
    })
  end
end

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
