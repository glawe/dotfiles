-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
--
-- local fileType = vim.api.nvim_buf_get_option(0, 'filetype')
-- function GetDartOptions()
--   --if fileType == 'dart' then
--   return { '<leader>f', group = 'Flutter', icon = '' }
--   --end
-- end

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<A-left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<A-right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<A-down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<A-up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { noremap = true })

vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = 'Vertical split', noremap = true })
vim.keymap.set('n', '<leader>wh', ':split<CR>', { desc = 'Horizontal split', noremap = true })
vim.keymap.set('n', '<leader>wc', ':bd<CR>', { desc = 'Close', noremap = true })

vim.keymap.set('n', '<leader>fr', ':FlutterRun<CR>', { desc = 'Run', noremap = true })
vim.keymap.set('n', '<leader>fd', ':FlutterDevices<CR>', { desc = 'Devices', noremap = true })
vim.keymap.set('n', '<leader>fe', ':FlutterEmulators<CR>', { desc = 'Emulators', noremap = true })
vim.keymap.set('n', '<leader>fR', ':FlutterRestart<CR>', { desc = 'Restart', noremap = true })
vim.keymap.set('n', '<leader>fq', ':FlutterQuit<CR>', { desc = 'Quit', noremap = true })
vim.keymap.set('n', '<leader>fD', ':FlutterDevTools<CR>', { desc = 'Devtools', noremap = true })
vim.keymap.set('n', '<leader>fo', ':FlutterOutlineToggle<CR>', { desc = 'Outline Toggle', noremap = true })

vim.keymap.set('n', 'gb', '<c-t>', { desc = 'Navigate back', noremap = true })

vim.keymap.set('n', '<leader>db', ':DapToggleBreakpoint<CR>', { desc = 'Toggle Breakpoint', noremap = true })
vim.keymap.set('n', '<leader>dc', ':DapContinue<CR>', { desc = 'Continue', noremap = true })
vim.keymap.set('n', '<leader>dd', ':DapDisconnect<CR>', { desc = 'Disconnect', noremap = true })
vim.keymap.set('n', '<leader>de', ':DapEval<CR>', { desc = 'Eval', noremap = true })
vim.keymap.set('n', '<leader>dn', ':DapNew<CR>', { desc = 'New', noremap = true })
vim.keymap.set('n', '<leader>dr', ':DapRestartFrame<CR>', { desc = 'Restart Frame', noremap = true })
vim.keymap.set('n', '<leader>di', ':DapStepInto<CR>', { desc = 'Step Info', noremap = true })
vim.keymap.set('n', '<leader>do', ':DapStepOver<CR>', { desc = 'Step Over', noremap = true })
vim.keymap.set('n', '<leader>dO', ':DapStepOut<CR>', { desc = 'Step Out', noremap = true })
vim.keymap.set('n', '<leader>dT', ':DapTerminate<CR>', { desc = 'Terminate', noremap = true })

vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete buffer', noremap = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.keymap.set('n', '<leader>e',vim.api.tree.toggle, { desc = 'Toggle NvimTree' })

-- mouse users + nvimtree users!
vim.keymap.set('n', '<RightMouse>', function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == 'NvimTree' and 'nvimtree' or 'default'
  require('menu').open(options, { mouse = true })
end, {})

-- vim: ts=2 sts=2 sw=2 et
