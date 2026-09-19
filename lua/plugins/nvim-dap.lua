return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { desc = "DAP: " .. desc })
		end

		map("<F5>", dap.continue, "Start/Continue")
		map("<F9>", dap.toggle_breakpoint, "ToggleBreakpoint")
		map("<F10>", dap.step_over, "Step Over")
		map("<F3>", dap.step_into, "Step Into")
		map("<F4>", dap.step_out, "Step Out")
		map("<F6>", dap.run_to_cursor, "Run to Cursor")
		map("<F7>", dap.restart, "Restart")
		map("<F8>", dap.terminate, "Terminate")
		map("<F12>", dapui.toggle, "Toggle Debug UI")
		map("<leader>de", function()
			require("dap.ui.widgets").hover()
		end, "Eval/Hover")
		map("<leader>tv", function()
			require("nvim-dap-virtual-text").toggle()
		end, "Toggle Debug Inline Variables")

		dapui.setup({
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.45 },
						{ id = "watches", size = 0.2 },
						{ id = "stacks", size = 0.2 },
						{ id = "breakpoints", size = 0.15 },
					},
					position = "left",
					size = 44,
				},
				{
					elements = {
						{ id = "repl", size = 1.0 },
					},
					position = "bottom",
					size = 12,
				},
			},
		})

		require("nvim-dap-virtual-text").setup({
			enabled = true,
			enabled_commands = true,
			virt_text_pos = "eol",
			all_references = false,
		})

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Go adapter and configs (uses Delve, installed via Mason as 'delve')
		local function go_module_root()
			local buf = vim.api.nvim_buf_get_name(0)
			local start = buf ~= "" and vim.fs.dirname(buf) or vim.fn.getcwd()
			local go_mod = vim.fs.find("go.mod", {
				upward = true,
				path = start,
			})[1]
			return go_mod and vim.fs.dirname(go_mod) or start
		end

		local function go_debug_output_path()
			local dir = vim.fs.joinpath(vim.fn.stdpath("cache"), "dap", "go")
			vim.fn.mkdir(dir, "p")
			return vim.fs.joinpath(dir, "__debug_bin")
		end

		local delve = vim.fn.exepath("dlv")
		if delve == "" then
			vim.notify("Delve (dlv) not found in PATH; Go DAP will fail", vim.log.levels.WARN)
		end

		dap.adapters.go = function(callback, config)
			-- Remote attach: connect to an already-running delve DAP server.
			if config.request == "attach" and config.mode == "remote" then
				callback({
					type = "server",
					host = config.host or "127.0.0.1",
					port = config.port or 2345,
				})
				return
			end

			-- Launch mode: start a fresh delve DAP server on a random local port.
			callback({
				type = "server",
				port = "${port}",
				executable = {
					command = delve ~= "" and delve or "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
					detached = true,
					cwd = go_module_root(),
				},
			})
		end

		dap.configurations.go = {
			{
				type = "go",
				name = "Debug file",
				request = "launch",
				program = "${file}",
			},
			{
				type = "go",
				name = "Debug package",
				request = "launch",
				program = "${fileDirname}",
			},
			{
				type = "go",
				name = "Debug test (file)",
				request = "launch",
				mode = "test",
				program = "${file}",
			},
			{
				type = "go",
				name = "Debug test (package)",
				request = "launch",
				mode = "test",
				program = "${fileDirname}",
			},
			{
				type = "go",
				name = "Attach remote :2345",
				request = "attach",
				mode = "remote",
				host = "127.0.0.1",
				port = 2345,
				cwd = "${workspaceFolder}",
				substitutePath = {
					{
						from = "/home/ubuntu/Projects/prosple/lightspeed",
						to = "/app",
					},
				},
			},
		}

		-- Ensure cwd/output are set before each launch (helps monorepos + sandboxed envs)
		dap.listeners.before.launch.go = function(_, config)
			config.cwd = config.cwd or go_module_root()
			config.output = config.output or go_debug_output_path()
		end
	end,
}
