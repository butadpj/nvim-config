return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },

		-- Useful for getting IDE-like "Find in folder" feature
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			-- This will not install any breaking changes.
			-- For major updates, this must be adjusted manually.
			version = "^1.0.0",
		},
	},
	config = function()
		-- Telescope is a fuzzy finder that comes with a lot of different things that
		-- it can fuzzy find! It's more than just a "file finder", it can search
		-- many different aspects of Neovim, your workspace, LSP, and more!
		--
		-- The easiest way to use Telescope, is to start by doing something like:
		--  :Telescope help_tags
		--
		-- After running this command, a window will open up and you're able to
		-- type in the prompt window. You'll see a list of `help_tags` options and
		-- a corresponding preview of the help.
		--
		-- Two important keymaps to use while in Telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			pickers = {
				live_grep = {
					-- Don't include the filename in the search results
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "live_grep_args")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s,", builtin.oldfiles, { desc = "[S]earch Recent Files (global)" })
		vim.keymap.set("n", "<leader>s.", function()
			local root = (vim.uv or vim.loop).cwd() or vim.fn.getcwd()
			builtin.oldfiles({
				cwd = root,
				only_cwd = true,
			})
		end, { desc = "[S]earch Recent Files (current working directory)" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Live grep w/ args extension configuration START --
		local conf = require("telescope.config").values

		local function extend_vimgrep_args(extra_args)
			local args = vim.deepcopy(conf.vimgrep_arguments)
			if extra_args then
				for _, arg in ipairs(extra_args) do
					table.insert(args, arg)
				end
			end
			return args
		end

		vim.keymap.set("n", "<leader>fgg", function()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end, { desc = "Live grep with args" })

		vim.keymap.set("n", "<leader>fgw", function()
			require("telescope").extensions.live_grep_args.live_grep_args({
				vimgrep_arguments = extend_vimgrep_args({ "-w" }),
			})
		end, { desc = "Live grep with args (Match whole word)" })

		vim.keymap.set("n", "<leader>fgs", function()
			require("telescope").extensions.live_grep_args.live_grep_args({
				vimgrep_arguments = extend_vimgrep_args({ "-w", "-s" }),
			})
		end, { desc = "Live grep with args (Match whole word & case)" })

		vim.keymap.set("n", "<leader>fcc", function()
			require("telescope").extensions.live_grep_args.live_grep_args({
				search_dirs = { vim.fn.expand("%:p") },
			})
		end, { desc = "Live Grep current file with args" })

		vim.keymap.set("n", "<leader>fcw", function()
			require("telescope").extensions.live_grep_args.live_grep_args({
				search_dirs = { vim.fn.expand("%:p") },
				vimgrep_arguments = extend_vimgrep_args({ "-w" }),
			})
		end, { desc = "Live Grep current file with args (Match whole word)" })

		vim.keymap.set("n", "<leader>fcs", function()
			require("telescope").extensions.live_grep_args.live_grep_args({
				search_dirs = { vim.fn.expand("%:p") },
				vimgrep_arguments = extend_vimgrep_args({ "-w", "-s" }),
			})
		end, { desc = "Live Grep current file with args (Match whole word & case)" })
		-- Live grep args extension configuration END --

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
