return {
	"sindrets/diffview.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	keys = {
		{ "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
		{ "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
		{ "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History" },
		{ "<leader>df", "<cmd>DiffviewFileHistory %<cr>", desc = "(Current file) Diffview File History" },
	},
	config = true, -- Uses default settings
}
