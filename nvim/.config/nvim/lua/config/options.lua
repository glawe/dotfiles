vim.opt.number = true
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.o.sm = true

vim.o.wbr = '%=%m 󰈙 %f'

vim.diagnostic.config({
  virtual_text = false,
})

local dap = require('dap')

-- Flutter
dap.adapters.dart = {
  type = 'executable',
  command = 'dart',
  args = { 'debug_adapter' },
}

dap.adapters.flutter = {
  type = 'executable',
  command = 'flutter',
  args = { 'debug_adapter' },
}
dap.set_log_level('TRACE')

local dart_path = os.getenv('DART_PATH')
local flutter_path = os.getenv('FLUTTER_PATH')

local get_device = function()
  local co = coroutine.running()
  local output = ''
  local exit_code = 0
  local on_stdout = function(_, data)
    if data then
      for _, line in ipairs(data) do
        if string.match(line, '•') then
          output = output .. line .. '\n'
        end
      end
    end
  end

  vim.print('Running flutter devices...')
  local job_id = vim.fn.jobstart('flutter devices', {
    stdout_buffered = true,
    on_stdout = on_stdout,
    on_stderr = on_stdout,
    on_exit = function(_, code, _)
      exit_code = code
    end,
  })
  vim.fn.jobwait({ job_id })
  if exit_code ~= 0 then
    return vim.print('Failed to retrieve device')
  end

  vim.ui.select(vim.fn.split(output, '\n'), {
    prompt = 'Select Device',
    telescope = require 'telescope.themes'.get_cursor(),
  }, function(selected)
    coroutine.resume(co, selected)
  end)
  local selected_device = coroutine.yield()
  return vim.fn.trim(vim.fn.split(selected_device, '•')[2])
end

dap.configurations.dart = {
  {
    print(flutter_path),
    type = 'flutter',
    request = 'launch',
    name = 'Launch Flutter | Development',
    dartSdkPath = dart_path,
    flutterSdkPath = flutter_path,
    program = '${workspaceFolder}/lib/main.dart',
    cwd = '${workspaceFolder}',
    toolArgs = function()
      local default_flutter_device = os.getenv('DEFAULT_FLUTTER_DEVICE')
      local selected_device = default_flutter_device
      if not selected_device then
        selected_device = 'macos'
        --  selected_device = get_device()
      end
      print(selected_device)
      return { '-d ', selected_device }
    end,
  },
  {
    type = 'flutter',
    request = 'launch',
    name = 'Launch Flutter | Mock',
    dartSdkPath = dart_path,
    flutterSdkPath = flutter_path,
    program = '${workspaceFolder}/lib/main_mock.dart',
    cwd = '${workspaceFolder}',
    toolArgs = function()
      local default_flutter_device = os.getenv('DEFAULT_FLUTTER_DEVICE')
      local selected_device = default_flutter_device
      if not selected_device then
        selected_device = get_device()
      end

      return { '-d', selected_device, '--flavor', 'development' }
    end,
  },
  {
    type = 'flutter',
    request = 'launch',
    name = 'Launch Flutter | Production',
    dartSdkPath = dart_path,
    flutterSdkPath = flutter_path,
    program = '${workspaceFolder}/lib/main_production.dart',
    cwd = '${workspaceFolder}',
    toolArgs = function()
      local default_flutter_device = os.getenv('DEFAULT_FLUTTER_DEVICE')
      local selected_device = default_flutter_device
      if not selected_device then
        selected_device = get_device()
      end
      vim.print(selected_device)
      return { '-d', selected_device, '--flavor', 'development' }
    end,
  },
  {
    type = 'flutter',
    request = 'launch',
    name = 'Launch Flutter | Staging',
    dartSdkPath = dart_path,
    flutterSdkPath = flutter_path,
    program = '${workspaceFolder}/lib/main_staging.dart',
    cwd = '${workspaceFolder}',
    toolArgs = function()
      local default_flutter_device = os.getenv('DEFAULT_FLUTTER_DEVICE')
      local selected_device = default_flutter_device
      if not selected_device then
        selected_device = get_device()
      end

      return { '-d', selected_device, '--flavor', 'development' }
    end,
  },
}
