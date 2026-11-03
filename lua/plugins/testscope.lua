-- Prefer a local checkout (for hacking on the plugin); otherwise install from GitHub.
local local_checkout = vim.fn.expand("~/Projects/testscope.nvim")

return {
	"butadpj/testscope.nvim",
	dir = vim.fn.isdirectory(local_checkout) == 1 and local_checkout or nil,
	build = "npm install",
	cmd = { "Testscope", "TestscopeClose" },
	keys = {
		{ "<leader>tt", "<cmd>Testscope<cr>", desc = "Browse tests" },
	},
}
