-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	lazy = false,
-- 	name = "gruvbox",
-- 	priority = 997,
-- 	config = function()
-- 		vim.cmd.colorscheme("gruvbox")
-- 	end,
-- }



--return {
--    "AlphaTechnolog/pywal.nvim",
--    lazy = false,
--    priority = 1000,
--    config = function()
       -- Set up pywal and load the colors
--        require("pywal").setup()
--
--    end,
--}

return {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000, -- Ensures this colorscheme loads first
    opts = {
        plugins = {
             lazy = true,
             alpha = true,
             markdown = false,
             noice = true,
             neotree = true,
             lazygit = true,
        },
    },
    config = function(_,opts)
    require("neopywal").setup(opts)
    vim.cmd.colorscheme("neopywal")
    end,
}
