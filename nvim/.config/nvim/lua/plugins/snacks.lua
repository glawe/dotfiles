return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bufdelete = { enabled = true },
    bigfile = { enabled = true },
    notifier = { enabled = true, timeout = 5000 },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    lazygit = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = 'header' },
        --{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { section = 'startup' },
      },
    },
  },
}
