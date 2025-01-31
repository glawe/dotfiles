return {
  'j-hui/fidget.nvim',
  tag = 'v1.0.0', -- Make sure to update this to something recent!
  opts = {
    integration = {
      ['nvim-tree'] = {
        enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
      },
      ['xcodebuild-nvim'] = {
        enable = false, -- Integrate with wojciech-kulik/xcodebuild.nvim (if installed)
      },
    },
  },
}
