-- https://medium.com/@lllttt06/flutter-development-with-neovim-7e45669aac53
return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    -- config = true,
    config = function()
        require('flutter-tools').setup({
            debugger = {
                enabled = false,
                run_via_dap = true,
                register_configurations = function(_)
                    require('dap').configurations.dart = {}
                    require('dap.ext.vscode').load_launchjs()
                end,
            },
            settings = {
                showTodos = true,
                completeFunctionCalls = true,
                analysisExcludedFolders = { '<path-to-flutter-sdk-packages>' },
                renameFilesWithClasses = 'prompt', -- "always"
                enableSnippets = true,
                updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
            },
            dev_log = {
                enabled = true,
                filter = nil, -- optional callback to filter the log
                -- takes a log_line as string argument; returns a boolean or nil;
                -- the log_line is only added to the output if the function returns true
                notify_errors = true, -- if there is an error whilst running then notify the user
                --open_cmd = 'tabedit', -- command to use to open the log buffer
                open_cmd = '10split',
            },
        })
    end,
}
