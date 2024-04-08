local Utils = require("core.utils")

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"windwp/nvim-ts-autotag",
			event = "VeryLazy",
		},
	},
	init = function()
		Utils.lazy_load("nvim-treesitter")
	end,
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",
	opts = function()
		return {
			ensure_installed = {
				"bash",
				"c",
				"cmake",
				"comment",
				"cpp",
				"css",
				"csv",
				"cuda",
				"dart",
				"diff",
				"dockerfile",
				"fish",
				"gitignore",
				"glsl",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"graphql",
				"http",
				"html",
				"java",
				"javascript",
				"jsdoc",
				"json",
				"json5",
				"kotlin",
				"latex",
				"llvm",
				"lua",
				"luadoc",
				"make",
				"markdown",
				"prisma",
				"python",
				"r",
				"regex",
				"rust",
				"sql",
				"scss",
				"svelte",
				"swift",
				"sxhkdrc",
				"terraform",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"xml",
				"yaml",
			},

			highlight = {
				enable = true,
				use_languagetree = true,
			},

			indent = {
				enable = true,
			},
			context_commentstring = {
				enable = true,
			},
			autotag = { enable = true },
			auto_install = true,
		}
	end,
	config = function(_, opts)
		require("ts_context_commentstring").setup({})
		vim.g.skip_ts_context_commentstring_module = true
		require("nvim-treesitter.configs").setup(opts)
	end,
}
