require("core.options")
require("core.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("core.lspconfig"), -- Main LSP Config
	require("plugins.lazydev"), -- Plugin manager
	require("plugins.conform"), -- Autoformatting
	require("plugins.nvim-cmp"), -- Autocompletion
	require("plugins.neo-tree"), -- File explorer
	require("plugins.autopairs"), -- Blocks auto pair
	require("plugins.treesitter"), -- Advance syntax highlighting
	require("plugins.gitsigns"), -- Git signs for code lines
	require("plugins.diffview"), -- Git diff view
	require("plugins.tokyonight"), -- Theme (from VS Code's TokyoNight)
	require("plugins.telescope"), -- File search
	require("plugins.which-key"), -- Key mapping docs
	require("plugins.todo-comments"), -- Highlights TODO comments
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
