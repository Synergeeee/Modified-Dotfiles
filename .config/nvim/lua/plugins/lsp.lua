return{
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            -- c/cpp
            "clangd",

            -- web dev (html, css, javascript respectively)
            "cssls",
            "jsonls",

            -- python
            "pyright",

            -- misc
            "eslint", -- JSON
            "lua_ls", -- Lua Language server
            "emmet_ls" -- for emmet 
        }
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
