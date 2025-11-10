return { -- You can easily change to a different colorscheme.
	--   -- Change the name of the colorscheme plugin below, and then
	--   -- change the command in the config to whatever the name of that colorscheme is.
	--   --
	--   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	"olimorris/onedarkpro.nvim",
	-- priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		vim.cmd("colorscheme onedark_dark")

		vim.cmd([[
        hi Comment gui=none
        hi Normal guibg=none ctermbg=none
        hi NormalNC guibg=none ctermbg=none
        hi SignColumn guibg=none ctermbg=none
        hi EndOfBuffer guibg=none ctermbg=none
        hi MsgArea guibg=none ctermbg=none
      ]])
	end,
}
