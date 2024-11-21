return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
      config = {
        week_header = {
          enable = true,
        },
        project = { enable = true, limit = 8, icon = '  Recent projects', label = '', action = 'Telescope find_files cwd=' },
        --header = {}, --your header
        --footer = {}, --your footer
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
