return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "html" },
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            ensure_install = {
                "markdown",
                "c",
                "cpp",
                "html",
                "css",
                "javascript",
                "typescript",
                "java",
                "kotlin",
                "lua",
            },
            sync_install = true,
        })
    end,
}

