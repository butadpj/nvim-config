return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false, -- neo-tree will lazily load itself
	---@module "neo-tree"
	---@type neotree.Config?
	keys = {
		{ "<C-b>", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
	},
		opts = {
			filesystem = {
				window = {
					mappings = {
						["<C-b>"] = "close_window",
						["Y"] = function(state)
							local node = state.tree:get_node()
							local abs_path = vim.fn.fnamemodify(node:get_id(), ":p")
							local root_path = vim.fn.fnamemodify(state.path or vim.loop.cwd(), ":p")
							local rel_path = vim.fn.fnamemodify(abs_path, ":.")

							if abs_path:sub(1, #root_path) == root_path then
								rel_path = abs_path:sub(#root_path + 1)
								if rel_path == "" then
									rel_path = "."
								end
							end

							vim.fn.setreg("+", rel_path)
							vim.notify("Copied: " .. rel_path)
						end,
					},
				},
			},
		},
	}
