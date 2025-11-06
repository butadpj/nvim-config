return {
	"sindrets/diffview.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	keys = {
		{ "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
		{ "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
		{ "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History" },
		{ "<leader>df", "<cmd>DiffviewFileHistory %<cr>", desc = "(Current file) Diffview File History" },
	},
	-- Open file under cursor and closes the DiffView
	config = function()
		local diffview = require("diffview")
		local actions = require("diffview.actions")
		local lib = require("diffview.lib")
		local diffview_config = require("diffview.config")

		local keymaps = vim.deepcopy(diffview_config.defaults.keymaps)

		local function open_file_and_close_view()
			local view = lib.get_current_view()
			local diffview_tab = view and view.tabpage

			actions.goto_file_edit()

			if view and diffview_tab and vim.api.nvim_get_current_tabpage() ~= diffview_tab then
				vim.schedule(function()
					if view.tabpage and vim.api.nvim_tabpage_is_valid(view.tabpage) then
						view:close()
					end
				end)
			end
		end

		table.insert(keymaps.view, {
			"n",
			"<leader>do",
			open_file_and_close_view,
			{ desc = "Open file in current tab and close Diffview" },
		})
		table.insert(keymaps.file_panel, {
			"n",
			"<leader>do",
			open_file_and_close_view,
			{ desc = "Open file in current tab and close Diffview" },
		})

		diffview.setup({
			keymaps = keymaps,
		})

		vim.api.nvim_create_user_command("DiffviewOpenFile", open_file_and_close_view, {
			desc = "Open the Diffview file under the cursor in the editing tab",
		})
	end,
}
